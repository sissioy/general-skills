# PW4 / Sanctuary and KPM route

## Contents

- Preconditions and firmware changes
- Sanctuary checkpoints
- KPM and KOReader
- MiuRead and one-tap entry
- Native sleep screen
- Verification and rollback

## Preconditions and firmware changes

Use this route only when the current Sanctuary support matrix covers the exact PW4 firmware. The verified device was upgraded with explicit user authorization from 5.16.8 to official 5.18.1; that firmware change was treated as one-way.

Never upgrade merely because Sanctuary worked in this snapshot. First check for a no-update path. Explain that an official firmware update may close downgrade/jailbreak options.

## Sanctuary checkpoints

Follow the current Sanctuary guide rather than reconstructing exploit steps from screenshots. On the verified device, useful success evidence included:

- the expected download-completion state;
- the normal 29-page **Getting Started** document;
- exploit execution text followed by `restarting GUI`;
- a `JAILBROKEN` document/marker;
- a response to `;log`.

An “application error” dialog after GUI restart did not override positive marker and `;log` evidence. Evaluate all checkpoints together. If neither marker nor `;log` succeeds, stop.

Do not install the legacy KUAL/MRPI/hotfix/`renameotabin` stack on this route. Use KMC/KPM and the Sanctuary-specific OTA mechanism documented upstream.

## KPM and KOReader

Install the current official KOReader KPM package that matches the device. The verified configuration used KOReader 2026.03 `kindlehf` at:

```text
/mnt/us/kmc/kpm/packages/koreader/koreader/
```

Launch diagnostically with:

```text
;kpm launch koreader
```

Verify clean start and exit before adding plugins.

## MiuRead and one-tap entry

Install MiuRead 4.3.0 at:

```text
/mnt/us/kmc/kpm/packages/koreader/koreader/plugins/miuread.koplugin/
```

Select plugin mode, authorize WeChat on-device, and verify a real book and progress.

For a library-visible one-tap entry, create `/mnt/us/documents/KOReader.sh` with Unix line endings:

```sh
#!/bin/sh

exec /var/local/kmc/bin/kpm launch koreader
```

Do not embed credentials or use a wrapper that silently retries failed launches.

Install `../assets/patches/2-auto-miuread-shelf.lua` under the active KPM KOReader `patches/` directory when automatic plugin-mode shelf opening is requested.

## Native sleep screen

On the verified ad-free PW4, KOReader random-image mode caused a visible two-image transition: the Kindle framework first drew one native image, then KOReader drew another. Use `../assets/patches/2-kindle-native-screensaver-passthrough.lua` to leave the screen unchanged inside KOReader and let the framework retain its own stock sleep image.

If exporting stock images for another device, use a one-time root script that only reads `/usr/share/blanket/screensaver/bg_ss*.png` and copies to USB. Remove the one-time script after verifying the copies. The verified export contained 20 images at 1072×1448. Do not modify the system source directory.

## Verification and rollback

Verify:

- `JAILBROKEN` marker and `;log` response;
- KPM launches KOReader from both command and one-tap document;
- MiuRead login/read/progress work;
- OTA remains disabled;
- native system and books remain usable;
- sleeping shows one stock image without a second-image jump.

Rollback userpatches or the KPM KOReader package before touching the Sanctuary base. Do not install legacy recovery packages to fix a KPM application problem.
