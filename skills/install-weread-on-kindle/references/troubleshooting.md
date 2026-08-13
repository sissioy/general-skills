# Troubleshooting checkpoints

## Contents

- Jailbreak symptoms
- Launcher and hotfix symptoms
- KOReader and MiuRead symptoms
- Sleep-screen symptoms
- USB and log safety

## Jailbreak symptoms

| Symptom | Interpretation and next action |
|---|---|
| WinterBreak page shows `308 redirecting` | Open the current canonical URL from upstream docs. If the Kindle browser cannot reach the redirected host, stop and research an official alternative; do not change accounts or install an untrusted proxy package. |
| Clicking Jailbreak shows no response | Recheck the exact package placement, free-space prerequisite, browser support, and firmware/model matrix. Do not keep clicking or add another exploit package. |
| `UPDATE ERROR 2` | Treat the update/hotfix package as rejected or incompatible. Remove only the exact failed package after reconnecting; verify model, firmware, filename, package type, and guide step before retrying. |
| `;log` becomes ordinary search | Jailbreak is not confirmed. Stop post-jailbreak installation. |
| GUI restarts and shows “application error” | Check the exploit's durable success marker and `;log`. A transient UI error alone does not prove failure or success. |
| `JAILBROKEN` exists and `;log` responds | Record the checkpoint, enable the required OTA protection, and continue with the matching launcher stack. |

## Launcher and hotfix symptoms

| Symptom | Interpretation and next action |
|---|---|
| “Run Hotfix” stays white for over three minutes | Short-press sleep/wake once, reconnect USB, and inspect logs/state. Do not factory-reset. |
| `No user script found` | The launcher could not locate a script. Verify the exact expected directory, filename, Unix line endings, and script content. Do not infer that the entire jailbreak failed. |
| KPM requires `;kpm launch koreader` every time | After a successful diagnostic launch, add the verified `/mnt/us/documents/KOReader.sh` one-tap wrapper. |
| KOReader application error after adding a patch | Exit/reconnect, inspect the tail of `crash.log`, restore the specific pre-patch files, and remove only the new patch. |

## KOReader and MiuRead symptoms

| Symptom | Interpretation and next action |
|---|---|
| MiuRead starts in its desktop surface | Switch to **插件模式** if the requested behavior is standard KOReader plus shelf. Restart fully when prompted. |
| Automatic shelf patch loads but stays in file manager | Confirm `Applying patch` in `crash.log`; confirm runtime says `plugin`; retrieve the initialized instance through `PluginLoader:getPluginInstance("miuread")`. The userpatch callback receives the plugin class, not the initialized instance. |
| Shelf sleep wakes to the last book | MiuRead closed the transient shelf on suspend over a reader instance. Install the resume wrapper on every MiuRead instance, not only the file-manager instance. Record visibility before calling the original `onSuspend`. |
| Book sleep wakes to shelf | The restore condition is too broad. Restore only when `_shelf_view` existed, was not closed, and was shown before suspend. |
| MiuRead offers a new version | Defer by default on a stable device. Download and statically audit the author release before updating; back up the plugin and settings first. |

## Sleep-screen symptoms

| Symptom | Interpretation and next action |
|---|---|
| One stock image appears, then another image replaces it | Kindle framework and KOReader are both drawing. On the verified ad-free PW4, set KOReader to leave the screen unchanged and use native-framework passthrough. |
| Random folder shows nonofficial art | Inspect all folders referenced by `screensaver_dir`. Back up and remove mixed/generated folders when the user requests official-only images. |
| Images stretch, rotate, or show text | Verify 1072×1448 source dimensions, disable stretch/autorotate/message, set white fill, and remove macOS `._` files. |

## USB and log safety

- If the volume does not mount, try a known data cable/port and wake the Kindle. Do not repeatedly reboot during an incomplete write.
- Always exit KOReader before USB mass storage.
- Read only the relevant crash-log tail. Redact cookie, token, session, `skey`, `uid`, OTP, device ID, and signed URL values.
- Never publish a full serial number.
- After writing, run `sync`, compare source/device SHA-256, clean only task-created `._` files, and safely eject.
