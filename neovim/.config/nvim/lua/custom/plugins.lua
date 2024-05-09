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
        "gopls",
        "gofumpt",
        "goimports-reviser",
        "golines",
        "delve",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        adaptive_size = true,
        relativenumber = true,
        side = "right",
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
    ft = { "python", "go" },
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
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<Tab>"] = require('cmp').mapping.confirm {
          behavior = require('cmp').ConfirmBehavior.Insert,
          select = true,
        },
        ["<CR>"] = {},
      }
    }
  },

  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },

  -- Have persistent breakpoints
  {
    'Weissle/persistent-breakpoints.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('persistent-breakpoints').setup {
        load_breakpoints_event = { "BufReadPost" }
      }
      require("core.utils").load_mappings("persistent_breakpoints")
    end,
    lazy = false,
  },

  {
    "nvim-neotest/nvim-nio"
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
        layouts = { {
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
        } },
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
      require "custom.configs.dap-python"
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

  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },

  {
    "dreamsofcode-io/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! toInstallDeps]]
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'
  },

  {
    "pteroctopus/faster.nvim",
    lazy = false,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
}

return plugins
