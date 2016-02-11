fun! ToggleDotfiles()
  if &filetype != 'dirvish' | return | endif

  if b:show_dotfiles
    let b:show_dotfiles = 0
    if !empty(b:dotfiles)
      silent 0put =b:dotfiles
      g!@\/$@move $
    endif
  else
    let b:show_dotfiles = 1
    let b:dotfiles = []
    silent g@\v/\.[^\/]+/?$@call add(b:dotfiles, getline(".")) | d _
  endif
endfun

let b:show_dotfiles = 0
call ToggleDotfiles()
g!@\/$@move $
nnoremap <buffer><silent> gh :call ToggleDotfiles()<CR>
