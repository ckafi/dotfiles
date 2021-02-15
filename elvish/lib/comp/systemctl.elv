use re

edit:completion:arg-completer[systemctl] = [@args]{
  run-parallel { systemctl list-units --all } { systemctl list-unit-files } |
    peach [line]{
      echo (re:find &max=1 '\S+\.(service|mount|automount|socket|target)' $line)[text]
    }
}
