require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = false,
    disable = { "latex" }
  },
  textobjects = { enable = true },
  indent = { enable = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
