if not G_reader_settings:isTrue("kpw4_native_screensavers_configured") then
    G_reader_settings:saveSetting("screensaver_type", "random_image")
    G_reader_settings:saveSetting("screensaver_dir", "/mnt/us/koreader/screensavers/kpw4-native")
    G_reader_settings:saveSetting("screensaver_img_background", "white")
    G_reader_settings:makeFalse("screensaver_show_message")
    G_reader_settings:makeFalse("screensaver_stretch_images")
    G_reader_settings:makeFalse("screensaver_rotate_auto_for_best_fit")
    G_reader_settings:makeFalse("screensaver_cycle_images_alphabetically")
    G_reader_settings:saveSetting("screensaver_delay", "disable")
    G_reader_settings:makeTrue("kpw4_native_screensavers_configured")
end
