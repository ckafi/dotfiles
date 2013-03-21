" A vim configuration file
" Written by Tobias Frilling (tobias@frilling-online.de)
" Any copyright is dedicated to the Public Domain.
" http://creativecommons.org/publicdomain/zero/1.0/
" So feel free to use any line you want.

" Prologue {{{
set nocompatible          " Don't make Vim vi-compatible
syntax enable             " Enable syntax highlighting
" }}}

" Vundle {{{
filetype off              " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
" github repos
Bundle 'ckafi/vim-template'
Bundle 'ervandew/supertab'
Bundle 'guns/vim-clojure-static'
Bundle 'jiangmiao/auto-pairs'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'SirVer/ultisnips'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-foreplay'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/ZoomWin'
filetype plugin indent on " required!
" }}}

" Settings {{{
if has("gui_running")
  set columns=90          " Resize GVim to 90x25
  set lines=25            " ...
endif
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
set ignorecase            " Do case insensitive matching
set smartcase             " Do smart case matching
set incsearch             " Do an incremental search
set hlsearch              " Highlight matching strings when searching
set hidden                " Hide buffers when they are abandoned
set mouse=a               " Enable mouse usage (all modes)
set splitbelow            " For split: new window below old one
set splitright            " For vsplit: new window right of old one
set lazyredraw            " Do not redraw the screen during macros
set scrolloff=3           " Number of lines always above/below cursor
set wildmenu              " Use a menu in command completion
set wildmode=longest:full " Complete longest common string and start wildmenu
set wildmode+=full        " ... then go to next full match
set autoindent            " Use auto indenting
set smartindent           " ... and smart-indenting
set pastetoggle=<F8>      " Toggle (no)paste with F8
set undofile              " Save undo history
set undodir=~/.vim/undo/  " Directory for undo files
set backup                " Save backups
set backupdir=~/.vim/backup/ " Directory for backup files
set directory=~/.vim/swap//  " Directory for swap files with complete path
set modeline              " Enable modelines
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
set foldcolumn=2          " Width of the fold column
set foldtext=MyFoldText() " Function for the text on closed folds
set spelllang=de          " Language for spell checking
set shiftwidth=2          " Number of spaces for each (auto)indent
set tabstop=2             " Number of spaces a Tab counts for in file
set softtabstop=2         " Number of spaces a Tab counts for in insert
set expandtab             " Use appropriate number of spaces instead of a tab
set linebreak             " (Soft)wrap long lines
set showbreak=└\          " Char to show at beginning of wrapped lines
set textwidth=80          " Max. length of line for auto-formatting
set formatoptions=c       " Auto-wrap comments
set formatoptions+=r      " Inset comment leader after <Enter>
set formatoptions+=q      " Allow formatting of comments with 'gq'
set formatoptions+=n      " Recognize numbered lists
set formatoptions+=l      " Don't break already too long lines
set guifont=Ubuntu\ Mono\ 12 " Font for GVim
set guioptions+=c         " Use console for simple dialogues in GVim
set guioptions-=mrLtT     " Remove menu-,scroll- and toolbar from GUI
set completeopt=menu      " Use a popup menu for completion
set completeopt+=menuone  " ... also when there is only one match
set completeopt+=longest  " Only insert the longest common text
set completeopt+=preview  " Show information about current item in preview
set cryptmethod=blowfish  " Default cipher for encryted files
set laststatus=2          " Always show status line
set shortmess+=I          " Don't show intro message
set history=1000          " remember more commands and searches
set statusline=(%n)%f\ %m%<%r\ %c,%l\/%L(%P)%=%y%h%w%q[%{&fenc}][%{&ff}]
set dictionary=/usr/share/dict/ngerman " Dictionary for <C-X><C-K>
"}}}

" Autocmds {{{
autocmd BufEnter *.go    setfiletype go
autocmd BufEnter *.pde   setfiletype arduino
autocmd BufEnter *.scala setfiletype scala
autocmd BufEnter *.tex   setfiletype tex
"}}}

" Color-Settings {{{
" Use colors for a dark background
set background=dark
" Load color scheme
colorscheme molokai
" Don't highlight closed folds
highlight Folded cterm=None, gui=None
" Highlight the 81st column if there is a character
highlight col81 ctermbg=red guibg=red
match col81 /\%<82v.\%>81v/
" make non text chars less visible
highlight NonText gui=None
highlight SpecialKey gui=None
"}}}

" Variable Settings {{{
" Disable fold colmn in taglist
let Tlist_Enable_Fold_Column = 0
" Do not adjust window width when toggling taglist
let Tlist_Inc_Winwidth = 0
" Sort tags by name
let Tlist_Sort_Type = "name"
" Use right window for taglist
let Tlist_Use_Right_Window = 1
" Only show tags from current buffer
let Tlist_Show_One_File = 1
" Taglist settings for scala
let tlist_scala_settings = 'scala;c:classes;o:objects;t:traits;T:types;m:methods;p:packages'
let g:yankring_history_dir = "$HOME/.vim"
let showmarks_enable = 0
" use user, omni or file compl depending on context
let g:SuperTabDefaultCompletionType = "context"
" enhance 'longest' completeopt
let g:SuperTabLongestEnhanced = 1
" NERDTree shows bookmars in tree
let g:NERDTreeShowBookmarks=1
" UltiSnips: Avoid map collision with Supertab
let g:UltiSnipsExpandTrigger="<c-j>"
" CtrlP should behave more like Command-T
let g:ctrlp_working_path_mode = '0'
" Stop CtrlP from interfering with YankRing"
let g:ctrlp_map = ''
"}}}

" Keymaps and Abbrevs {{{
" Disable arrow keys
imap <up> <nop>
imap <Down> <NOP>
"imap <Left> <NOP>
"imap <Right> <NOP>
" Move the screen up or down
nnoremap <Up> k<C-Y>
nnoremap <Down> j<C-E>
nmap <Left> <NOP>
nmap <Right> <NOP>
nnoremap <Space> <PageDown>
" Esc is so far away. There aren't that many word with two j's, are
" there? Alternativ: CTRL-c
inoremap jj <Esc>

let g:LustyJugglerDefaultMappings = 0
nnoremap ö :LustyJuggler<CR>

" Toggle graphical undo window
nmap <F4>  :GundoToggle<CR>
nmap <F5>  :nohls<CR>
nmap <F6>  :TagbarToggle<CR>
nmap <F7>  :NERDTreeToggle<CR>
" <F8> reserved for pastetoggle
nmap <F11> :YRShow<CR>
nmap <C-PageUp> :bnext<CR>
nmap <C-PageDown> :bprevious<CR>
nmap <C-Right> :cnext<CR>
nmap <C-Left> :cprevious<CR>
nmap <leader>l :set list!<CR>
nmap <leader>s :set spell!<CR>
nmap , <leader>
" Move up and down in the changelist
nnoremap <C-Up> g;
nnoremap <C-Down> g,
" 'Focus' the current fold by folding all the others
nnoremap <leader>z zMzv<esc>
" Make 'Y' follow 'D' and 'C' conventions
nnoremap Y y$
" sudo and write (if you forgot to sudo first)
cmap w!! w <esc>!sudo tee % >/dev/null
" indent more or less in visual mode with < and >
vnoremap < <gv
vnoremap > >gv
" center matching line from n and N
nnoremap n nzz
nnoremap N Nzz
" make file and open/close quickfix window accordingly
nnoremap <silent> <leader>m :silent! :write \| :make \| :botright :cwindow<cr>
" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" Open a directory edit for the current working directory
nnoremap <silent> <leader>d :edit <C-R>=escape(getcwd(), " ")<CR><CR>
"open NERDTree bookmark with :bkm <name>
cabbrev bkm NERDTreeFromBookmark
" f=files, b=buffers, t=tags
nnoremap <silent> <leader>f :CtrlP<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>t :CtrlPBufTag<CR>
" }}}

" Functions {{{
" get the text for 'foldtext'
function! MyFoldText ()
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

" Local config Files {{{
" Source a file for local configurations
if filereadable($HOME."/.vim/local.vim")
  source $HOME/.vim/local.vim
endif
" }}}

" vim: foldmethod=marker
