setlocal formatoptions+=t
" setlocal makeprg=lualatex\ --shell-escape\ --interaction=nonstopmode\ --file-line-error\ %
" setlocal errorformat=%E%f:%l:%m,%Zl.%l\ %m,%C%.%#,%-G%.%#
let g:neomake_tex_lualatex_maker = {
    \ 'args': ['--shell-escape', '--interaction=nonstopmode','--file-line-error'],
    \ 'errorformat': '%E%f:%l:%m,%Zl.%l %m,%C%.%#,%-G%.%#',
    \ }
let g:neomake_tex_pdflatex_maker = {
    \ 'args': ['--shell-escape', '--interaction=nonstopmode','--file-line-error'],
    \ 'errorformat': '%E%f:%l:%m,%Zl.%l %m,%C%.%#,%-G%.%#',
    \ }
" let g:neomake_tex_enabled_makers = ['chktex','lacheck','lualatex']
let g:neomake_tex_enabled_makers = ['pdflatex']

call deoplete#initialize()
let g:deoplete#omni_patterns.tex = ['[^ ]\w*']
