---
name: install-weread-on-kindle
description: Diagnose and implement a stability-first Kindle WeChat Reading setup using jailbreak where required, KOReader, and the MiuRead/觅阅 WeRead plugin. Use when Codex is asked to install, reproduce, repair, audit, or roll back 微信读书/觅阅 on a Kindle; choose a compatible jailbreak for Kindle Paperwhite 3/PW3/KPW3 or Paperwhite 4/PW4/KPW4; work with legacy KUAL/MRPI or Sanctuary/KPM; configure one-tap KOReader launch, automatic MiuRead shelf opening, official Kindle sleep images, swipe animation, OTA blocking, or related troubleshooting.
---

# Install WeRead on Kindle

## Goal

Build a stable, reversible path from a stock Kindle to WeChat Reading through KOReader and MiuRead. Treat every firmware and launcher combination as device-specific. Preserve the native reader, books, progress, account registration, and rollback path.

## Route references

Read [compatibility.md](references/compatibility.md) for every task. Then load only the relevant device guide:

- Read [kpw3-winterbreak.md](references/kpw3-winterbreak.md) for PW3/KPW3 or a legacy KUAL/MRPI installation.
- Read [kpw4-sanctuary.md](references/kpw4-sanctuary.md) for PW4/KPW4 on Sanctuary/KPM.
- Read [customizations.md](references/customizations.md) when configuring automatic shelf opening, sleep images, underline, or swipe animation.
- Read [troubleshooting.md](references/troubleshooting.md) when any checkpoint differs from the expected result.

Use bundled patches only with the validated KOReader 2026.03 + MiuRead 4.3.0 combination unless a fresh source audit proves compatibility.

## Non-negotiable rules

1. Verify the exact Kindle model and firmware from **Device Info** before downloading or writing anything. Do not infer them from generation names alone.
2. Recheck current support on upstream KindleModding and author release pages. Firmware/jailbreak support is time-sensitive; the known-good matrix is evidence, not a universal rule.
3. Do not upgrade, downgrade, deregister, change account region, or factory-reset unless the user explicitly authorizes that exact action after hearing that it may be irreversible.
4. Never mix the legacy KUAL/MRPI stack with Sanctuary/KPM. Do not install old hotfix, KUAL, MRPI, or `renameotabin` packages on a Sanctuary/KPM device unless current upstream documentation explicitly requires them.
5. Fully exit KOReader before exposing Kindle USB storage. Do not write files while KOReader is running from the exported partition.
6. Back up the visible USB partition, including hidden directories, before jailbreak and before overwriting KOReader core files. Create a file list and SHA-256 manifest.
7. Do not display or record a full device serial number. Do not copy MiuRead credentials, cookies, tokens, device IDs, or private crash-log URLs off the Kindle. Redact secrets when inspecting logs.
8. Use only upstream/author packages. Record URL, version, package name, and SHA-256. Statistically inspect Lua and shell files; reject unknown repacks and cloud-drive bundles.
9. Disable OTA before normal Wi-Fi use after jailbreak. Verify the actual stack-specific mechanism instead of merely trusting a menu label.
10. Stop at any failed checkpoint. Do not stack retries, firmware packages, or recovery actions on an unexplained failure.

## Workflow

### 1. Establish scope and success criteria

Confirm whether the user wants only WeChat Reading or also:

- one-tap KOReader entry;
- plugin mode with automatic “我的书架”;
- official Kindle sleep images;
- KOReader underline;
- swipe animation;
- Bluetooth/page-turn accessories.

Default to stability: retain the current working firmware, pin known-good versions, and omit unsupported accessories.

### 2. Perform a read-only audit

Ask the user to exit KOReader and connect USB. Run:

```sh
scripts/audit-kindle-mount.sh /Volumes/Kindle
```

Also obtain the model and firmware from the Kindle screen. Distinguish these layouts:

- legacy: `/mnt/us/koreader/`, `/mnt/us/extensions/`, `/mnt/us/mrpackages/`;
- KPM: `/mnt/us/kmc/kpm/packages/koreader/koreader/`.

If both layouts appear active, stop and determine which launcher actually runs KOReader.

### 3. Research before choosing a jailbreak

Open the current upstream jailbreak page for the exact firmware/model and verify:

- supported firmware interval;
- required package variant;
- whether an update is mandatory;
- whether downgrade is supported;
- post-jailbreak launcher stack;
- OTA-disable procedure.

Prefer current primary sources: KindleModding documentation, KOReader GitHub releases/wiki, MiuRead GitHub releases, KPM repository/manifest, and the plugin author's repository. Treat social posts as UI hints, not package authorities.

Present the proposed combination and irreversible steps before changing firmware.

### 4. Back up and audit packages

Copy the visible partition to a timestamped workspace directory without following links outside the mount. Preserve hidden entries. Generate:

- `FILELIST.txt`;
- `SHA256SUMS.txt`;
- a package inventory with source URLs and hashes.

Keep account/auth material on the Kindle when possible. Back up only the minimum settings needed for rollback.

For Lua files, run LuaJIT bytecode compilation as a syntax check. For shell files, run `sh -n`. Statically inspect third-party files for destructive commands, network endpoints, credential reads, and writes to system partitions.

### 5. Execute the selected device route

Follow the matching reference guide. Separate computer-side and Kindle-side actions. After every user-side action, request the observed screen text before continuing.

Use explicit checkpoints such as:

- jailbreak marker exists and `;log` responds;
- hotfix or KPM initialization completed;
- OTA disable is verified;
- KOReader launches and exits cleanly;
- MiuRead plugin mode opens and authenticates.

### 6. Install KOReader and MiuRead

Use the package variant specified in the compatibility guide. Install the complete `miuread.koplugin` directory under the active KOReader `plugins/` directory. Do not migrate authentication files between Kindles.

Ask the user to complete WeChat QR authorization on-device. Verify the account shelf, download/open one book, save progress, close, and reopen it.

If MiuRead offers an unreviewed update, defer it until its diff, release source, and device behavior have been audited.

### 7. Apply optional customizations separately

Back up settings before installing each optional layer. Apply and verify one layer at a time:

1. one-tap launcher;
2. automatic MiuRead shelf patch;
3. official sleep-image configuration;
4. built-in KOReader underline;
5. swipe animation.

Never combine an unverified background plugin, page-turn patch, and KOReader core update in one write operation.

### 8. Verify and hand off

Require the user to confirm:

- native Kindle reading and existing books still work;
- KOReader launches once and exits to the native UI;
- MiuRead login, shelf, download, reading, and progress persistence work;
- automatic shelf startup works when enabled;
- sleeping on the shelf returns to the shelf, while sleeping in a book returns to the same page;
- official sleep images behave as selected, without double-image switching;
- underline survives close/reopen;
- swipe direction matches the user's intuition in portrait and landscape;
- Wi-Fi does not create a firmware-update temporary file.

Save final version/hash/path records and rollback backups. Remind the user to exit KOReader before future USB connections.

## Rollback order

Use the smallest rollback that fixes the problem:

1. Remove or restore the affected `.koplugin`.
2. Restore the pre-patch `koreader/` core backup.
3. Remove the specific userpatch and restore `settings.reader.lua`.
4. Restore copied sleep-image directories.
5. Leave jailbreak and the native Kindle system untouched unless the user explicitly requests a separately researched uninstall.

Do not factory-reset as a troubleshooting shortcut.
