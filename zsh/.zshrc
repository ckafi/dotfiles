fpath+="${ZDOTDIR}/functions"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# External configs
eval $(dircolors ~/.dircolors)
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Fuzzy finding
whence fzf >/dev/null && \
  source /usr/share/fzf/completion.zsh && \
  source /usr/share/fzf/key-bindings.zsh

[[ -n $WAYLAND_DISPLAY ]] && export NVR_CMD=nvim-qt

# Options for less
LESS="-iJM"
# begin blinking
LESS_TERMCAP_mb=$(tput blink)
# begin bold
LESS_TERMCAP_md=$(tput setaf 2)
# end mode
LESS_TERMCAP_me=$(tput sgr0)
# begin standout-mode - info box
LESS_TERMCAP_so=$(tput smso; tput setaf 4; tput setab 15)
# end standout-mode
LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# begin underline
LESS_TERMCAP_us=$(tput smul; tput setaf 6)
# end underline
LESS_TERMCAP_ue=$(tput rmul; tput sgr0)

export SUDO_PROMPT="[sudo] $USER@$HOST's passwd: "

bindkey "^K" insert-last-word
bindkey "^B" history-beginning-search-backward
bindkey "^E" push-input

alias o="mimeo"
alias p="yay"
alias u="systemctl --user"
alias psgrep="ps -ef | grep -i"
alias ext="aunpack"
alias diff='diff --color=auto'
alias nt='fork alacritty'
alias t=" task"
alias to=" taskopen"
alias in=" task add +inbox"
alias ls="exa -F"
alias la="ls -a"
alias ll="ls -lgh --color-scale --git"
alias lla="ll -a"


alias re="nvr --remote-silent"
nvim-server() {
  if [[ -n $NVIM_LISTEN_ADDRESS ]]; then
    echo "Server environment already set"
    return 1
  fi
  local socket_path="/tmp/nvim_sockets"
  mkdir $socket_path 2>/dev/null
  export NVIM_LISTEN_ADDRESS=${socket_path}/$(echo ${(qq)PWD} | tr -cd '[:alpha:]')
}


fvi () {
  fd -c always -t f . $1 | \
    fzf --preview='bat --color always {}' \
        --bind='enter:execute-silent(nvr --remote-silent {+})+clear-selection,?:toggle-preview'
}

fo () {
  fd -c always -t f . $1 | \
    fzf --bind='enter:execute-silent(mimeo {+})+clear-selection'
}

fcd () {
  cd $(fd -t d . $1 | fzf --no-multi)
}

ff () {
  fd -c always $1 | fzf
}


up () {
  local ups
  if [[ -z $1 ]]; then
    1=1
  fi
  for i in {1..$1}; do
    ups+='../'
  done
  cd $ups
}
