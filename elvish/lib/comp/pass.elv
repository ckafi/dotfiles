use re

edit:completion:arg-completer[pass] = [@args]{
  fd -t f .gpg ~/.password-store/ | \
    peach [path]{ put (re:find '\.password-store/(.*)\.gpg' $path)[groups][1][text] }
}
