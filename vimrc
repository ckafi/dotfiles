" System-Stuff {{{
set nocompatible
syntax on
filetype plugin indent on
" }}}

" sets {{{
set showcmd       " Show (partial) command in status line.
set showmatch     " Show matching brackets.
set ignorecase    " Do case insensitive matching
set smartcase     " Do smart case matching
set incsearch     " Incremental search
set hidden        " Hide buffers when they are abandoned
set hlsearch      " Hightlight matching strings
set mouse=a       " Enable mouse usage (all modes)
set splitbelow    " For split: new window below old one
set splitright    " For vsplit: new window right of old one
set lazyredraw    " Do not redraw the screen during macros
set laststatus=2  " Always show status-line
set linebreak     " (Soft)wrap long lines
set showbreak=…   " Char to show at beginning of wraped lines
set scrolloff=3   " Number of lines above/below cursor
set wildmenu      " Use a menu ind cmdcompl.
" complete longest common string and start wildmenu,
" then go to next matches
set wildmode=longest:full,full
" console dialogs for simple choices
set guioptions+=c
" remove menu-,scroll- and toolbar
set guioptions-=mrLtT
" do smart autoindenting
set autoindent
set smartindent
" toggle (no)paste with F8
set pastetoggle=<F8>
" dictionary for <C-X><C-K>
set dictionary=/usr/share/dict/ngerman
set statusline=(%n)%t%m%r%h%w%=%l\/%L,%c
set undofile
set undodir=~/.vim/undo/
set modeline
set visualbell
set listchars=tab:⋮\ ,eol:⌐,trail:×,extends:…,precedes:…
set number
set foldmethod=marker
set foldcolumn=2
set spelllang=de
set backup
set backupdir=~/.vim/backups/
set shiftwidth=2
set tabstop=2
set textwidth=70
set formatoptions=crqaw
set guifont=Foo\ Mono\ 10
set completeopt=menu,menuone,longest,preview
"}}}

" Autocmds {{{
autocmd FileType perl   setlocal makeprg=perl\ %
autocmd FileType python setlocal comments=:# makeprg=python3\ %
autocmd FileType zsh    setlocal makeprg=chmod\ +x\ %;./%
autocmd FileType tex    setlocal formatoptions+=t

autocmd BufEnter *.go    setfiletype go
autocmd BufEnter *.pde   setfiletype arduino
autocmd BufEnter *.scala setfiletype scala
"}}}

" color {{{
set background=dark
if !has('gui_running')
	let g:solarized_termcolors=256
	let g:solarized_termtrans=1
endif
colorscheme solarized
highlight Folded cterm=None, gui=None
highlight! link SpecialKey Normal
set cursorline
highlight col79 ctermbg=red guibg=red
match col79 /\%<80v.\%>79v/
"highlight SpecialKey cterm=none guifg=#202020
"highlight NonText guifg=#202020
"}}}

" Lets {{{
"let NERDCompactSexyComs = 1
let g:vimwiki_camel_case = 0
let g:timestamp_rep = "%F"
let g:timestamp_regexp = '\v%(Changed\s*:\s*)@<=\d{4}-\d{2}-\d{2}|TIMESTAMP'
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
" let VCSCommand delete hidden temporary buffers
let g:VCSCommandDeleteOnHide=1
" NERDTree shows bookmars in tree
let g:NERDTreeShowBookmarks=1

" für vim-latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_ViewRule_pdf = "evince"
let g:Tex_ViewRule_dvi = "xdvi"
"}}}

" Keymaps and Abbrevs {{{
" Disable arrow keys
imap <up> <nop>
imap <Down> <NOP>
"imap <Left> <NOP>
"imap <Right> <NOP>
" Move the screen up or down
nnoremap <Up> <C-Y>
nnoremap <Down> <C-E>
nmap <Left> <NOP>
nmap <Right> <NOP>

nmap <F5>  :nohls<CR>
nmap <F6>  :TlistToggle<CR>
nmap <F7>  :NERDTreeToggle<CR>
" <F8> reserved for pastetoggle
nmap <F11> :YRShow<CR>
nmap <C-PageUp> :bnext<CR>
nmap <C-PageDown> :bprevious<CR>
nmap <C-Down> :cnext<CR>
nmap <C-Up> :cprevious<CR>
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
cmap w!! w !sudo tee % >/dev/null
" indent more or less in visual mode with < and >
vnoremap < <gv
vnoremap > >gv
" center matching line from n and N
nnoremap n nzz
nnoremap N Nzz
"open NERDTree bookmark with :bkm <name>
cabbrev bkm NERDTreeFromBookmark 
" shortcuts for often used VCSCommands
cabbrev commit VCSCommit
cabbrev info   VCSInfo
cabbrev status VCSStatus
cabbrev diff   VCSDiff
cabbrev vdiff  VCSVimDiff
" }}}

" Functions {{{
function! Header()
	let header = readfile($HOME . "/.vim/header-template")
	call append(line(".")-1, header)
	execute ":%s_<<file>>_" . bufname("%")
	execute ":%s_<<date>>_" . strftime("%F")
	execute ":%s_<<year>>_" . strftime("%Y")
	.-11,.+12call NERDComment(0, 'sexy')
endfunction
ca header call Header()

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
