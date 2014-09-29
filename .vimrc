" ========== PACKAGES ==========

set nocompatible
filetype off
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    au GUIEnter * simalt ~x
    set rtp+=~/vimfiles/bundle/Vundle.vim/
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" Package Management
Plugin 'gmarik/Vundle.vim'

" Buffer Management
Plugin 'moll/vim-bbye'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Looks
Plugin 'tomasr/molokai'
Plugin 'bling/vim-airline'

" Interaction
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-expand-region'

" Utility
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'terryma/vim-multiple-cursors'

" Syntax & Highlighting
Plugin 'scrooloose/syntastic'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'

call vundle#end()

" ========== SETTINGS ==========

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set noswapfile
set ttyscroll=0
set encoding=utf-8

filetype plugin indent on
colors molokai
" colors fix!!
syntax on
let mapleader = "\<Space>"

" Molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1

" Session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_save_periodic = 5
let g:session_default_to_last = 1

" CtrlP
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
        \ 'file': '\.exe$\|\.so$\|\.dat$'
        \ }
endif

" Multi Cursor
let g:multi_cursor_next_key = '<S-s>'
let g:multi_cursor_skip_key = 's'

" ========== MAPPINGS ==========

:nnoremap <S-j> 10j
:nnoremap <S-k> 10k
:nnoremap <S-h> :bp!<CR>
:nnoremap <S-l> :bn!<CR>
:nmap <Leader>x :Bdelete!<CR>
:nmap <Leader>w :w<CR>
:nmap <Leader>- :CtrlP<CR>
:nmap <Leader>/ <Esc>:%s/
:vmap <Leader>/ <Esc>:'<,'>s/
:nmap <Leader>t :Tabularize /
:vmap <Leader>t :Tabularize /
:vmap v 	    <Plug>(expand_region_expand)
:imap jj 	    <Esc><CR>
:imap jk 	    <Esc>:w<CR>

" ========== FILETYPES ==========

au BufNewFile,BufRead *.styl set filetype=stylus
