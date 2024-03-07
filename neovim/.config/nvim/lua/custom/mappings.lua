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
return M

