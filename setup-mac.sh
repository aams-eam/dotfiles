#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Please run this script as a regular user (no sudo)."
    exit 1
fi

export ME="$USER"
MYHOME="/Users/$ME"

function _echo() {
    printf "\n╓───── %s \n╙───────────────────────────────────────────────\n" "$1"
}

_echo "Installing Homebrew (if not already installed)"
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

_echo "Installing packages with Homebrew"
brew update
brew install \
    bash \
    bash-completion@2 \
    coreutils \
    dash \
    git \
    gnupg \
    jq \
    python \
    ripgrep \
    stow \
    tree \
    whois \
    ninja \
    gettext \
    cmake \
    automake \
    pkg-config \
    node \
    clamav \
    lazygit \
    neovim \
    tmux

_echo "Creating directory skeletons"
mkdir -p \
    "$MYHOME/.config" \
    "$MYHOME/.local"/{bin,docs,cache,lib,share,src,state} \
    "$MYHOME/.local/state/zsh"

_echo "Lazygit installed via Homebrew"
_echo "Neovim installed via Homebrew"
_echo "Cloning NvChad into nvim config"
git clone --branch v2.0 --depth=1 https://github.com/NvChad/NvChad.git "$MYHOME/.config/nvim"

_echo "Removing old dotfiles (.zshrc, .gitconfig, .wezterm.lua)"
rm -f "$MYHOME/.zshrc" "$MYHOME/.gitconfig" "$MYHOME/.wezterm.lua"

_echo "Setting up dotfiles with stow"
git clone https://github.com/aams-eam/dotfiles.git "$MYHOME/.local/src/dotfiles" &&
    cd "$MYHOME/.local/src/dotfiles" &&
    stow zsh git neovim tmux wezterm -t "$MYHOME"

_echo "Installing Neovim plugins (Lazy and Mason)"
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonInstallAll" +qa

_echo "Tmux installed via Homebrew"
_echo "Setting up Tmux plugins"
mkdir -p "$MYHOME/.config/tmux/plugins"
git clone --depth=1 https://github.com/tmux-plugins/tpm "$MYHOME/.config/tmux/plugins/tpm"
"$MYHOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh"

# Install tmux-sessionizer
curl -L https://raw.githubusercontent.com/ThePrimeagen/tmux-sessionizer/7edf8211e36368c29ffc0d2c6d5d2d350b4d729b/tmux-sessionizer \
  -o "$HOME/.local/bin/tmux-sessionizer" && \
chmod +x "$HOME/.local/bin/tmux-sessionizer"

_echo "Creating ~/src, ~/docs, and ~/dotfiles symlinks"
ln -sf "$MYHOME/.local/src" "$MYHOME/src"
ln -sf "$MYHOME/.local/src/dotfiles" "$MYHOME/dotfiles"
ln -sf "$MYHOME/.local/docs" "$MYHOME/docs"

_echo "Done! Run the following command to load your new Zsh config:"
echo "    source $MYHOME/.zshrc"

