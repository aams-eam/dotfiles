#!/bin/bash

# User vars
export ME=$SUDO_USER

# Script vars
MYHOME="/home/$ME"
ASME="sudo -u $ME"
NVIM_VERSION="v0.11.7"
NVIM_TARBALL="/tmp/nvim-linux-x86_64-${NVIM_VERSION}.tar.gz"
NVIM_TARBALL_URL="https://github.com/neovim/neovim-releases/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"

# helper functions
function _echo() { printf "\n╓───── %s \n╙────────────────────────────────────── ─ ─ \n" "$1"; }

[ "$(id -u)" -ne 0 ] && {
	_echo "got root?" >&2
	exit 1
}

_echo "installing runtime deps"
apt update && apt install -y git gpg bash curl locales gnupg software-properties-common libevent-dev ncurses-dev build-essential bison pkg-config

_echo "installing packages"
apt update && apt install -y \
		bash \
		bash-completion \
		ca-certificates \
		clamav-base \
		coreutils \
		curl \
		dash \
		git \
		gzip \
		jq \
		python3 \
		python3-boto \
		python3-pip \
		python3-venv \
		ripgrep \
		stow \
		tree \
		unzip \
		whois \
		ninja-build \
		gettext \
		cmake \
		automake \
		npm \
		xsel

# i do not want these dirs to be symlinks
_echo "creating directory skeletons"
$ASME mkdir -p \
	$MYHOME/.{config,local} \
	$MYHOME/.local/{bin,docs,cache,lib,share,src,state} \
	$MYHOME/.local/state/zsh

# lazygit
_echo "installing lazygit"
curl -sSL https://github.com/jesseduffield/lazygit/releases/download/v0.40.2/lazygit_0.40.2_Linux_x86_64.tar.gz | tar -zxvf - -C $MYHOME/.local/bin lazygit

# tmux-sessionizer
_echo "installing tmux-sessionizer"
curl -L https://raw.githubusercontent.com/ThePrimeagen/tmux-sessionizer/7edf8211e36368c29ffc0d2c6d5d2d350b4d729b/tmux-sessionizer -o $MYHOME/.local/bin/tmux-sessionizer
chmod +x $MYHOME/.local/bin/tmux-sessionizer

# nvim
_echo "installing neovim ${NVIM_VERSION}"
$ASME curl -L "$NVIM_TARBALL_URL" -o "$NVIM_TARBALL"
$ASME tar -C "$MYHOME/.local" --strip-components=1 -xzf "$NVIM_TARBALL"
$MYHOME/.local/bin/nvim --version | head -n 3

_echo "clonning nvim nvchad"
	$ASME git clone --branch v2.0 --single-branch https://github.com/NvChad/NvChad.git $MYHOME/.config/nvim

_echo "delete .bashrc .gitconfig and .wezterm.lua"
$ASME rm $MYHOME/.bashrc $MYHOME/.gitconfig $MYHOME/.wezterm.lua

_echo "setting up dotfiles"
$ASME git clone https://github.com/aams-eam/dotfiles.git $MYHOME/.local/src/dotfiles &&
	cd $MYHOME/.local/src/dotfiles &&
	$ASME stow bash git karabiner neovim tmux tmux-sessionizer wezterm -t $MYHOME

# nvim base nvchad
_echo "Installing nvim plugins"
$ASME $MYHOME/.local/bin/nvim --headless "+Lazy! sync" +qa
$ASME $MYHOME/.local/bin/nvim --headless "+MasonInstallAll" +qa

# tmux
_echo "building tmux"
$ASME git clone https://github.com/tmux/tmux.git $MYHOME/.local/src/tmux &&
  cd $MYHOME/.local/src/tmux &&
  sh autogen.sh &&
  ./configure &&
  make &&
  make install

_echo "setting up tmux plugins"
$ASME mkdir -p $MYHOME/.config/tmux/plugins &&
	$ASME git clone --depth=1 https://github.com/tmux-plugins/tpm $MYHOME/.config/tmux/plugins/tpm &&
	$ASME $MYHOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh

# Source bashrc
_echo "Execute the following and you are good to go!"
echo "source $MYHOME/.bashrc"
