if not G_reader_settings:isTrue("kindle_native_screensaver_passthrough_configured") then
    G_reader_settings:saveSetting("screensaver_type", "disable")
    G_reader_settings:makeFalse("screensaver_show_message")
    G_reader_settings:saveSetting("screensaver_delay", "disable")
    G_reader_settings:makeTrue("kindle_native_screensaver_passthrough_configured")
end
