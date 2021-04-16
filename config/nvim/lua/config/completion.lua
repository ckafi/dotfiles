vim.g.completion_auto_change_source = 1
vim.g.completion_matching_strategy_list = {'exact', 'substring'}
vim.g.completion_matching_ignore_case = 1

vim.cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

vim.api.nvim_set_keymap('i', '<c-j>', '<Plug>(completion_next_source)', {})
vim.api.nvim_set_keymap('i', '<c-k>', '<Plug>(completion_prev_source)', {})

vim.g.completion_chain_complete_list = {
  default = {
    {complete_items = {'lsp'}},
    {mode = '<c-n>'},
    {mode = 'file'},
  },
  tex = {
    {mode = 'omni'},
    {mode = '<c-n>'},
    {mode = 'file'},
    {mode = 'dict'},
  },
}
