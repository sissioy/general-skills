local userpatch = require("userpatch")
local UIManager = require("ui/uimanager")
local logger = require("logger")

local shelf_scheduled = false

-- The automatic shelf workflow expects KOReader to create FileManager first.
G_reader_settings:saveSetting("start_with", "filemanager")

userpatch.registerPatchPluginFunc("miuread", function()
    local PluginLoader = require("pluginloader")
    local plugin = PluginLoader:getPluginInstance("miuread")
    if type(plugin) ~= "table" or not plugin.ui then
        return
    end
    if type(plugin._home_enabled) == "function" then
        local ok, home_enabled = pcall(plugin._home_enabled, plugin)
        if ok and home_enabled then
            return
        end
    end
    if type(plugin.show_shelf) ~= "function" then
        return
    end

    local original_on_suspend = plugin.onSuspend
    local original_on_resume = plugin.onResume
    if not plugin._auto_shelf_resume_restore_installed
        and original_on_suspend and original_on_resume then
        plugin._auto_shelf_resume_restore_installed = true

        plugin.onSuspend = function(self, ...)
            local view = self._shelf_view
            self._auto_reopen_shelf_after_resume = view ~= nil
                and view._miu_closed ~= true
                and UIManager:isWidgetShown(view)
            return original_on_suspend(self, ...)
        end

        plugin.onResume = function(self, ...)
            local reopen_shelf = self._auto_reopen_shelf_after_resume == true
            self._auto_reopen_shelf_after_resume = false
            local result = original_on_resume(self, ...)
            if reopen_shelf and self.ui then
                UIManager:scheduleIn(0.35, function()
                    if not self.ui then
                        return
                    end
                    local current = self._shelf_view
                    if current and current._miu_closed ~= true
                        and UIManager:isWidgetShown(current) then
                        return
                    end
                    local ok, err = pcall(self.show_shelf, self, false, false, "account")
                    if not ok then
                        logger.warn("Restoring MiuRead shelf after resume failed", tostring(err))
                    end
                end)
            end
            return result
        end
    end

    if shelf_scheduled or plugin.ui.document then
        return
    end

    shelf_scheduled = true
    UIManager:scheduleIn(1.8, function()
        if not plugin.ui or plugin.ui.document then
            return
        end
        local ok, err = pcall(plugin.show_shelf, plugin, false, false, "account")
        if not ok then
            logger.warn("Auto-opening MiuRead shelf failed", tostring(err))
        end
    end)
end)
