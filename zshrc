# A zsh start-up file
# Written by Tobias Frilling (tobias@frilling-online.de)
# but heavily influenced by grmls zshrc
# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/
# So feel free to use any line you want.

# Start tmux {{{
if [[ -n $SSH_CONNECTION \
   && -z $TMUX \
   && -z $SUDO_UID ]] \
   && whence tmux >/dev/null ; then
   exec tmux -2
fi
# }}}

# Miscellaneous {{{
# compile .zshrc if necessary
[[ ~/.zshrc -nt ~/.zshrc.zwc || ! -e ~/.zshrc.zwc ]] && \
  zcompile ~/.zshrc
# create a .zsh folder if none exists
[[ ! -d ~/.zsh ]] && mkdir ~/.zsh
# }}}

# Environment {{{
setopt all_export
PATH="$HOME/bin:$PATH"
# gcc coloring
[[ -d /usr/lib/colorgcc/bin ]] && PATH="/usr/lib/colorgcc/bin:$PATH"
HISTFILE=$HOME/.zsh/zhistory
HISTSIZE=50000
SAVEHIST=50000
PAGER="less"
VIEWER=$PAGER
EDITOR="vim"
whence nvim >/dev/null && EDITOR="nvim"
VISUAL=$EDITOR
NULLCMD="cat"
READNULLCMD=$PAGER
WORDCHARS+=":"
FZF_DEFAULT_OPTS="--reverse --multi"
# Options for less
LESS="-iJM"
# begin blinking
LESS_TERMCAP_mb=$(tput blink)
# begin bold
LESS_TERMCAP_md=$(tput bold; tput setaf 2)
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
unsetopt all_export
# }}}

# Options and modules {{{
ZOPTS=(
  'auto_pushd' # push dir onto dir stack
  'pushd_minus' # switch behav of cd +n/-n

  'correct' # correct spelling of commands
  'correct_all' # correct all arguments

  'extended_glob' # make # ~ ^ "magic"
  'glob_complete' # glob + tab = compl menu

  'extended_history' # save hist with timestamp
  'hist_ignore_all_dups' # new commands replaces old one
  'hist_ignore_space' # dont save if cmd starts with space 
  'share_history' # share hist between zsh insts
  'hist_verify' # dont exec hist expn, but reload line

  'no_menu_complete' # dont autoselect first match
  'list_packed' # print a smaller compl list
  'list_types' # add type ident mark to compl entries

  'prompt_subst' # perform subst in prompt
  'transient_rprompt' # remove right promt on accept cmd line

  'no_beep' # no beeping on error
  'no_clobber' # do not truncate exist. files
  'long_list_jobs' # list jobs in long format
  'rm_star_wait' # wait 10 sec before rm *
)

setopt $ZOPTS
unset ZOPTS

zmodload zsh/complist
autoload zmv
autoload -U compinit && compinit
autoload colors && colors
# }}}

# Aliases {{{
alias o="mimeo"
alias e="$EDITOR"
alias p="pacaur"
alias u="systemctl --user"

alias psgrep="ps -ef | grep"
alias rscp="rsync -rhP --no-whole-file --inplace"
alias rsmv="rscp --remove-source-files"
alias sc="systemctl"
alias -g copy="xsel --clipboard --input"
alias paste="xsel --clipboard --output"

alias -g grep="grep --color=auto"
alias cp="cp -iv"
alias rm="rm -v"
alias mv="mv -iv"
alias dirs="dirs -v"
alias mc="mc -x"
alias ls="ls -F --color=auto"
alias la="ls -A"
alias ll="ls -hl --time-style=posix-iso"
alias lla="ll -A"

alias sudo="sudo "
alias jrnl=" jrnl"

alias fe="f -e $EDITOR"
alias fo="f -e mimeo"
# }}}

# Key-bindings {{{
bindkey -v    # Vi-Keymap

insert-last-typed-word() { zle insert-last-word -- 0 -1 }
zle -N insert-last-typed-word
bindkey "^P"    insert-last-typed-word
bindkey "^K"    insert-last-word
bindkey "^B"    history-beginning-search-backward
bindkey "^F"    history-beginning-search-forward
bindkey "^[[5~" history-beginning-search-backward       # PgUp
bindkey "^[[6~" history-beginning-search-forward        # PgDown
bindkey "^E"    push-input
# bindkey "^H"    run-help
bindkey "^[[3~" vi-delete-char                          # Del
bindkey "^R"    history-incremental-search-backward


# for vicmd-keymap
bindkey -a "u"  undo
bindkey -a "^R" redo

case $TERM in
  linux | screen* )
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line ;;

  xterm* )
    bindkey "^[[H"  beginning-of-line
    bindkey "^[[F"  end-of-line
    bindkey "^H"    vi-backward-delete-char ;;

  *rxvt* )
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line ;;
esac
bindkey -M menuselect '+' accept-and-menu-complete
bindkey -M menuselect '#' accept-and-infer-next-history
# }}}

# External configs {{{
eval $(dircolors ~/.dircolors)
whence fasd >/dev/null && eval "$(fasd --init auto)"
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# }}}

# Completions {{{
# based on jdongs .zshrc v0.2.1
# TODO: Figure our what exactly this all does.
# No more cargo-culting.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# insert all expansions for expand completer
#zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
#zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## ignore completion functions (until the _ignored completer)
#zstyle ':completion:*:functions' ignored-patterns '_*'
#zstyle ':completion:*:*:*:users' ignored-patterns \
  #adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
  #named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
  #rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
  #avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
  #firebird gnats haldaemon hplip irc klog list man cupsys postfix\
  #proxy syslog www-data mldonkey sys snort
# }}}

# Functions {{{

fasd_fzf () {
  local -a param
  param=("${(f)$(fasd -lR${2} | fzf --no-sort -0 -1 -q $1)}")
  [[ -n $param ]] && echo "$param[@]" || return 1
}

za () { fasd_fzf "$*" a }
zd () { fasd_fzf "$*" d }
zf () { fasd_fzf "$*" f }

preexec () {
  title "${TAG:+($TAG) }" "$1"
  echo -n ${(%):-%f}
}

precmd () {
  title "${TAG:+($TAG) }" 'zsh %2~'
  if git branch &>/dev/null; then
    update_git_prompt
  else
    unset git_prompt
  fi

  # update_prompt
}

title () {
  local P=$@
  P=${(%)P}
  P=${(V)P}
  P=${(q)P}

  case $TERM in
    screen*)
      print -n "\ek$P\e\\" ;;
    linux)
      ;;
    *)
      print -n "\e]2;$P\a" ;;
  esac
}

update_git_prompt () {
  local git_status
  local git_branch_name
  local git_branch_status
  local git_commit_hash
  local git_tlights

  git_status=$(git status)

  [[ $git_status =~ 'Initial commit' ]] && \
    git_branch_name="Initial"

  if [[ -z $git_branch_name ]]; then
    git_branch_name=$(git rev-parse --abbrev-ref HEAD)
    git_commit_hash=$(git rev-parse --short HEAD)
  fi

  if [[ $git_status =~ 'Your branch and .* have diverged' ]]; then
    git_branch_status='d'
  elif [[ $git_status =~ 'Your branch is ahead of ' ]]; then
    git_branch_status='a'
  elif [[ $git_status =~ 'Your branch is behind ' ]]; then
    git_branch_status='b'
  fi
  git_tlights+=${git_branch_status:+%F\{111\}$git_branch_status}

  [[ $git_status =~ "Changes to be committed:" ]] && \
    git_tlights+="%F{green}s"
  [[ $git_status =~ "Changes not staged for commit:" ]] && \
    git_tlights+="%F{yellow}m"
  [[ $git_status =~ "Untracked files:" ]] && \
    git_tlights+="%F{red}u"

  git_prompt="%F{magenta}$git_branch_name"
  git_prompt+="${git_commit_hash:+.$git_commit_hash}"
  git_prompt+="${git_tlights:+%f($git_tlights%f)}%f"
}

ext () {
  for file in $@; do
    if [[ -f $file ]]; then
      case ${(L)file} in
        *.tar.lrz)           lrzuntar $file ;;
        *.lrz)               lrunzip $file ;;
        *.tar*|*.tgz|*.tbz)  tar -xvf $file ;;
        *.bz2)               bunzip2 $file ;;
        *.gz|*.z)            gunzip $file ;;
        *.zip|*.cbz)         unzip $file ;;
        *.rar|*.cbr)         unrar x $file ;;
        *.xz)                unxz $file ;;
        *.7z)                7z x $file ;;
        *) echo "'$file' is not a recognized archive format." ;;
      esac
    else
      echo "'$file' is not a valid file"
    fi
  done
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

cd () {
  if [[ $# -ge 3 ]]; then
    echo cd: too many arguments >&2
    return 1
  elif [[ $# -eq 2 ]]; then
    builtin cd $1 $2
  elif [[ $# -eq 1 ]]; then
    if [[ -f $1 ]]; then
      builtin cd $1:h
    else
      builtin cd $1
    fi
  else
    builtin cd
  fi
}

mkcd () {
  if [[ -d $1 ]]; then
    "\'$1\' already exists."
  else
    mkdir -p $1
  fi
  cd $1
}
# }}}

# Prompt {{{
  # All prompt and no work makes Tobias a poor boy
  # All prompt and no work makes Tobias a poor boy
  export SUDO_PROMPT="[sudo] $USER@$HOST's passwd: "
  PS2="%F{cyan}(%_)%f "

  PS1=''
  # hostname if in ssh or root
  [[ -n $SSH_CONNECTION || $UID == 0 ]] && PS1+='%F{green}%m%f:'
  # username
  PS1+='%F{blue}%n%f '
  # path with prefix, truncated to 55 characters
  PS1+='%F{yellow}%55<..<%~%<<%f'
  # git prompt if set
  PS1+='${git_prompt+ $git_prompt}'
  # jobs (if any)
  PS1+='%1(j. %F{cyan}%j%f.)'
  # exit code if >0
  PS1+='%(?.. %F{red}%?%f)'
  # newline
  PS1+=$'\n'
  # red text if root
  PS1+='%(!.%F{red}.)'
  # % or # based on privileges
  PS1+='%# '
# }}}

# vim: foldmethod=marker
