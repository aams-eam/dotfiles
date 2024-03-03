local M = {}

M.general = {
  n = {
     ["<C-d>"] = {"<C-d>zz", "Go down half a page"},
     ["<C-u>"] = {"<C-u>zz", "Go up half a page"},
     ["n"] = {"nzz", "Find next occurence"},
     ["N"] = {"Nzz", "Find previous occurence"},
     ["<leader>gg"] = { "<cmd> LazyGit <CR>", "Open LazyGit" },
     ["<leader>gr"] = { function() require("telescope").extensions.lazygit.lazygit() end, "Open LazyGit" },
  },
}

return M

