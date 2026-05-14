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
autoload -Uz compinit && compinit
prompt adam1

precmd_venv() {
  [[ -n "$VIRTUAL_ENV" ]] && PROMPT="%F{yellow}($(basename $VIRTUAL_ENV))%f $PROMPT"
}
precmd_functions+=(precmd_venv)

# Terminal title
case "$TERM" in
  xterm*|rxvt*)
    precmd_title() { print -Pn "\e]0;%n@%m: %~\a" }
    precmd_functions+=(precmd_title)
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

# Ctrl+Left / Ctrl+Right move by word (Linux-style; macOS zsh doesn't bind these by default)
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Source local overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"


# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/src/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/src/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/src/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/src/google-cloud-sdk/completion.zsh.inc"; fi

# To prevent deleting a full path when doing option+backspace
WORDCHARS=${WORDCHARS//\/}

export PATH="$HOME/local/bin:$PATH"

# TARIQ Academy — quick launch
tariq() { cd "$HOME/tariq-academy" && source "$HOME/.config/tariq/env" 2>/dev/null && claude; }
