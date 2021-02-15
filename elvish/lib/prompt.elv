use re
use str

fn git_prompt {
  nop ?(
    styled (git rev-parse --abbrev-ref HEAD) magenta
    styled ':'(git rev-parse --short HEAD) magenta
    status = (git status | str:join '\n')
    put ' '
    if (re:match 'Changes to be committed:' $status) { styled 's' green }
    if (re:match 'Changes not staged for commit:' $status) { styled 'm' yellow }
    if (re:match 'Untracked files:' $status) { styled 'u' red }
    put ' '
    if (re:match 'Your branch and .* have diverged' $status) { styled 'd' cyan }
    if (re:match 'Your branch is ahead of ' $status) { styled 'a' cyan }
    if (re:match 'Your branch is behind ' $status) { styled 'b' cyan }
  ) 2>/dev/null
}

fn main_prompt {
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
