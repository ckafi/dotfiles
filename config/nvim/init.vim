" Settings
set completeopt=menu      " Use a popup menu for completion
set completeopt+=menuone  " ... also when there is only one match
set completeopt+=noselect " Don't select a match
set completeopt+=noinsert " or insern any text
set cursorline            " Highlight the screen line of the cursor
set dictionary=/usr/share/dict/ngerman " Dictionary for <C-X><C-K>
set expandtab             " Use appropriate number of spaces instead of a tab
set guifont=IBM\ Plex\ Mono:h13 " Font for GUI (nvim-qt)
set fillchars=vert:│      " Disable annoying chars for stl, diff, fold etc.
set fillchars+=diff:\     " ...
set formatoptions=c       " Auto-wrap comments
set formatoptions+=j      " Remove unneeded commelnt leader when joining
set formatoptions+=l      " Don't break already too long lines
set formatoptions+=n      " Recognize numbered lists
set formatoptions+=q      " Allow formatting of comments with 'gq'
set formatoptions+=r      " Inset comment leader after <Enter>
set hidden                " Hide buffers when they are abandoned
set ignorecase            " Do case insensitive matching
set inccommand=split      " Show live substitutions in split
set lazyredraw            " Do not redraw the screen during macros
set linebreak             " (Soft)wrap long lines
set listchars=tab:·\      " List mode character for tab
set listchars+=eol:⌟      " ... end of line
set listchars+=extends:…  " ... end of a truncated display line
set listchars+=precedes:… " ... start and
set listchars+=trail:×    " ... trailing whitespace
set number                " Show line numbers
set pastetoggle=<F8>      " Toggle (no)paste with F8
set scrolloff=3           " Number of lines always above/below cursor
set shiftwidth=0          " Number of spaces for each (auto)indent
set shortmess+=c          " don't give ins-completion-menu messages.
set showbreak=└\          " Char to show at beginning of wrapped lines
set showmatch             " Show matching brackets.
set signcolumn=yes        " always show signcolumn
set smartcase             " Do smart case matching
set smartindent           " Use smart-indenting
set softtabstop=-1        " Number of spaces a Tab counts for in insert
set spelllang=de          " Language for spell checking
set splitbelow            " For split: new window below old one
set splitright            " For vsplit: new window right of old one
set switchbuf="useopen"   " Switch to buffer when already open
set tabstop=2             " Number of spaces a Tab counts for in file
set textwidth=80          " Max. length of line for auto-formatting
set title                 " set window title"
set undofile              " Save undo history
set visualbell            " Visual bell instead of beeping
set wildmode=longest:full " Complete longest common string and start wildmenu
set wildmode+=full        " ... then go to next full match


" Autocmds
autocmd BufEnter *.tex  setfiletype tex
autocmd BufEnter *.adoc set suffixesadd=.adoc


" Variable Settings
let mapleader = " "
let maplocalleader = ","


" Keymaps and Abbrevs
" Let Y fit in
nnoremap Y y$
" The terminal escape is impossible in neo2
tnoremap <leader><esc> <C-\><C-n>
" Follow tag under cursor
nmap gt <C-]>
nmap gh :nohls<CR>
nmap <C-j> <C-^>
" sudo and write (if you forgot to sudo first)
cmap w!! w <esc>!sudo tee % >/dev/null
" indent more or less in visual mode with < and >
vnoremap < <gv
vnoremap > >gv
" center matching line from n and N
nnoremap n nzz
nnoremap N Nzz
" make macros a bit more convenient
nnoremap Q @@
vnoremap Q @@
" Select pasted text
nmap gp `[v`]
nnoremap <silent> - :Dirvish %<cr>
nnoremap <leader>n :NV<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
" nnoremap <leader>l :Lines<CR>
nnoremap <leader>t :Tags<CR>


" Commands
command! PackerInstall packadd packer.nvim | lua require('plugins').install()
command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
command! PackerSync packadd packer.nvim | lua require('plugins').sync()
command! PackerClean packadd packer.nvim | lua require('plugins').clean()
command! PackerCompile packadd packer.nvim | lua require('plugins').compile()

" vim: foldmethod=marker
