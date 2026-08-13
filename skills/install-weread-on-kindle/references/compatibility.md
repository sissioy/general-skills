# Compatibility and source map

## Contents

- Known-good configurations
- Decision rules
- Authoritative sources
- Package and path rules

## Known-good configurations

These combinations were installed and user-verified on 2026-08-12. Treat them as reproducible snapshots, not current universal support claims.

| Device | Firmware | Jailbreak/launcher | KOReader | MiuRead | Verified result |
|---|---:|---|---|---|---|
| Kindle Paperwhite 3 (PW3/KPW3) | 5.14.3.0.1 | WinterBreak2, Universal Hotfix, PEKI KUAL, MRPI, `renameotabin` | 2026.03 `kindlepw2` | 4.3.0 plugin mode | WeRead login/read/progress, automatic shelf, resume-to-shelf, swipe animation, custom official-image folder |
| Kindle Paperwhite 4 (PW4/KPW4) | 5.18.1 | Sanctuary, KMC/KPM | 2026.03 `kindlehf` KPM package | 4.3.0 plugin mode | WeRead login/read/progress, one-tap launcher, automatic shelf, swipe animation, native Kindle sleep-screen passthrough |

Observed package hashes:

- KOReader KPM 2026.03 `kindlehf`: `10c9ecf05c4c634d5e3acc39c435e83ca308222a800df17dc8f5701cebab058f`
- MiuRead 4.3.0 full ZIP: `260b4783385698421412888a502e250b30867d5b35ea3cb3920a143710db495e`
- Swipe Animation 3.5 ZIP: `00df5cb4cf5528c3525ee2fda583fcc5a5d494853b74a204ead23648521d6904`

Recompute downloads instead of trusting filenames. A hash mismatch means “different artifact,” not automatically “malicious”; stop and audit the current author release.

## Decision rules

1. Keep a working supported firmware whenever possible.
2. Never assume “below 5.18.3” implies one jailbreak supports every Kindle. Match exact model, firmware, and current upstream matrix.
3. For the verified PW3 snapshot, WinterBreak2 supported firmware below 5.16.4 at the time of installation. Recheck before reuse.
4. For the verified PW4 snapshot, the user explicitly authorized a one-way official update from 5.16.8 to 5.18.1 before using Sanctuary. Do not reproduce that update without fresh research and explicit consent.
5. Use `kindlepw2` for the verified PW3/old-firmware setup. Use the official KPM `kindlehf` package for the verified PW4/Sanctuary setup.
6. Do not install Bluetooth page-turn support merely because Bluetooth exists. Confirm the exact device/plugin support list first.

## Authoritative sources

Reopen and verify these at execution time:

- WinterBreak2: <https://kindlemodding.org/jailbreaking/WinterBreak2/>
- Sanctuary: <https://kindlemodding.org/jailbreaking/Sanctuary/>
- KUAL/MRPI: <https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/installing-kual-mrpi/>
- OTA disable: <https://kindlemodding.org/jailbreaking/Legacy/post-jailbreak/disable-ota.html>
- KPM: <https://github.com/KindleModding/KPM>
- KPM package manifest: <https://raw.githubusercontent.com/KindleModding/repo/main/manifest.v2.json>
- KOReader releases: <https://github.com/koreader/koreader/releases>
- KOReader Kindle installation: <https://github.com/koreader/koreader/wiki/Installation-on-Kindle-devices>
- MiuRead releases: <https://github.com/miumiupy98-art/miuread-koreader/releases>
- Swipe Animation: <https://github.com/MsReverie/Swipe_Animation.koplugin>

## Package and path rules

Legacy PW3 layout:

```text
/mnt/us/documents/
/mnt/us/extensions/
/mnt/us/mrpackages/
/mnt/us/koreader/
/mnt/us/koreader/plugins/miuread.koplugin/
/mnt/us/koreader/patches/
```

Sanctuary/KPM PW4 layout:

```text
/mnt/us/documents/KOReader.sh
/mnt/us/kmc/kpm/packages/koreader/koreader/
/mnt/us/kmc/kpm/packages/koreader/koreader/plugins/miuread.koplugin/
/mnt/us/kmc/kpm/packages/koreader/koreader/patches/
```

Resolve `/mnt/us` to the actual USB mount root, commonly `/Volumes/Kindle` on macOS. Do not hard-code a volume name without checking it.
