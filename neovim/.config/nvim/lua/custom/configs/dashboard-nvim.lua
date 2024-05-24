local options = {
  theme = 'doom',
  config = {
    header = require('custom.configs.banner'),
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        key_hl = 'Number',
        desc = 'New Buffer',
        key = 'b',
        keymap = 'SPC b',
        action = ':enew'
      },
      {
        icon = '󰈞 ',
        icon_hl = 'Title',
        key_hl = 'Number',
        desc = 'Find Files',
        key = 'f',
        keymap = 'SPC f a',
        action = 'lua require("telescope.builtin").find_files({follow=true, no_ignore=true, hidden=true})'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        key_hl = 'Number',
        desc = 'Go to Dotfiles',
        key = 'd',
        action = ':cd ~/.local/src/dotfiles'
      },
      {
        icon = '󰩈 ',
        icon_hl = 'Title',
        key_hl = 'Number',
        desc = 'Exit',
        key = 'q',
        keymap = ':q',
        action = ':q'
      },
    },
    footer = {}
  }
}

return options
