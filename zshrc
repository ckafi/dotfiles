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
eval $(dircolors)
PATH="$HOME/bin:$PATH"
# gcc coloring
[[ -d /usr/lib/colorgcc/bin ]] && PATH="/usr/lib/colorgcc/bin:$PATH"
HISTFILE=$HOME/.zsh/zhistory
HISTSIZE=50000
SAVEHIST=50000
PAGER="less"
LESS="-iJM"
VIEWER=$PAGER
EDITOR="vim"
whence nvim >/dev/null && EDITOR="nvim"
VISUAL=$EDITOR
MAILPATH="/var/mail/${USER};/var/spool/mail/${USER}"
NULLCMD="cat"
READNULLCMD=$PAGER
WORDCHARS+=":"
SUDO_PROMPT="[sudo] $USER@$HOST's passwd: "
PS2="%F{173}(%_)%f "
#really annoying!
#WATCH=all
#WATCHFMT="%S%B%T: %n has %a (%M)"
unsetopt all_export
# }}}

# Options and modules {{{
ZOPTS=(
  'auto_pushd'
  'no_beep'
  'no_clobber'
  'correct'
  'correct_all'
  'extended_glob'
  'extended_history'
  'glob_complete'
  'hist_ignore_all_dups'
  'hist_ignore_space'
  'list_packed'
  'list_types'
  'mail_warning'
  'no_hup'
  'prompt_subst'
  'pushd_ignore_dups'
  'rm_star_wait'
  'share_history'
  'transient_rprompt'
)

setopt $ZOPTS
unset ZOPTS

zmodload zsh/mathfunc
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

whence fasd >/dev/null &&  eval "$(fasd --init auto)"
alias fe="f -e $EDITOR"
alias fo="f -e xdg-open"
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
bindkey "^H"    run-help
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
td () {
  task $@ pro:$PWD:t
}

warn () {
  beep -r 3
  echo "$bg[red]$fg_bold[white] !!! Warning !!! \a"
}

preexec () {
  title $1
  echo -n ${(%):-%f}
}

precmd () {
  title 'zsh %2~'
  if git branch &>/dev/null; then
    update_git_prompt
  else
    unset git_prompt
  fi

  # update_prompt
}

title () {
  1=${(%)1}
  1=${(V)1}
  1=${(q)1}

  case $TERM in
    screen*)
      print -n "\ek$1\e\\" ;;
    linux)
      ;;
    *)
      print -n "\e]2;$1\a" ;;
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
    git_branch_name=$(git branch | grep '^\*' | sed 's/* //')
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

  git_prompt="%F{199}$git_branch_name"
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
  PS1=''
  # hostname if in ssh or root
  [[ -n $SSH_CONNECTION || $UID == 0 ]] && PS1+='%F{34}%m%f:'
  # username
  PS1+='%F{111}%n%f '
  # path with prefix, truncated to 55 characters
  PS1+='%F{192}%55<..<%~%<<%f'
  # git prompt if set
  PS1+='${git_prompt+ $git_prompt}'
  # jobs (if any)
  PS1+='%1(j. %F{113}%j%f.)'
  # exit code if >0
  PS1+='%(?.. %F{173}%?%f)'
  # newline
  PS1+=$'\n'
  # red text if root
  PS1+='%(!.%F{196}.)'
  # % or # based on privileges
  PS1+='%# '
# }}}

# vim: foldmethod=marker
