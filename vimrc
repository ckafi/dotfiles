" System-Stuff {{{
syntax on
filetype plugin indent on

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
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
set scrolloff=3
set undofile
set undodir=~/.backups
set modeline
set visualbell
"set list
set listchars=tab:→\ ,eol:¬
set number
set foldmethod=marker
set foldcolumn=1
set spelllang=de
set backup
set backupdir=~/.backups
set shiftwidth=4
set tabstop=4
set textwidth=70
set formatoptions=croql
"set guifont=Envy\ Code\ R\ 11
"set guifont=DejaVu\ Sans\ Mono\ 9
set guifont=Inconsolata\ 12
set guioptions+=f
set completeopt=menu,menuone,longest,preview
"}}}

" Autocmds {{{
autocmd FileType perl   setlocal makeprg=perl\ %
autocmd FileType python setlocal comments=:# makeprg=python3\ %
autocmd FileType scala  setlocal ts=2 sts=2 sw=2
autocmd FileType tex    setlocal fo+=aw
autocmd FileType zsh    setlocal makeprg=chmod\ +x\ %;./%

autocmd BufEnter *.go    setlocal filetype=go
autocmd BufEnter *.pde   setlocal filetype=arduino
autocmd BufEnter *.scala setlocal filetype=scala
"}}}

" color {{{
set background=dark
colorscheme relaxedgreen
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
let tlist_scala_settings = 'scala;c:classes;t:traits;T:types;m:methods;C:constants;l:local variables;p:packages'
" für vim-latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
let g:Tex_ViewRule_pdf = "evince"
let g:Tex_ViewRule_dvi = "xdvi"
"}}}

" Keymaps {{{
noremap   <silent> <F5>       :nohls<CR>
noremap   <silent> <F6>       :TlistToggle<CR>
noremap   <silent> <F7>       :NERDTreeToggle<CR>

nnoremap  <silent> <F11>      :YRShow<CR>

nnoremap  <silent> <leader>l  :set list!<CR>
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
