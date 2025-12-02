# ~/.zshrc — adapted from .bashrc for Zsh

# Set history options
HISTSIZE=1000
SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY

# Prompt setup
autoload -Uz colors && colors
autoload -Uz promptinit && promptinit
prompt adam1

# Terminal title
case "$TERM" in
  xterm*|rxvt*)
    precmd() { print -Pn "\e]0;%n@%m: %~\a" }
    ;;
esac

# Enable ls colors and aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

# Grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Aliases from your original setup
alias alert='osascript -e "display notification \"Command finished\" with title \"Terminal\""'
alias py="python3"
alias t="tmux"
alias v="nvim"
alias sv="sudo -E nvim"
alias k="kubectl"
alias dotfiles="cd $HOME/.local/src/dotfiles/"
alias src="cd $HOME/.local/src/"
alias sb="cd $HOME/Syncthing/SecondBrain/ && nvim ."
alias claude="/home/aams-eam/.claude/local/claude"

# kubectl completion (zsh version)
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  compdef _kubectl k
fi

export PATH="$HOME/.local/bin:$PATH"

# Export all envs from a file
exportallenvs() {
  set -a
  source "$1"
  set +a
}


# ctrl+f for tmux-sessionizer
bindkey -s ^f "tmux-sessionizer\n"

# Source local overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alejandroantonio.moreno/.local/src/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/alejandroantonio.moreno/.local/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alejandroantonio.moreno/.local/src/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/alejandroantonio.moreno/.local/src/google-cloud-sdk/completion.zsh.inc'; fi
