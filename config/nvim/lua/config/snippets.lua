vim.api.nvim_set_keymap('i', '<c-s>', [[<cmd>lua return require'snippets'.expand_or_advance(1)<CR>]], {})

require'snippets'.snippets = {
  _global = require 'snippets/global';
}
