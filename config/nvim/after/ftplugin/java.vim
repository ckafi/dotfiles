setlocal makeprg=javac\ %
call deoplete#initialize()
let g:deoplete#omni#input_patterns.java = ['[^. \t0-9]\.\w*']
