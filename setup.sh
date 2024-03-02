# helper functions
function _echo() { printf "\n╓───── %s \n╙────────────────────────────────────── ─ ─ \n" "$1"; }

[ "$(id -u)" -ne 0 ] && {
	_echo "got root?" >&2
	exit 1
}

_echo "installing runtime deps"
apt update && apt install -y git gpg bash curl locales gnupg software-properties-common

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
		xsel

# i do not want these dirs to be symlinks
_echo "creating directory skeletons"
mkdir -p \
	$HOME/.{config,local} \
	$HOME/.local/{bin,docs,cache,lib,share,src,state} \
	$HOME/.local/state/zsh

_echo "building neovim"
git clone --depth=1 https://github.com/neovim/neovim.git -b stable $HOME/.local/src/neovim &&
	cd $HOME/.local/src/neovim &&
	make CMAKE_BUILD_TYPE=RelWithDebInfo &&
	make install

_echo "building tmux"

_echo "setting up dotfiles"
git clone git@github.com:xero/dotfiles.git $HOME/.local/src/dotfiles &&
	cd $HOME/.local/src/dotfiles &&
	stow bin fun git gpg ssh tmux neovim zsh -t $HOME
# tmux
mkdir $HOME/.config/tmux/plugins &&
	git clone --depth=1 https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm &&
	$HOME/.config/tmux/plugins/tpm/scripts/install_plugins.sh
# nvim
mkdir $HOME/.local/nvim &&
	git clone --filter=blob:none --single-branch https://github.com/folke/lazy.nvim.git $HOME/.local/share/nvim/lazy
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonInstallAll" +qa

_echo "creating ~src, ~docs, and ~dotfiles aliases"
useradd -g src -d $HOME/.local/src src
useradd -d $HOME/.local/src/dotfiles dotfiles
useradd -d $HOME/docs docs
