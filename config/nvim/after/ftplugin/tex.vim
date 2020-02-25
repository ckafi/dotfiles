au Filetype tex call ncm2#register_source({
      \ 'name' : 'vimtex-cmds',
      \ 'priority': 8,
      \ 'complete_length': -1,
      \ 'scope': ['tex'],
      \ 'matcher': {'name': 'prefix', 'key': 'word'},
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
      \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
      \ })
au Filetype tex call ncm2#register_source({
      \ 'name' : 'vimtex-labels',
      \ 'priority': 8,
      \ 'complete_length': -1,
      \ 'scope': ['tex'],
      \ 'matcher': {'name': 'combine',
      \             'matchers': [
      \               {'name': 'substr', 'key': 'word'},
      \               {'name': 'substr', 'key': 'menu'},
      \             ]},
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': g:vimtex#re#ncm2#labels,
      \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
      \ })
au Filetype tex call ncm2#register_source({
      \ 'name' : 'vimtex-files',
      \ 'priority': 8,
      \ 'complete_length': -1,
      \ 'scope': ['tex'],
      \ 'matcher': {'name': 'combine',
      \             'matchers': [
      \               {'name': 'abbrfuzzy', 'key': 'word'},
      \               {'name': 'abbrfuzzy', 'key': 'abbr'},
      \             ]},
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': g:vimtex#re#ncm2#files,
      \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
      \ })
au Filetype tex call ncm2#register_source({
      \ 'name' : 'bibtex',
      \ 'priority': 8,
      \ 'complete_length': -1,
      \ 'scope': ['tex'],
      \ 'matcher': {'name': 'combine',
      \             'matchers': [
      \               {'name': 'prefix', 'key': 'word'},
      \               {'name': 'abbrfuzzy', 'key': 'abbr'},
      \               {'name': 'abbrfuzzy', 'key': 'menu'},
      \             ]},
      \ 'word_pattern': '\w+',
      \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
      \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
      \ })
