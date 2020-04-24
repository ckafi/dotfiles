use re

edit:completion:arg-completer[systemctl] = [@args]{
  systemctl list-units --all | 
    peach [line]{
      echo (re:find &max=1 '\S+\.(service|mount|automount|socket|target)' $line)[text]
    }
}
