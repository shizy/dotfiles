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
Plugin 'bling/vim-airline'

" Looks
Plugin 'tomasr/molokai'

" Interaction
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'

" Utility
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'neilagabriel/vim-geeknote'

" Syntax & Highlighting
Plugin 'scrooloose/syntastic'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Plugin 'plasticboy/vim-markdown'

call vundle#end()

" ========== SETTINGS ==========

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set noswapfile
set ttyfast
set ttyscroll=3
set lazyredraw
set encoding=utf-8
set t_Co=256
set clipboard=unnamed

syntax on
filetype plugin indent on
let mapleader = "\<Space>"

" Molokai
color molokai
hi Normal ctermbg=none
hi LineNr ctermfg=59 ctermbg=none
hi CursorLineNr ctermfg=208 ctermbg=none
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
    let g:ctrlp_user_command = 'ag %s -l -g "" --ignore "\.git$\|\.hg$\|\.svn$\|\.node_modules$"'
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

:nnoremap  <S-j>      10j
:nnoremap  <S-k>      10k
:nnoremap  <S-h>      :bp!<CR>
:nnoremap  <S-l>      :bn!<CR>
:nnoremap  <S-x>      :Bdelete!<CR>
:nnoremap  <S-u>      <C-r>
:nnoremap  <tab>      <C-w>w
:nnoremap  <S-tab>    <C-w>W
:nnoremap  <Leader>x  ZZ
:nmap      <Leader>h  <C-w>s
:nmap      <Leader>v  <C-w>v
:nmap      <Leader>w  :w<CR>
:nmap      <Leader>-  :CtrlP<CR>
:nmap      <Leader>/  <Esc>:%s/
:vmap      <Leader>/  <Esc>:'<,'>s/
:nmap      <Leader>t  :Tabularize /
:vmap      <Leader>t  :Tabularize /
:nmap      <Leader>e  :Geeknote<CR>
:nmap      <Leader>b  :GeeknoteCreateNotebook
:nmap      <Leader>n  :GeeknoteCreateNote
:nmap      <Leader>s  :Gstatus<CR>
:nmap      <Leader>c  :Gcommit -m
:nmap      <Leader>p  :Gpush
:vmap      v          <Plug>(expand_region_expand)
:imap      jj         <Esc>
:imap      jk         <Esc>:w<CR>

:inoremap  {;         {};<Left><Left>
:inoremap  {<CR>      {<CR>}<Esc>O
:inoremap  (;         ();<Left><Left>
:inoremap  (          ()<Left>
:inoremap  <expr> )   strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
:inoremap  {          {}<Left>
:inoremap  <expr> }   strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
:inoremap  [          []<Left>
:inoremap  <expr> ]   strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

" ========== FILETYPES ==========

au BufNewFile,BufRead *.styl set filetype=stylus
au BufNewFile,BufRead *.jade set filetype=js
au BufNewFile,BufRead *.jade set filetype=html
au BufNewFile,BufRead *.ejs  set filetype=js
au BufNewFile,BufRead *.ejs  set filetype=html
au BufWinEnter *.md          set syntax=markdown
au BufWinEnter /tmp/*        set syntax=markdown
