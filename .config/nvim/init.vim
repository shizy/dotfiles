" Auto install Plug & Spell Files
if empty(glob('$XDG_DATA_HOME/nvim/site/autoload/plug.vim'))
    echo "Downloading and installing Plug"
    silent !curl -fLo $XDG_DATA_HOME/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

if empty(glob('$XDG_DATA_HOME/nvim/site/spell/en.utf-8.spl'))
    echo "Downloading and installing Spell Files"
    silent !curl -o $XDG_DATA_HOME/nvim/site/spell/en.utf-8.spl --create-dirs
    \ http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl
endif

" If GUI Version
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    au GUIEnter * simalt ~x
endif

" ========== OPTIONS ==========

set hidden
set noshowmode
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set noswapfile
set cursorline
set lazyredraw
set encoding=utf-8
set clipboard=unnamedplus
set breakindent
set linebreak
set nobackup
set nowritebackup
set wildcharm=<Tab>
set wildmenu
set wildmode=full,list
set wildignorecase

syntax on
filetype plugin indent on
let mapleader = "\<Space>"
:runtime! ftplugin/man.vim
source $XDG_CONFIG_HOME/nvim/functions.vim

" ========== PACKAGES ==========

call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')

" Buffer Management
Plug 'moll/vim-bbye'

" Color Scheme
Plug 'tomasr/molokai'

" Interaction
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

" Utility
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'

" Syntax & Highlighting
Plug 'airblade/vim-gitgutter'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'plasticboy/vim-markdown'

call plug#end()

" ========== SETTINGS ==========

" LaTeX
let g:tex_flavor = 'latex'

" Molokai
color molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Neomake
let g:neomake_error_sign = {
            \ 'text': '',
            \ 'texthl': 'ErrorMsg',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_javascript_jshint_exe = $XDG_DATA_HOME . '/node_modules/bin/jshint'
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_tex_pdflatex_maker = {
            \ 'args': ['-synctex=1', '-output-directory=$HOME/docs'],
            \ }
let g:neomake_tex_enabled_makers = ['pdflatex']

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = $XDG_CONFIG_HOME . "/nvim/snippets"

" ========== MAPPINGS ==========

noremap             <A-j>           10j
noremap             <A-k>           10k
map                 <A-C-j>         <C-w>j
map                 <A-C-k>         <C-w>k
map                 <A-C-h>         <C-w>h
map                 <A-C-l>         <C-w>l

nnoremap            <A-b>           :b#<CR>
nnoremap            <A-Tab>         <C-w>p
nnoremap            <A-z>           :call Save()<CR>:qa<CR>
nnoremap            <A-u>           <C-r>
nnoremap            <A-Left>        :vertical resize -10<CR>
nnoremap            <A-Right>       :vertical resize +10<CR>
nnoremap            <A-Up>          :resize -10<CR>
nnoremap            <A-Down>        :resize +10<CR>
nnoremap            <A-/>           :noh<CR>
nnoremap            <A-.>           :lnext<CR>
nnoremap            <A-,>           :lprev<CR>
nnoremap <silent>   <Leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nmap                <A-Space>       :ls<CR>:b<Space><Tab><C-p>
nmap                <A-s>           :ls<CR>:sb<Space><Tab><C-p>
nmap                <A-v>           :ls<CR>:vert:sb<Space><Tab><C-p>
nmap                <A-S-x>         :ls<CR>:Bdelete!<Space><Tab><C-p>
nmap                <A-x>           :Bdelete!<CR>
nmap                <A-q>           ZZ
nmap                <A-o>           :call Zoom()<CR>
nmap                <A-t>           :sp<CR>:term<CR>
nmap                <A-w>           :call Save()<CR>
nmap                <A-S-w>         :w !sudo tee % > /dev/null<CR>
nmap                <Leader>/       <Esc>:%s/
nmap                <Leader>b       :Gbrowse<CR>
nmap                <Leader>s       :Gstatus<CR><C-n>
nmap                <Leader>p       :Gpush<space>
nmap                <Leader>l       :Gllog --<CR><CR>:lopen<CR><C-w>p
nmap                <Leader>-       :e %:h<Tab><Tab><C-p>
nmap                <Leader>e       :UltiSnipsEdit<CR>
nmap                <Leader>i       zg
nmap                <A-1>           1gt
nmap                <A-2>           2gt
nmap                <A-3>           3gt
nmap                <A-4>           4gt
nmap                <A-5>           5gt
nmap                ga              <Plug>(EasyAlign)

imap                jj              <Esc>
imap                jk              <Esc>:call Save()<CR>

cmap                <A-l>           <C-n>
cmap                <A-h>           <C-p>
cmap                <A-j>           <Down>
cmap                <A-k>           <Up>
cmap                jj              <C-c><Esc>
cmap                <A-Space>       <C-c><Esc>
cmap                jk              <CR>

tmap                <A-z>           <C-\><C-n>:qa<CR>
tmap                <A-Space>       <C-\><C-n><C-w>:ls<CR>:b<Space><Tab><C-p> "For whatever reason <C-w> aleviates some bug residing here
tmap                <Esc>           <C-\><C-n>
tmap                <A-q>           <C-\><C-n>ZZ
tmap                <A-b>           <C-\><C-n>:b#<CR>
tmap                <A-Tab>         <C-\><C-n><C-w>p
tmap                <A-C-j>         <C-\><C-n><C-w>j
tmap                <A-C-k>         <C-\><C-n><C-w>k
tmap                <A-C-h>         <C-\><C-n><C-w>h
tmap                <A-C-l>         <C-\><C-n><C-w>l

vnoremap            <Leader><Space> zf
vmap                <Leader>/       <Esc>:'<,'>s/
vmap                <Leader>t       :Tabularize /
vmap                <A-,>           <gv
vmap                <A-.>           >gv
vmap                <Leader>b       <Esc>:'<,'>:Gbrowse<CR>

xmap                ga              <Plug>(EasyAlign)

" ========== AUTOCOMMANDS ==========

au BufWritePost * Neomake
au BufNewFile,BufRead *.styl set filetype=stylus
au BufNewFile,BufRead *.ejs  set filetype=js
au BufNewFile,BufRead *.ejs  set filetype=html
au BufNewFile,BufRead,BufWinEnter ~/.cache/mutt/*
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nonumber |
    \ setlocal syntax=markdown |
    \ setlocal fo+=aw |
    \ imap <buffer> jk <Esc>:w<CR> |
    \ nmap <buffer> <Leader>w :w<CR> |
    \ nnoremap <buffer> <A-.>      ]s |
    \ nnoremap <buffer> <A-,>      [s
au FileType gitcommit
    \ nmap <buffer> <A-.>   <C-n> |
    \ nmap <buffer> <A-,>   <C-p> |
    \ nmap <buffer> c       <S-c>i |
    \ nmap <buffer> q       :wq<CR> |
    \ nmap <buffer> p       :wq<CR>:Gpush<space> |
au FileType git
    \ setlocal nofoldenable |
    \ nmap  <buffer> q      :lclose<CR>:bw<CR> |
au BufWinEnter *.md set syntax=markdown
au BufWinEnter *.toml set filetype=toml
au FileType netrw nmap <buffer> <Esc> :bd<CR>
au WinEnter,BufWinEnter term://* startinsert
au WinLeave,BufWinLeave term://* stopinsert
au FileType snippets nnoremap <buffer> <A-q> :Bdelete!<CR>ZZ
au FileType help,man
    \ setlocal ro |
    \ nmap <buffer> <CR> <C-]> |
    \ nmap <buffer> u    <C-T> |

" Color & theme over-rides
source $XDG_CONFIG_HOME/nvim/theme-overrides.vim
