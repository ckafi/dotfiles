let g:neomake_nim_nim_maker = {
    \ 'args': ['--verbosity:0', '--colors:off', 'compile'],
    \ 'errorformat':                                     
    \   '%I%f(%l\, %c) Hint: %m,' .                      
    \   '%W%f(%l\, %c) Warning: %m,' .                   
    \   '%E%f(%l\, %c) Error: %m'
    \ }
let g:neomake_nim_enabled_makers = ['nim']

