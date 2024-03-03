#!/bin/bash

# User vars
export ME='ghostu'

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

# nvim
_echo "building neovim"
$ASME git clone --depth=1 https://github.com/neovim/neovim.git -b stable $MYHOME/.local/src/neovim &&
	cd $MYHOME/.local/src/neovim &&
	make CMAKE_BUILD_TYPE=RelWithDebInfo &&
	make install

_echo "clonning nvim nvchad"
	$ASME git clone --single-branch https://github.com/NvChad/NvChad.git $MYHOME/.config/nvim

_echo "delete .bashrc"
$ASME rm $MYHOME/.bashrc

_echo "setting up dotfiles"
$ASME git clone https://github.com/aams-eam/dotfiles.git $MYHOME/.local/src/dotfiles &&
	cd $MYHOME/.local/src/dotfiles &&
	$ASME stow bash git neovim tmux wezterm -t $MYHOME

# Source bashrc
source $MYHOME/.bashrc

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
  $ASME make &&
  make install

_echo "setting up tmux plugins"
$ASME mkdir -p $MYHOME/.config/tmux/plugins &&
	$ASME git clone --depth=1 https://github.com/tmux-plugins/tpm $MYHOME/.config/tmux/plugins/tpm &&
	$ASME $MYHOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh

_echo "creating ~src, ~docs, and ~dotfiles aliases"
useradd -g src -d $MYHOME/.local/src src
useradd -d $MYHOME/.local/src/dotfiles dotfiles
useradd -d $MYHOME/docs docs
