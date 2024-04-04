local M = {}

M.general = {
  n = {
     ["<C-b>"] = {"<C-d>zz", "Go down a page"},
     ["<C-f>"] = {"<C-u>zz", "Go up a page"},
     ["<C-d>"] = {"<C-d>zz", "Go down half a page"},
     ["<C-u>"] = {"<C-u>zz", "Go up half a page"},
     ["n"] = {"nzz", "Find next occurence"},
     ["N"] = {"Nzz", "Find previous occurence"},
     ["<leader>gg"] = { "<cmd> LazyGit <CR>", "Open LazyGit" },
     ["<leader>gr"] = { function() require("telescope.extensions.lazygit").lazygit() end, "Open LazyGit" },
  },
}

M.disabled = {
  n = {
    -- cycle through buffers
    ["<tab>"] = {""},
    ["<S-tab>"] = {""},

  }
}

M.telescope = {
  n = {
    ["<leader>fb"] = {
      function()
        require("telescope.builtin").buffers(
          {
            ignore_current_buffer=true,
            sort_mru=true,
          }
        )
      end,
      "Find Buffers" },
  }
}

M.dap = {
  plugin = true,
  n = {
    ["<F5>"] = {
      function()
        require('dap.ext.vscode').load_launchjs() -- Load launch.json every time we debug
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
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
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

return M

