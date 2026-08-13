# PW3 / WinterBreak2 route

## Contents

- Preconditions
- Backup and OTA protection
- Jailbreak checkpoints
- Legacy post-jailbreak stack
- KOReader and MiuRead
- Verification and rollback

## Preconditions

Use this route only after the current WinterBreak2 support table confirms the exact PW3 firmware. The verified device was a PW3 on 5.14.3.0.1.

Retain the existing Kindle account and native system. Do not deregister or factory-reset.

## Backup and OTA protection

1. Exit KOReader if present and connect USB.
2. Back up the complete visible partition, including hidden directories.
3. Record a file list and SHA-256 manifest without exposing the full serial number.
4. Create a temporary filler file only when required by the current jailbreak guide. In the verified run, remaining space was constrained to 50–90 MB to reduce automatic-update risk.
5. Validate the exact filler path before creating or removing it. Never target the volume root with recursive deletion.

## Jailbreak checkpoints

Follow the current WinterBreak2 guide exactly. For the verified route:

1. Place the contents of `wb2.zip` at the Kindle USB root.
2. Confirm `jb.sh`, `patchedUks.sqsh`, and `winterbreak2/` exist.
3. Safely eject.
4. On Kindle, connect Wi-Fi and visit the current canonical WinterBreak2 page.
5. Trigger Jailbreak and wait for an explicit success signal.
6. Immediately enable airplane mode after success.
7. Reconnect USB, inspect/remove only a known `update.bin.tmp.partial`, then remove the exact filler file.

If the experimental browser shows `308 redirecting`, use the canonical URL from current upstream documentation. Do not improvise account changes, firmware updates, or untrusted proxy packages.

Verify jailbreak with `;log`. If it behaves as ordinary search, do not proceed.

## Legacy post-jailbreak stack

Install in this order:

1. Universal Hotfix; run once.
2. PEKI KUAL and MRPI from the current guide.
3. `renameotabin`; run `Rename` in KUAL.
4. Verify OTA is actually disabled before restoring normal Wi-Fi.

If “Run Hotfix” remains white for more than three minutes, short-press power to sleep, wake, reconnect USB, and inspect logs. Do not immediately factory-reset or reinstall multiple packages.

Do not interpret `No user script found` as proof that the jailbreak failed. It indicates that the invoked launcher did not find the expected script; verify the script path, filename, executable content, and line endings.

## KOReader and MiuRead

For the verified stack:

1. Install official KOReader 2026.03 `kindlepw2` under `/mnt/us/koreader/` plus its launcher files.
2. Launch from KUAL, then exit cleanly once.
3. Copy the complete MiuRead 4.3.0 directory to `/mnt/us/koreader/plugins/miuread.koplugin/`.
4. Select **插件模式** when asked. Do not select MiuRead desktop mode if the user wants standard KOReader with an automatically opened shelf.
5. Complete WeChat authorization on the Kindle.
6. Open/download one book and verify progress persistence.

For automatic shelf startup and resume behavior, install `../assets/patches/2-auto-miuread-shelf.lua` in `/mnt/us/koreader/patches/`. Read [customizations.md](customizations.md) before copying it.

## Verification and rollback

Verify:

- `;log` responds;
- KUAL and KOReader start/exit normally;
- native books and progress remain intact;
- OTA remains disabled with Wi-Fi on;
- MiuRead shelf/login/read/progress work;
- shelf sleep resumes to shelf, book sleep resumes to the same book.

Rollback only the affected layer. Restore pre-patch KOReader files for animation faults; remove only MiuRead or userpatch files for plugin faults. Do not remove the jailbreak or factory-reset as the first response.
