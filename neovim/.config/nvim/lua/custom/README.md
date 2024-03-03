
## Install

1. Make sure that you have python3-venv installed, the Mason plugin is going to install some packages, and it may need it. You can install python3-venv with `apt install python3-venv`.
2. Install [Neovim](https://neovim.io/).
3. Install [NvChad](https://nvchad.com/).
4. Copy the custom configuration files.
   ```
   git clone https://github.com/aams-eam/nvchad-aams-custom.git ~/.config/nvim/lua/custom/
   ```
5. You are done! For other configurations and possible errors you can refer to this post: [Using Neovim as IDE with NvChad](https://aamseam.com/posts/using-neovim-as-ide-with-nvchad/).

## Plugins list

This configuration adds the following plugins and configurations to NvChad:
- Configured some LSP servers.
    - For Python files [python-lsp-server](https://github.com/python-lsp/python-lsp-server).
    - For Latex, Markdown, text. I consider it very useful when writing in markdown, [ltex-lsp](https://valentjn.github.io/ltex/).
- Installed [none-ls](https://github.com/nvimtools/none-ls.nvim) for configuring LSP, Linters, and formatters.
- Configured Python formatter [black](https://pypi.org/project/black/). Also configured the text formatter to be executed automatically when saving a file.
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) configured with adaptative size and relative numbers.
- Configured the floating terminal to be bigger, [nvterm](https://github.com/NvChad/nvterm).
- Plugins installed for debugging.
    - DAP client [nvim-dap](https://github.com/mfussenegger/nvim-dap).
    - Maintain breakpoints after closing files, [persistent-breakpoints](https://github.com/Weissle/persistent-breakpoints.nvim).
    - DAP adapters and configurations for Python [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python).
    - Graphic User Interface for debugging [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui).
    - Facilitate the installation of new adapters [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim)

