let g:neomake_clojure_kibit_maker = {
    \ 'exe': 'lein',
    \ 'args': ['kibit'],
    \ 'errorformat': '%IAt %f:%l:,%C%m,%-G%.%#',
    \ 'buffer_output': 1,
    \ }
let g:neomake_clojure_enabled_makers = ['kibit']
