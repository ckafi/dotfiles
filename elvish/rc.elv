use re
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/ssh
use github.com/zzamboni/elvish-completions/builtins

E:LS_COLORS=[(splits "'" (dircolors ~/.dircolors | head -1))][1]

E:LESS="-iJM"
E:LESS_TERMCAP_mb=(tput blink)
E:LESS_TERMCAP_md=(tput setaf 2)
E:LESS_TERMCAP_me=(tput sgr0)
E:LESS_TERMCAP_so=(tput smso; tput setaf 4; tput setab 15)
E:LESS_TERMCAP_se=(tput rmso; tput sgr0)
E:LESS_TERMCAP_us=(tput smul; tput setaf 6)
E:LESS_TERMCAP_ue=(tput rmul; tput sgr0)

E:SUDO_PROMPT="[sudo] "$E:USER@(hostname)"'s passwd: "

fn ls [@a]{ exa -F $@a }
fn la [@a]{ ls -a $@a }
fn ll [@a]{ ls -lgh --color-scale --git $@a }
fn lla [@a]{ ll -a $@a }
fn cp [@a]{ e:cp -iv $@a }
fn mv [@a]{ e:mv -iv $@a }
fn rm [@a]{ e:rm -i $@a }
fn e [@a]{ nvim $@a }
fn p [@a]{ yay $@a }
fn o [@a]{ mimeo $@a }
fn ext [@a]{ aunpack $@a }

fn fo [@dir]{
  fd -c always -t f . (take 1 $dir) | \
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
    -source $f
  } finally {
    rm -f $f
  }
}

fn up [@arg]{
  local:count = 1
  if (not-eq $arg []) { count = $arg[0] }
  cd (joins "/" [(repeat $count "..")])
}

fn bytes []{ each $echo~ }

edit:insert:binding[Ctrl-B] = $edit:history:start~
edit:history:binding[Ctrl-B] = $edit:history:up~
edit:insert:binding[Ctrl-K] = $edit:insert-last-word~
edit:insert:binding[Ctrl-H] = $edit:history:fast-forward~

value-out-indicator = ':> '
edit:rprompt = (constantly "")
edit:prompt = {
  styled $E:USER blue
  if (has-env SSH_TTY) { styled "@"(hostname) green }
  styled " "(tilde-abbr $pwd) yellow
  put "\n"
  if (>= $num-bg-jobs 1) { styled $num-bg-jobs" " cyan }
  if (==s $E:USER root) {
    styled "∺ " red
  } else {
    put "∹ "
  }
}

edit:completion:matcher[''] = [seed]{ edit:match-prefix $seed &ignore-case=$true }

use comp/pacman
edit:completion:arg-completer[yay] = $edit:completion:arg-completer[pacman]
edit:completion:arg-completer[p] = $edit:completion:arg-completer[pacman]

edit:completion:arg-completer[mosh] = $edit:completion:arg-completer[ssh]
edit:completion:arg-completer[sudo] = $edit:complete-sudo~
edit:completion:arg-completer[systemctl] = [@args]{
  { systemctl list-units; systemctl list-unit-files } | each [line]{
    echo (re:find '\S+\.(service|mount|automount|socket|target)' $line)[text]
  } | sort | uniq
}
