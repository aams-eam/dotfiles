#!/bin/bash

# User vars
export ME=$SUDO_USER

# Script vars
MYHOME="/home/$ME"
ASME="sudo -u $ME"

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

# nvim
_echo "building neovim"
$ASME git clone --depth=1 https://github.com/neovim/neovim.git -b stable $MYHOME/.local/src/neovim &&
	cd $MYHOME/.local/src/neovim &&
	make CMAKE_BUILD_TYPE=RelWithDebInfo &&
	make install

_echo "clonning nvim nvchad"
	$ASME git clone --branch v2.0 --single-branch https://github.com/NvChad/NvChad.git $MYHOME/.config/nvim

_echo "delete .bashrc .gitconfig and .wezterm.lua"
$ASME rm $MYHOME/.bashrc $MYHOME/.gitconfig $MYHOME/.wezterm.lua

_echo "setting up dotfiles"
$ASME git clone https://github.com/aams-eam/dotfiles.git $MYHOME/.local/src/dotfiles &&
	cd $MYHOME/.local/src/dotfiles &&
	$ASME stow bash git neovim tmux wezterm -t $MYHOME

# nvim base nvchad
_echo "Installing nvim plugins"
$ASME nvim --headless "+Lazy! sync" +qa
$ASME nvim --headless "+MasonInstallAll" +qa

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

_echo "creating ~src, ~docs, and ~dotfiles aliases"
useradd -g src -d $MYHOME/.local/src src
useradd -d $MYHOME/.local/src/dotfiles dotfiles
useradd -d $MYHOME/docs docs

# Source bashrc
_echo "Execute the following and you are good to go!"
echo "source $MYHOME/.bashrc"
