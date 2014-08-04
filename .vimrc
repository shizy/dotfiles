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
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'bling/vim-airline'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'godlygeek/tabular'

call vundle#end()
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set number
set noswapfile
set expandtab
:colors molokai
:syntax on
let g:molokai_original = 1
let g:rehash256 = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_save_periodic = 5
let g:session_default_to_last = 1
let g:ctrlp_map = '<S-d>'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_prompt_mappings = { 'PrtExit()': [ '<esc>', '<c-c>', ';' ] }
let g:multi_cursor_next_key = '<S-s>'
let g:multi_cursor_skip_key = 's'
let g:multi_cursor_quit_key = ';'
:nmap <S-j> :bp!<CR>
:nmap <S-k> :bn!<CR>
:nmap <S-x> :bdelete!<CR>
:map ;; <Esc>
:map! ;; <Esc>
:nmap t :Tabularize /
:vmap t :Tabularize /
:inoremap ;<Return> ;
:inoremap {     {}<Left>
:inoremap {<CR> {<CR>}<Esc>O
:inoremap {{    {
:inoremap {}    {}
autocmd BufNewFile,BufRead *.styl set filetype=stylus
autocmd BufNewFile,BufRead *.ejs set filetype=js
autocmd BufNewFile,BufRead *.ejs set filetype=html
