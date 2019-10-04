setlocal comments=:#
setlocal makeprg=python3\ %
call deoplete#initialize()
let g:deoplete#omni#input_patterns.python=[
  \'\w+\s*=\s*\w*$|',
  \'^\s*@\w*$|',
  \'^\s*from\s+[\w\.]*(?:\s+import\s+(?:\w*(?:,\s*)?)*)?|',
  \'^\s*import\s+(?:[\w\.]*(?:,\s*)?)*',
  \'[\w\)\]\}\''\"]+\.\w*$|']
