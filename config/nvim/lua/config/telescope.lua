local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua require"telescope.builtin".find_files()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua require"telescope.builtin".live_grep()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua require"telescope.builtin".file_browser()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>lua require"telescope.builtin".buffers()<cr>', opts)
