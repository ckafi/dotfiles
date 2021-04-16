vim.g.vista_fold_toggle_icons = {'▾','▸'}
vim.g.vista_default_executive = 'ctags'
vim.api.nvim_set_var([[vista#renderer#enable_icon]], 0)

vim.g.vista_executive_for = {
  julia = 'nvim_lsp',
  tex = 'nvim_lsp',
}
