use path
use str
use re

E:LS_COLORS = [(splits "'" (dircolors ~/.dircolors | head -1))][1]
E:SUDO_PROMPT = "[sudo] "$E:USER@(hostname)"'s passwd: "

E:LESS = "-iJM"
E:LESS_TERMCAP_mb = (tput blink)
E:LESS_TERMCAP_md = (tput setaf 2)
E:LESS_TERMCAP_me = (tput sgr0)
E:LESS_TERMCAP_so = (tput smso; tput setaf 4; tput setab 15)
E:LESS_TERMCAP_se = (tput rmso; tput sgr0)
E:LESS_TERMCAP_us = (tput smul; tput setaf 6)
E:LESS_TERMCAP_ue = (tput rmul; tput sgr0)

fn ls  [@a]{ exa -F $@a }
fn la  [@a]{ ls -a $@a }
fn ll  [@a]{ ls -lgh --color-scale --git $@a }
fn lla [@a]{ ll -a $@a }
fn cp  [@a]{ e:cp -iv $@a }
fn mv  [@a]{ e:mv -iv $@a }
fn rm  [@a]{ e:rm -i $@a }
fn e   [@a]{ nvim $@a }
fn p   [@a]{ yay $@a }
fn o   [@a]{ fork mimeo $@a }
fn ext [@a]{ aunpack $@a }

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
  try { broot --outcmd $f $@a }
  else { -source $f }
  finally { rm -f $f }
}

fn up [@arg]{
  local:count = 1
  if (not-eq $arg []) { count = $arg[0] }
  cd (str:join "/" [(repeat $count "..")])
}

fn bytes []{ each $echo~ }
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

# Poor mans VCS
fn keep [f]{
  try {
    latest = (order &reverse=$true [$f.*[number]] | take 1)
    cmp -s $f $latest
    echo $f "not modified" >&stderr
  } except e {
    cp -va $f $f.(date '+%s')
  }
}

# Create and return current clutter folder
fn clutter []{
  path = ~/clutter/(date '+%G/%V')
  mkdir -p $path
  put $path
}
fn cl []{ cd (clutter) }

edit:insert:binding[Ctrl-B]  = $edit:history:start~
edit:history:binding[Ctrl-B] = $edit:history:up~
edit:insert:binding[Ctrl-K]  = $edit:insert-last-word~
edit:insert:binding[Ctrl-H]  = $edit:history:fast-forward~

use prompt
edit:prompt  = $prompt:main_prompt~
edit:rprompt = $prompt:git_prompt~

edit:completion:matcher[''] = [seed]{ edit:match-prefix $seed &ignore-case=$true }

use comp/pacman
use comp/pass
use comp/systemctl
use comp/man

edit:completion:arg-completer[yay]  = $edit:completion:arg-completer[pacman]
edit:completion:arg-completer[p]    = $edit:completion:arg-completer[pacman]
edit:completion:arg-completer[sudo] = $edit:complete-sudo~
