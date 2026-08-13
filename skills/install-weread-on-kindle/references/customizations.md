# Post-install customizations

## Contents

- MiuRead plugin mode
- Automatic shelf startup and resume
- Official Kindle sleep images
- Underline
- Swipe animation

## MiuRead plugin mode

Use **插件模式** to retain standard KOReader. “觅阅桌面” is a different runtime surface and has separate suspend/lock behavior. Do not switch modes silently.

Pin MiuRead 4.3.0 for the validated setup. Defer update prompts until the release diff and sleep/background changes have been reviewed. Do not copy authentication settings from another device.

## Automatic shelf startup and resume

The bundled `../assets/patches/2-auto-miuread-shelf.lua` is validated with KOReader 2026.03 and MiuRead 4.3.0. Copy it to the active KOReader `patches/` directory only after backing up `settings.reader.lua` and existing patches.

The patch:

- forces KOReader to start from the file manager so the plugin is available;
- retrieves the initialized MiuRead instance from `PluginLoader`;
- opens “我的书架” after startup in plugin mode;
- wraps both file-manager and reader plugin instances;
- records whether the shelf was visible before suspend;
- restores the shelf only in that case;
- leaves a book page unchanged when the user slept while reading.

This distinction matters because MiuRead 4.3.0 marks its plugin shelf as transient and closes it on suspend. Patching only the file-manager instance fails when the shelf was opened over a reader instance.

Verify three cases: fresh KOReader start, sleep/wake from shelf, and sleep/wake from an open book.

## Official Kindle sleep images

Choose one strategy.

### Use the current Kindle's native framework

For the verified PW4/KPM device, install `../assets/patches/2-kindle-native-screensaver-passthrough.lua`. This prevents KOReader from drawing a second image after the framework's stock image.

### Use exported official images in KOReader

For the verified PW3, 20 images exported read-only from the PW4 system were copied to:

```text
/mnt/us/koreader/screensavers/kpw4-native/
```

Install `../assets/patches/2-random-kpw4-official-screensavers.lua`. The images were 1072×1448, matching both devices. Verify dimensions and hashes before reuse.

If the user requests official-only images, back up and delete any previous mixed/generated directory from the Kindle. Keep only the selected official folder. Remove macOS `._` files from directories written by the task.

## Underline

Use KOReader's built-in annotation style. Set `Underline` as the default and verify it persists after closing/reopening the EPUB. Do not add a separate underline patch unless the user asks for behavior KOReader cannot provide.

## Swipe animation

Treat Swipe Animation as a KOReader core overlay, not an ordinary `.koplugin`:

1. Back up all of `koreader/` or at least the exact overwritten core files.
2. Audit the release against the installed KOReader version.
3. Merge files with a deterministic copy tool; do not rely on ambiguous Finder folder replacement.
4. For Swipe Animation 3.5 on KOReader 2026.03, the verified overlay touched:
   - `ffi/framebuffer.lua`;
   - `frontend/device/generic/device.lua`;
   - `frontend/ui/uimanager.lua`;
   - `frontend/device/swipe_animation_patch.lua`.
5. Run LuaJIT syntax checks on all modified Lua files.
6. Test portrait, landscape, page direction, twenty page turns, and sleep/wake.

The verified devices used a direction-reversed `uimanager.lua` because the upstream visual direction felt opposite to the user's intuition. Do not assume every user wants this inversion.
