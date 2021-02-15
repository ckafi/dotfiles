use path
use str
use re


# functional helper
fn nth [n]{ put [(all)][$n] }


# aliases
fn ls  [@a]{ exa -F $@a }
fn la  [@a]{ ls -a $@a }
fn ll  [@a]{ ls -lgh --color-scale --git $@a }
fn lla [@a]{ ll -a $@a }
fn cp  [@a]{ e:cp -iv $@a }
fn mv  [@a]{ e:mv -iv $@a }
fn rm  [@a]{ e:rm -v $@a }
fn e   [@a]{ nvim $@a }
fn re  [@a]{ nvr --remote-silent $@a }
fn p   [@a]{ yay $@a }
fn o   [@a]{ fork mimeo $@a }
fn ext [@a]{ aunpack $@a }
fn u   [@a]{ systemctl --user $@a }
fn a   [@a]{ aria2c $@a }
fn n   []{ cd ~/Sync/notes; nvim -c ":NV" }
fn t   [@a]{ trash $@a }
fn pj  [@a]{ pijul $@a }


# functions
fn fo [@dir]{
  fd -c always -t f . (take 1 $dir) | ^
    fzf --bind='enter:execute-silent(mimeo {+})+clear-selection'
}

fn d [@dir]{
  fd -c always -t d . (take 1 $dir) | fzf --no-multi
}

fn f [@dir]{
  fd -c always -t f -t l . (take 1 $dir) | fzf --no-multi
}

fn br [@a]{
  f = (mktemp)
  try {
    broot --outcmd $f $@a
  } else {
    eval (cat $f)
  } finally {
    (external rm) -f $f
  }
}

fn up [@arg]{
  local:count = 1
  if (not-eq $arg []) { count = $arg[0] }
  cd (str:join "/" [(repeat $count "..")])
}

fn nvim-server []{
  if (has-env NVIM_LISTEN_ADDRESS) {
    echo "Server environment already set"
    return
  }
  socket_path = "/tmp/nvim_sockets/"
  mkdir -p $socket_path
  socket = (pwd | re:replace "[[:^alpha:]]" "" (all))
  set-env NVIM_LISTEN_ADDRESS $socket_path$socket
}

# poor mans vcs
fn keep [f]{
  try {
    latest = (order &reverse=$true [$f.*[number]] | take 1)
    cmp -s $f $latest
    echo $f "not modified" >&stderr
  } except e {
    cp -va $f $f.(date '+%s')
  }
}

# create and return current clutter folder
fn clutter []{
  path = ~/clutter/(date '+%G/%V')
  mkdir -p $path
  put $path
}
fn cl []{ cd (clutter) }

# set terminal title
fn set_title [title]{
  printf "\e]2;%s\a" $title
}


# abbreviations
b=[l r]{ edit:abbr[$l] = $r } {
  $b '||' '| less'
  $b '>dn' '2>/dev/null'
}; unset-env b


# hooks
edit:before-readline = [{ set_title "elv "(path:base $pwd) }]
edit:after-readline = [$set_title~]


# keybindings
b=[k f]{ edit:insert:binding[$k] = $f } {
  $b Ctrl-H $edit:history:fast-forward~
  $b Ctrl-L { clear > /dev/tty; edit:redraw &full=$true }
  $b Ctrl-B $edit:move-dot-left-word~
  $b Ctrl-W $edit:move-dot-right-word~
  $b Ctrl-K $edit:kill-line-right~
  $b Ctrl-D {
    if (> (count $edit:current-command) 0) { edit:kill-word-left
    } else { edit:return-eof }
  }
  $b Alt-n $edit:navigation:start~
  $b Alt-l $edit:location:start~
}; unset-env b


# prompt
use prompt
edit:prompt  = $prompt:main_prompt~
edit:rprompt = $prompt:git_prompt~


# completions
edit:completion:matcher[''] = [seed]{ edit:match-prefix $seed &ignore-case=$true }

use comp/pacman
use comp/pass
use comp/systemctl
use comp/man

edit:completion:arg-completer[yay]  = $edit:completion:arg-completer[pacman]
edit:completion:arg-completer[p]    = $edit:completion:arg-completer[pacman]
edit:completion:arg-completer[sudo] = $edit:complete-sudo~


# environment
value-out-indicator = ':> '
E:LS_COLORS = (dircolors ~/.dircolors | take 1 | str:split "'" (all) | nth 1)
E:SUDO_PROMPT = "[sudo] "$E:USER@(hostname)"'s passwd: "
stty -ixon # disable ctrl-s

E:LESS = "-iJM"
E:LESS_TERMCAP_mb = (tput blink)
E:LESS_TERMCAP_md = (tput setaf 2)
E:LESS_TERMCAP_me = (tput sgr0)
E:LESS_TERMCAP_so = (tput smso; tput setaf 4; tput setab 15)
E:LESS_TERMCAP_se = (tput rmso; tput sgr0)
E:LESS_TERMCAP_us = (tput smul; tput setaf 6)
E:LESS_TERMCAP_ue = (tput rmul; tput sgr0)
