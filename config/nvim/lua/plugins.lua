vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use {'sainnhe/gruvbox-material', config = 'require [[config/gruvbox]]'}
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-commentary'
    use 'tpope/vim-repeat'
    use {'w0rp/ale', cmd = 'ALEEnable'}
    use {'justinmk/vim-sneak', config = 'vim.api.nvim_set_var([[sneak#s_next]], 1)'}
    use {'jpalardy/vim-slime', config = 'vim.g.slime_target = [[tmux]]', cmd = 'SlimeConfig'}
    use {'mhinz/vim-grepper', cmd = 'Grepper', config = 'vim.g.grepper = { tools = {"rg", "git", "grep"}}'}
    use {'liuchengxu/vista.vim', config = 'require [[config/vista]]'}
    use {'alok/notational-fzf-vim', config = 'require [[config/nv]]'}
    use {'ludovicchabant/vim-gutentags', cmd = 'GutentagsUpdate'}
    use 'wellle/targets.vim'
    use {'nvim-treesitter/nvim-treesitter', config = 'require [[config/treesitter]]', run = ':TSUpdate'}
    use 'tpope/vim-abolish'
    use 'tommcdo/vim-exchange'
    use {'neovim/nvim-lspconfig', config = 'require [[config/lsp]]'}
    use {'norcalli/snippets.nvim', config = 'require [[config/snippets]]'}
    use 'tpope/vim-surround'
    use 'sheerun/vim-polyglot'
    use {'norcalli/nvim-colorizer.lua', config = 'require[[colorizer]].setup()', cmd = 'ColorizerToggle'}
    use {'kg8m/vim-simple-align', cmd = 'SimpleAlign'}
    use {'tpope/vim-unimpaired', config = 'require[[config/unimpaired]]'}
    use 'RRethy/vim-illuminate'
    use {'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        config = 'require[[config/telescope]]'
    }
    use {'hrsh7th/nvim-compe', config = 'require[[config/compe]]'}

    -- use {'lervag/vimtex', ft = 'tex', config = 'require [[config/vimtex]]'}
    use {'~/Sync/dev/elvish.vim', ft = 'elvish'}
    use {'guersam/vim-j', ft = 'j'}
end)
