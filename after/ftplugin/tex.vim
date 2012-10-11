setlocal formatoptions+=t
setlocal makeprg=lualatex\ --interaction=nonstopmode\ %
setlocal errorformat=%C!\ %.%#,%E!\ %m,%Zl.%l%.%#,%-G%.%#
