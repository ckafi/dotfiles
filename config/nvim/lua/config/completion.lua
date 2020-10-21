vim.g.completion_auto_change_source = 1
vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

vim.api.nvim_set_keymap('i', '<c-j>', '<Plug>(completion_next_source)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<c-k>', '<Plug>(completion_prev_source)', { noremap = true, silent = true })

vim.g.completion_chain_complete_list = {
  {complete_items = {'lsp', 'snippet'}},
  {mode = '<c-p>'},
  {mode = '<c-n>'}
}

vim.api.nvim_set_var([[mucomplete#chains]], {
  default = {'omni', 'c-n', 'path'},
})
