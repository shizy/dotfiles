set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tomasr/molokai'
Plugin 'moll/vim-node'
Plugin 'tpope/vim-sensible'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Plugin 'scrooloose/nerdtree'
Plugin 'moll/vim-bbye'

call vundle#end()
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set number
set noswapfile
:colors molokai
:syntax on
let g:molokai_original = 1
let g:rehash256 = 1
let g:ctrlp_show_hidden = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_save_periodic = 5
let g:session_default_to_last = 1
let g:NERDTreeShowHidden = 1
:nmap <S-j> :bp!<CR>
:nmap <S-k> :bn!<CR>
:nmap <S-d> :CtrlP<CR>
:nmap <S-x> :Bdelete!<CR>
autocmd BufNewFile,BufRead *.styl set filetype=stylus
autocmd BufNewFile,BufRead *.ejs set filetype=js
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd vimenter * NERDTree
autocmd vimleave * :SaveSession
