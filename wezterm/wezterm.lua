-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("CaskaydiaMono Nerd Font", { weight = "ExtraBold" })

config.font_size = 20.0

config.color_scheme = "Kanagawa (Gogh)"

-- Your existing keybindings
config.keys = {
        {
                key = "s",
                mods = "CMD|SHIFT",
                action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
        },
        {
                key = "a",
                mods = "CMD|SHIFT",
                action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
        },
        {
                key = "w",
                mods = "CMD",
                action = wezterm.action.CloseCurrentPane({ confirm = true }),
        }
}

config.use_fancy_tab_bar = false

config.colors = {
        background = "black",
        tab_bar = {
                background = "black",
                active_tab = {
                        bg_color = "#000000",
                        fg_color = "#c0c0c0",
                        intensity = "Normal",
                        underline = "None",
                        italic = false,
                        strikethrough = false,
                },
                inactive_tab = {
                        bg_color = "#000000",
                        fg_color = "#808080",
                },
                new_tab = {
                        bg_color = "#000000",
                        fg_color = "#808080",
                },
        },
}

config.tab_bar_at_bottom = true

config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"

-- This is fine to be outside the config object, as it's an event handler.
wezterm.on("format-window-title", function()
        return ":3"
end)

-- and finally, return the configuration to wezterm
return config -- <-- Simply return the 'config' object you've built!
