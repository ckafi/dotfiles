if test -n "$SSH_CONNECTION"
  set -g theme_display_user yes
  if test -z "$TMUX"
    exec tmux new fish
  end
end
set -g theme_display_vi no
set -g theme_date_format "+%T"
set -g theme_title_display_process yes
set -g theme_display_ruby no
set -g theme_show_exit_status yes
# set -g theme_newline_cursor yes

fish_vi_key_bindings

set -xg PATH ~/bin $PATH
set -xg PAGER "less"
set -xg VIEWER $PAGER
set -xg EDITOR "nvim"
set -xg VISUAL $EDITOR
set -xg FZF_DEFAULT_OPTS "--reverse --multi"

if status is-interactive
  # Less
  set -xg LESS "-iJM"
  # begin blinking
  set -xg LESS_TERMCAP_mb (tput blink)
  # begin bold
  set -xg LESS_TERMCAP_md (tput bold; tput setaf 2)
  # end mode
  set -xg LESS_TERMCAP_me (tput sgr0)
  # begin standout-mode - info box
  set -xg LESS_TERMCAP_so (tput smso; tput setaf 4; tput setab 15)
  # end standout-mode
  set -xg LESS_TERMCAP_se (tput rmso; tput sgr0)
  # begin underline
  set -xg LESS_TERMCAP_us (tput smul; tput setaf 6)
  # end underline
  set -xg LESS_TERMCAP_ue (tput rmul; tput sgr0)
end

alias o "mimeo"
alias e "$EDITOR"
alias p "pacaur"
alias u "systemctl --user"
alias wiki "nvim +VimwikiIndex"
alias psgrep "ps -ef | grep"
alias copy "xsel --clipboard --input"
alias paste "xsel --clipboard --output"
alias grep "grep --color=auto"
alias cp "cp -iv --reflink=auto"
alias rm "rm -iv"
alias mv "mv -iv"
alias t "trash"
alias la "ls -A"
alias ll "ls -hl --time-style=posix-iso"
alias lla "ll -A"
alias nt 'fork termite -d (pwd)'
