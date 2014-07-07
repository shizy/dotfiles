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

call vundle#end()
filetype plugin indent on

:colors molokai
:syntax on
let g:molokai_original = 1
let g:rehash256 = 1
let g:ctrlp_show_hidden = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'powerlineish'
:nmap <S-j> :bp<CR>
:nmap <S-k> :bn<CR>
:nmap <S-d> :CtrlP<CR>
