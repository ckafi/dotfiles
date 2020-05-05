" A vim configuration file
" Written by Tobias Frilling (tobias@frilling-online.de)
" Any copyright is dedicated to the Public Domain.
" http://creativecommons.org/publicdomain/zero/1.0/
" So feel free to use any line you want.

" Plugins {{{
call plug#begin('~/.config/nvim/plugins')
Plug 'chrisbra/NrrwRgn'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'jalvesaq/Nvim-R'
Plug 'joom/latex-unicoder.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex', {'for': 'tex'}
" Plug 'ludovicchabant/vim-gutentags'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sheerun/vim-polyglot'
Plug 'shougo/neosnippet'
Plug 'shougo/neosnippet-snippets'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vista.vim'
" NCM
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
Plug 'fgrsnau/ncm2-otherbuf'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-neosnippet'

Plug 'dmix/elvish.vim', {'for': 'elvish'}
call plug#end()
" }}}

" Settings {{{
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
set ignorecase            " Do case insensitive matching
set smartcase             " Do smart case matching
set nohlsearch              " Highlight matching strings when searching
set hidden                " Hide buffers when they are abandoned
set mouse=n               " Enable mouse usage (normal mode)
set splitbelow            " For split: new window below old one
set splitright            " For vsplit: new window right of old one
set lazyredraw            " Do not redraw the screen during macros
set scrolloff=3           " Number of lines always above/below cursor
set wildmode=longest:full " Complete longest common string and start wildmenu
set wildmode+=full        " ... then go to next full match
set smartindent           " Use smart-indenting
set pastetoggle=<F8>      " Toggle (no)paste with F8
set undofile              " Save undo history
set visualbell            " Visual bell instead of beeping
set listchars=tab:·\      " List mode character for tab
set listchars+=eol:⌟      " ... end of line
set listchars+=trail:×    " ... trailing whitespace
set listchars+=precedes:… " ... start and
set listchars+=extends:…  " ... end of a truncated display line
set fillchars=vert:│      " Disable annoying chars for stl, diff, fold etc.
set fillchars+=diff:\     " ...
set number                " Show line numbers
set cursorline            " Highlight the screen line of the cursor
set foldtext=MyFoldFunc() " Function for the text on closed folds
set spelllang=de          " Language for spell checking
set tabstop=2             " Number of spaces a Tab counts for in file
set shiftwidth=0          " Number of spaces for each (auto)indent
set softtabstop=-1        " Number of spaces a Tab counts for in insert
set expandtab             " Use appropriate number of spaces instead of a tab
set linebreak             " (Soft)wrap long lines
set showbreak=└\          " Char to show at beginning of wrapped lines
set textwidth=80          " Max. length of line for auto-formatting
set formatoptions=c       " Auto-wrap comments
set formatoptions+=r      " Inset comment leader after <Enter>
set formatoptions+=q      " Allow formatting of comments with 'gq'
set formatoptions+=n      " Recognize numbered lists
set formatoptions+=l      " Don't break already too long lines
set formatoptions+=j      " Remove unneeded commelnt leader when joining
set completeopt=menu      " Use a popup menu for completion
set completeopt+=menuone  " ... also when there is only one match
" set completeopt+=longest  " Only insert the longest common text
" set completeopt+=preview  " Show information about current item in preview
set completeopt+=noinsert
set completeopt+=noselect
set complete=.,w,b,u,t,i  " Complete sources are all buffers, tags and includes
set shortmess+=I          " Don't show intro message
set shortmess+=c          " don't give ins-completion-menu messages.
set statusline=(%n)%f\ %m%<%r\ %c,%l\/%L(%P)%=%y%h%w%q[%{&fenc}][%{&ff}]
set dictionary=/usr/share/dict/ngerman " Dictionary for <C-X><C-K>
set noshowmode            " Disable display of mode (-- INSERT --)
set switchbuf="useopen"   " Switch to buffer when already open
set inccommand=split      " Show live substitutions in split
set rtp^=/usr/share/vim/vimfiles/ " include old vimfiles
set signcolumn=yes        " always show signcolumn
set updatetime=300        " Smaller updatetime for CursorHold & CursorHoldI
set title                 " set window title"
"}}}

" LanguageClient {{{
let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'julia': ['julia', '--project=@.', '--startup-file=no', '--history-file=no', '-e', 'using Pkg; using LanguageServer; import StaticLint; import SymbolServer; env_path = dirname(Pkg.Types.Context().env.project_file); debug = false; server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict()); server.runlinter = true; run(server);']
    \ }
let g:LanguageClient_useVirtualText = 0
" }}}

" Autocmds {{{
" augroup vimrc-incsearch-highlight
"   autocmd!
"   autocmd CmdlineEnter /,\? :set hlsearch
"   autocmd CmdlineLeave /,\? :set nohlsearch
" augroup END
autocmd BufEnter *.pde   setfiletype arduino
autocmd BufEnter *.tex   setfiletype tex
autocmd BufEnter * call ncm2#enable_for_buffer()
"}}}

" Color-Settings {{{
" enable true color
set termguicolors
" Use colors for a dark background
set background=dark
" Force some text decorations
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_contrast_dark="soft"
let g:gruvbox_contrast_light="soft"
let g:gruvbox_italicize_strings=1
" Load color scheme
colorscheme gruvbox
" Highlight the 81st column if there is a character
" highlight col81 ctermbg=red guibg=red
" match col81 /\%<82v.\%>81v/
"}}}

" Variable Settings {{{
" Set comma as leader
let mapleader = " "
let maplocalleader = ","
" Enable powerline font
" let g:airline_powerline_fonts = 1
" Set airline color theme
let g:airline_theme = 'gruvbox'
" Press s for next sneak match
let g:sneak#s_next = 1
" Don't overwrite sneak command
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']

let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_progname = 'nvr'

let g:gtfo#terminals = { 'unix' : 'fork alacritty --working-directory' }
let g:grepper = { 'tools' : ['rg', 'git', 'grep'] }

let g:startify_commands = [
    \ {'p': ['Scratchpad', 'edit ~/Sync/scratchpad.md']}
    \ ]
let g:startify_files_number = 5
let g:startify_enable_special = 0
let g:startify_custom_header = map(startify#fortune#quote(), '"   ".v:val')
let g:startify_session_persistence = 1
let g:startify_session_dir = '~/.config/nvim/sessions'
" disable some polyglot plugins
let g:polyglot_disabled = ['latex', 'julia']

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 0

let r_indent_align_args = 0

" Disable editorconfig for fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
"}}}

" Keymaps and Abbrevs {{{
" Let Y fit in
nnoremap Y y$

" The terminal escape is impossible in neo2
tnoremap <leader><esc> <C-\><C-n>

" Follow tag under cursor
nmap gt <C-]>
" Toggle graphical undo window
nmap <F4>  :UndotreeToggle<CR>
nmap <F5>  :nohls<CR>
nmap <C-j> <C-^>
" Move up and down in the changelist
nnoremap <C-Up> g;
nnoremap <C-Down> g,
" 'Focus' the current fold by folding all the others
nnoremap <leader>z zMzv<esc>
" sudo and write (if you forgot to sudo first)
cmap w!! w <esc>!sudo tee % >/dev/null
" indent more or less in visual mode with < and >
vnoremap < <gv
vnoremap > >gv
" center matching line from n and N
nnoremap n nzz
nnoremap N Nzz

" open Dirvish with -
map <silent> - :Dirvish %<cr>

" " open buffer-, file- or linelist in fuzzy finder
nnoremap <leader>b :Clap buffers<cr>
nnoremap <leader>f :Clap files<cr>
nnoremap <leader>g :Clap grep<cr>
nnoremap <leader>l :Clap blines<cr>

" make macros a bit more convenient
nnoremap Q @@
vnoremap Q @@

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

map <F1> <Nop>
imap <F1> <Nop>

vmap <leader>rr :NR!<cr>
nmap <leader>rr vip<leader>rr

nmap <silent> R :set opfunc=Replace<CR>g@
function! Replace(type, ...)
  silent exe "normal! `[\"_d`]\"_xP"
endfunction

" Select pasted text
nmap gp `[v`]

" }}}

" Functions {{{
" get the text for 'foldtext'
function! MyFoldFunc ()
  let ftextmarker = '+> '
  " number of lines of the fold
  let flength = 1 + v:foldend - v:foldstart
  let flstring = '(' . flength . ' lines)'
  " get the first folded line
  let fname = getline(v:foldstart)
  " delete fold markers
  let fname = substitute(fname, '{\{3}\d\?', '', 'g')
  " delete leading comment marker
  let fname = substitute(fname, '^\s*[#"%!;]\|\/\/\|--', '', '')
  " delete leading whitespace
  let fname = substitute(fname, '^\s*', '', '')
  " append ftextmarker and indentation
  " this uses the correct amount of spaces even if you use tabs
  let fname = repeat(' ', indent(v:foldstart)) . ftextmarker . fname
  " the length of a windowline
  let lwidth = winwidth(0) - &foldcolumn
    \ - (&number || &relativenumber ? &numberwidth : 0)
  " calculate number of spaces for filling (flstring right aligned)
  let fillwidth = lwidth - strdisplaywidth(fname)
    \ - strdisplaywidth(flstring)

  let ftext = fname . repeat(' ',fillwidth) . flstring
  return ftext
endfunction

" from vimcast.org
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" }}}

set guifont=IBM\ Plex\ Mono:h13
" vim: foldmethod=marker
