-- Ensure Homebrew's bin is on PATH so LSP subprocesses (e.g. jsonls calling
-- node) work when nvim is launched from a GUI context like NvimOpener.app,
-- where the inherited PATH does not include /opt/homebrew/bin.
if vim.fn.isdirectory("/opt/homebrew/bin") == 1 then
  vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH
end

if vim.fn.executable("xclip") == 1 then
  vim.g.clipboard = {
    name = "xclip",
    copy = {
      ["+"] = "xclip -selection clipboard",
      ["*"] = "xclip -selection primary",
    },
    paste = {
      ["+"] = "xclip -selection clipboard -o",
      ["*"] = "xclip -selection primary -o",
    },
    cache_enabled = 0,
  }
end

vim.o.relativenumber = true
vim.opt.conceallevel = 1

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Make sure truecolor is on (required for guibg to show)
vim.opt.termguicolors = true

-- Add background color for diffs
vim.opt.fillchars:append({ diff = " " })
local function set_diff_hl()
    vim.cmd([[
      highlight DiffAdd    guifg=NONE guibg=#203d25
      highlight DiffDelete guifg=NONE guibg=#3d2020
      highlight DiffChange guifg=NONE guibg=#2a2a2a
      highlight DiffText   guifg=NONE guibg=#264d36 gui=bold
    ]])

  -- -- If you use :Gitsigns preview_hunk_inline / word_diff, make those pop too:
  pcall(vim.api.nvim_set_hl, 0, "GitSignsAddInline",    { fg = "NONE", bg = "#203d25" })
  pcall(vim.api.nvim_set_hl, 0, "GitSignsDeleteInline", { fg = "NONE", bg = "#3d2020" })
  pcall(vim.api.nvim_set_hl, 0, "GitSignsChangeInline", { fg = "NONE", bg = "#2a2a2a" })
end

-- Re-apply after any colorscheme change and once at startup
vim.api.nvim_create_autocmd({ "ColorScheme", "User" }, {
  pattern = { "*", "GitSignsAttach" },
  callback = set_diff_hl,
})
set_diff_hl()
