vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use {'morhetz/gruvbox', config = 'require [[config/gruvbox]]'}
    use {'mhinz/vim-startify', config = 'require [[config/startify]]'}
    use {'editorconfig/editorconfig-vim'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-surround'}
    use {'tpope/vim-unimpaired'}
    use {'w0rp/ale', cmd = 'ALEEnable'}
    use {'justinmk/vim-sneak', config = 'vim.api.nvim_set_var([[sneak#s_next]], 1)'}
    use {'justinmk/vim-dirvish'}
    use {'jpalardy/vim-slime', config = 'vim.g.slime_target = [[tmux]]'}
    use {'mhinz/vim-grepper', config = 'vim.g.grepper = { tools = {"rg", "git", "grep"}}'}
    use {'liuchengxu/vista.vim'}
    use {'alok/notational-fzf-vim', config = 'require [[config/nv]]'}
    use {'junegunn/fzf.vim'}
    use {'ludovicchabant/vim-gutentags', cmd = 'GutentagsUpdate'}
    use {'wellle/targets.vim'}
    use {'nvim-treesitter/nvim-treesitter', config = 'require [[config/treesitter]]'}
    use {'nvim-lua/completion-nvim', config = 'require [[config/completion]]'}
    use {
        'neovim/nvim-lspconfig',
        config = 'require [[config/lsp]]',
        requires = {
          'nvim-lua/diagnostic-nvim',
        }
      }

    -- use {'lervag/vimtex', ft = 'tex', config = 'require [[config/vimtex]]'}
    use {'dmix/elvish.vim'}
    use {'JuliaEditorSupport/julia-vim'}
  end)
