use re

edit:completion:arg-completer[man] = [@args]{
  whatis --long --regex $args[-1] |
    peach [line]{
      put (re:find '^\S+' $line)[text]
    }
}
