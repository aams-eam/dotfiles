local M = {}

M.general = {
  n = {
    ["<C-f>"] = {
      function()
        if vim.env.TMUX ~= nil and vim.env.TMUX ~= "" then
          vim.fn.jobstart({ "tmux", "neww", "tmux-sessionizer" }, { detach = true })
        else
          vim.fn.termopen("tmux-sessionizer")
          vim.cmd("startinsert")
        end
      end,
      "Tmux sessionizer",
    },
    ["<C-d>"] = { "<C-d>zz", "Go down half a page" },
    ["<C-u>"] = { "<C-u>zz", "Go up half a page" },
    ["n"] = { "nzz", "Find next occurence" },
    ["N"] = { "Nzz", "Find previous occurence" },
    ["<leader>tt"] = {
      function()
        require("base46").toggle_transparency()
      end,
      "Toggle transparency",
    },
  },
}

M.disabled = {
  n = {
    -- cycle through buffers
    ["<tab>"] = { "" },
    ["<S-tab>"] = { "" },

  }
}

M.nvimtree = {
  n = {
    ["<leader>e"] = { "" },
  },
}

M.telescope = {
  n = {
    ["<leader>fb"] = {
      function()
        require("telescope.builtin").buffers(
          {
            ignore_current_buffer = true,
            sort_mru = true,
          }
        )
      end,
      "Find Buffers" },
    ["<leader>fd"] = {
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          grouped = true,
          select_buffer = true,
          hidden = {
            file_browser = true,
            folder_browser = false
          },
        })
      end,
      "Open File Browser" },
  }
}

M.lazygit = {
  n = {
    ["<leader>gg"] = { "<cmd> LazyGit <CR>", "Open LazyGit" },
    ["<leader>gr"] = { function() require("telescope.extensions.lazygit").lazygit() end, "Open LazyGit" },
  }
}

M.trouble = {
  n = {
    ["<leader>et"] = { function() require("trouble").toggle("diagnostics") end, "Toggle trouble" },
    ["<leader>eq"] = { function() require("trouble").toggle("quickfix") end, "Toggle quickfix" },
    ["<leader>el"] = { function() require("trouble").toggle("lsp") end, "Toggle LSP definitions, references, implementations, type definitions, and declarations" },
    ["<leader>eL"] = { function() require("trouble").toggle("loclist") end, "Toggle loclist" },
    ["gr"] = { function() require("trouble").toggle("lsp_references") end, "Toggle lsp references" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<F5>"] = {
      function()
        require('dap.ext.vscode').load_launchjs(".debug/launch.json") -- Load launch.json every time we debug
        require('dap').continue()
      end,
      "Open debugging options/continue debugging"
    },
    ["<F6>"] = {
      function()
        require('dap').step_into()
      end,
      "Step into"
    },
    ["<F7>"] = {
      function()
        require('dap').step_over()
      end,
      "Step over"
    },
    ["<F8>"] = {
      function()
        require('dap').step_out()
      end,
      "Step out"
    },
    ["<leader>dG"] = {
      function()
        require('dap').run_to_cursor()
      end,
      "Run to cursor"
    },
    ["<leader>dsg"] = {
      function()
        require('dapui').toggle()
      end,
      "Open debugging gui"
    },
  }
}

M.persistent_breakpoints = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      function()
        require("persistent-breakpoints.api").toggle_breakpoint()
      end,
      "Add persistent breakpoint at line"
    },
    ["<leader>dc"] = {
      function()
        require("persistent-breakpoints.api").set_conditional_breakpoint()
      end,
      "Add persistent conditional breakpoint at line"
    },
    ["<leader>du"] = {
      function()
        require("persistent-breakpoints.api").clear_all_breakpoints()
      end,
      "Clear all persistent breakpoints"
    },
  },
}

M.dap_python = {
  n = {
    ["<leader>dps"] = {
      function()
        require("dap-python").debug_selection()
      end,
      "Python debug selection"
    },
    ["<leader>dpc"] = {
      function()
        require("dap-python").debug_selection()
      end,
      "Python test class"
    },
    ["<leader>dpm"] = {
      function()
        require("dap-python").debug_selection()
      end,
      "Python test methods"
    },
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gtj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gty"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.harpoon = {
  n = {
    ["<leader>A"] = { function() require("harpoon"):list():add() end, desc = "harpoon file", },
    ["<leader>a"] = {
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "harpoon quick menu",
    },
    ["<C-h>"] = { function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
    ["<C-j>"] = { function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
    ["<C-k>"] = { function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
    ["<C-l>"] = { function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
    ["<C-ñ>"] = { function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
  },
}

M.gitsigns = {
  n = {
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff this file",
    },
  },
}


return M
