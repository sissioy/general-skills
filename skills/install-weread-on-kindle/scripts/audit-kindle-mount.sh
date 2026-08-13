#!/bin/sh

set -eu

mount_root=${1:-/Volumes/Kindle}

if [ ! -d "$mount_root" ]; then
    printf 'ERROR: Kindle mount not found: %s\n' "$mount_root" >&2
    exit 2
fi

legacy_root="$mount_root/koreader"
kpm_root="$mount_root/kmc/kpm/packages/koreader/koreader"

legacy_found=false
kpm_found=false
[ -d "$legacy_root" ] && legacy_found=true
[ -d "$kpm_root" ] && kpm_found=true

printf 'Mount: %s\n' "$mount_root"
printf 'Free space: '
df -h "$mount_root" | awk 'NR == 2 { print $4 " available of " $2 }'

if [ "$legacy_found" = true ] && [ "$kpm_found" = true ]; then
    printf 'Stack: AMBIGUOUS (legacy and KPM layouts both exist)\n'
    printf 'Legacy root: %s\n' "$legacy_root"
    printf 'KPM root: %s\n' "$kpm_root"
    exit 3
elif [ "$legacy_found" = true ]; then
    active_root=$legacy_root
    printf 'Stack: legacy KUAL/MRPI-style KOReader\n'
elif [ "$kpm_found" = true ]; then
    active_root=$kpm_root
    printf 'Stack: Sanctuary/KPM-style KOReader\n'
else
    printf 'Stack: no KOReader installation detected\n'
    printf 'Firmware/model: read from Kindle Device Info (not exposed reliably over USB)\n'
    exit 0
fi

printf 'Active KOReader root: %s\n' "$active_root"

if [ -f "$active_root/crash.log" ]; then
    version=$(sed -n 's/.*\[\*\] Version: \([^[:space:]]*\).*/\1/p' "$active_root/crash.log" | tail -n 1)
    [ -n "$version" ] && printf 'KOReader log version: %s\n' "$version"
fi

meta="$active_root/plugins/miuread.koplugin/_meta.lua"
if [ -f "$meta" ]; then
    miuread_version=$(sed -n 's/.*version[[:space:]]*=[[:space:]]*"\([^"]*\)".*/\1/p' "$meta" | head -n 1)
    printf 'MiuRead plugin: present'
    [ -n "$miuread_version" ] && printf ' (version %s)' "$miuread_version"
    printf '\n'
else
    printf 'MiuRead plugin: not detected\n'
fi

if [ -f "$active_root/crash.log" ]; then
    runtime=$(sed -n 's/.*\[MiuRead\]\[Mode\] runtime frozen \([^[:space:]]*\).*/\1/p' "$active_root/crash.log" | tail -n 1)
    [ -n "$runtime" ] && printf 'Last MiuRead runtime: %s\n' "$runtime"
fi

patch_count=0
[ -d "$active_root/patches" ] && patch_count=$(find "$active_root/patches" -maxdepth 1 -type f -name '*.lua' | wc -l | tr -d ' ')
printf 'Userpatch Lua files: %s\n' "$patch_count"

screen_count=0
[ -d "$active_root/screensavers" ] && screen_count=$(find "$active_root/screensavers" -type f -name '*.png' ! -name '._*' | wc -l | tr -d ' ')
printf 'KOReader PNG sleep images: %s\n' "$screen_count"

printf 'Root-level firmware update candidates:\n'
find "$mount_root" -maxdepth 1 -type f -name 'update*.bin*' -print 2>/dev/null || true

printf 'Privacy: serial numbers and MiuRead credential files were not inspected.\n'
