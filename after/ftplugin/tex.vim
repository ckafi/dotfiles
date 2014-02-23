setlocal formatoptions+=t
setlocal makeprg=lualatex\ --shell-escape\ --interaction=nonstopmode\ %
setlocal errorformat=%C!\ %.%#,%E!\ %m,%Zl.%l%.%#,%-G%.%#
