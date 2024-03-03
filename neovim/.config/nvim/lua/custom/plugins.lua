local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "python-lsp-server",
        "black",
        "ltex-ls",
        "json-lsp",
        "jq",
        "yaml-language-server",
        "clangd",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
        relativenumber = true,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      },
    },
  },

  {

    "NvChad/nvterm",
    opts = {
      terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
          float = {
            relative = 'editor',
            row = 0.1,
            col = 0.1,
            width = 0.8,
            height = 0.7,
            border = "single",
          },
          horizontal = { location = "rightbelow", split_ratio = .3, },
          vertical = { location = "rightbelow", split_ratio = .5 },
        }
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.none-ls"
    end,
  },

  -- Navigate in between Neovim and tmux panes
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
        -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set('n', '<F5>', function()
        require('dap.ext.vscode').load_launchjs() -- Load launch.json every time we debug
        require('dap').continue() end)
      vim.keymap.set('n', '<F6>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F7>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<leader>dG', function() require('dap').run_to_cursor() end)
    end,
    lazy = false,
  },

  -- Have persistent breakpoints
  {
    'Weissle/persistent-breakpoints.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      vim.keymap.set('n', '<leader>db', function() require("persistent-breakpoints.api").toggle_breakpoint() end)
      vim.keymap.set('n', '<leader>dc',
        function() require('persistent-breakpoints.api').set_conditional_breakpoint() end)
      vim.keymap.set('n', '<leader>du', function() require('persistent-breakpoints.api').clear_all_breakpoints() end)
      require('persistent-breakpoints').setup{
        load_breakpoints_event = { "BufReadPost" }
      }
    end,
    lazy = false,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup({
        layouts = {{
          elements = { {
              id = "scopes",
              size = 0.55
            }, {
              id = "breakpoints",
              size = 0.15
            }, {
              id = "stacks",
              size = 0.15
            }, {
              id = "watches",
              size = 0.15
            } },
          position = "left",
          size = 50
        }, {
          elements = { {
              id = "repl",
              size = 0.3
            }, {
              id = "console",
              size = 0.7
            } },
          position = "bottom",
          size = 10
        }},
      })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- Uncomment for dap-ui GUI to close automatically after finishing a debugging session
      -- dap.listeners.before.event_terminated['dapui_config'] = function()
      --   dapui.close()
      -- end

      -- dap.listeners.before.event_exited['dapui_config'] = function()
      --   dapui.close()
      -- end
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require("dap-python").setup()
      vim.keymap.set('n', '<F4>', function() require('dap-python').debug_selection() end)
    end,
    lazy = false,
  },

  {
    "aams-eam/nvim-dap-python-ssh",
    dependencies = {
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      require("dap-python-ssh").setup()
    end,
    lazy = false,
  },

  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    dependencies =  {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
    lazy = false,
  },
}

return plugins
