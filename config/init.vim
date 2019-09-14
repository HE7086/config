scriptencoding utf-8
set nocompatible

" Use colours and encoding
set encoding=utf-8
" set termguicolors
" set t_Co=256

" Always show statusline
set laststatus=2
"set showmode

" kitty vim adapter
if $TERM == "xterm-kitty"
    let &t_ut=''
endif

" use vim packages in ~/.vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

set autoread
" colors and syntax
syntax enable
syntax on
filetype on
filetype plugin on
colorscheme solarized
set background=dark
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline_extensions=[]
set guifont=Fira\ Code\ Retina
"set cursorline cursorcolumn

set nofoldenable
" tab and indent settings
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent

" no bells 
set noerrorbells
set novisualbell

set number
set relativenumber
set showcmd
" set mouse=a

" searching settings
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

set lazyredraw

set nolist
set listchars=eol:¶,tab:>_,trail:·,extends:¦,precedes:¦,space:·,nbsp:°

" word wrap only for text files
set nowrap
autocmd BufRead,BufNewFile *.txt,*.md,*.tex setlocal wrap
" better movement for text editing
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap j gj
autocmd BufRead,BufNewFile *.txt,*.md,*.tex nnoremap k gk

" some key bindings
" avoid false movement on first/lastline
function MoveLineUp()
    if line(".") == line("$")
        execute "normal! ddP"
    elseif line(".") != 1
        execute "normal! ddkP"
    endif
endfunction
" normal mod: Alt + hjkl -> move/indent line
nmap <A-h> <<
nmap <A-j> ddp==
nmap <silent> <A-k> :call MoveLineUp()<CR>==
nmap <A-l> >>
" insert/command mod: Alt + hjkl -> move cursor
noremap! <A-h> <left>
noremap! <A-j> <down>
noremap! <A-k> <up>
noremap! <A-l> <right>
" temporarily disable highlighting for searach
noremap <F5> :nohlsearch<CR>
" toggle line number for copying
noremap <F6> :set nu! rnu!<CR>
" toggle wrap
noremap <F7> :set wrap!<CR>
" toggle list - show all characters
noremap <F8> :set list!<CR>
" Format the hole file
nnoremap =-= gg=G
" Save without exit
nnoremap ZS :w<CR>
