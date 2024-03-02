local wezterm = require 'wezterm'
local config = {}

-- In case you install it in WSL
-- config.default_domain = 'WSL:Ubuntu'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font "UbuntuMono Nerd Font"
config.font_size = 15
config.keys = {
  {
    key = 'F11',
    action = wezterm.action.ToggleFullScreen,
  },
}

return config

