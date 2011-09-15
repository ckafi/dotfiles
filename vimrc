" System-Stuff {{{
syntax on
filetype plugin indent on
" }}}

" sets {{{
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set hidden          " Hide buffers when they are abandoned
set hlsearch        " Hightlight matching strings
set mouse=a         " Enable mouse usage (all modes)
set splitbelow      " For split: new window below old one
set splitright      " For vsplit: new window right of old one
set lazyredraw      " Do not redraw the screen during macros
set linebreak "
set showbreak=…
set scrolloff=3
set undofile
set undodir=~/.backups
set modeline
set visualbell
set listchars=tab:⋮\ ,eol:⌐
set number
set foldmethod=marker
set foldcolumn=2
set spelllang=de
set backup
set backupdir=~/.backups
set shiftwidth=2
set tabstop=2
set textwidth=70
set formatoptions=crqaw
"set guifont=Verily\ Serif\ Mono\ 10
"set guifont=Anonymous\ Pro\ 12
"set guifont=Envy\ Code\ R\ 11
set guifont=DejaVu\ Sans\ Mono\ 10
"set guifont=Inconsolata\ 12
set guioptions+=f
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
set cursorline
highlight col79 ctermbg=red guibg=red
match col79 /\%<80v.\%>79v/
"highlight SpecialKey cterm=none guifg=#202020
"highlight NonText guifg=#202020
"}}}

" Lets {{{
"let NERDCompactSexyComs = 1
let g:vimwiki_camel_case = "0"
let g:timestamp_rep = "%F"
let g:timestamp_regexp = '\v%(Changed\s*:\s*)@<=\d{4}-\d{2}-\d{2}|TIMESTAMP'
let Tlist_Inc_Winwidth = "0"
let Tlist_Show_Menu = "1"
let Tlist_Use_Right_Window = "1"
let g:acp_completeoptPreview = 1
let g:yankring_history_dir = "$HOME/.vim"
let showmarks_enable = "0"
let tlist_scala_settings = 'scala;c:classes;o:objects;t:traits;T:types;m:methods;p:packages'
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
imap <Left> <NOP>
imap <Right> <NOP>
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>

nmap <F5>  :nohls<CR>
nmap <F6>  :TlistToggle<CR>
nmap <F7>  :NERDTreeToggle<CR>
nmap <F11> :YRShow<CR>
nmap <C-PageUp> :bnext<CR>
nmap <C-PageDown> :bprevious<CR>
nmap <C-Down> :cnext<CR>
nmap <C-Up> :cprevious<CR>
nmap <leader>l :set list!<CR>
nmap <leader>s :set spell!<CR>
" indent more or less in visual mode with < and >
vnoremap < <gv
vnoremap > >gv
" center matching line from n and N
nnoremap n nzz
nnoremap N Nzz
"open NERDTree bookmark with :bkm <name>
cabbrev bkm NERDTreeFromBookmark 
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

" from vimcast.org
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}
