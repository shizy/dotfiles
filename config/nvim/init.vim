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

let mapleader = "\<Space>"
:runtime! ftplugin/man.vim
source $XDG_CONFIG_HOME/nvim/functions.vim
source $XDG_CONFIG_HOME/nvim/notmuch-neovim.vim

" ========== PACKAGES ==========

call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')

" Color Scheme
Plug 'croaker/mustang-vim'

" Interaction
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'

" Utility
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'

" Syntax & Highlighting
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'plasticboy/vim-markdown'

call plug#end()

" ========== SETTINGS ==========

" LaTeX
let g:tex_flavor = 'latex'

" Colorscheme
call Scheme("mustang")

" Neomake
let g:neomake_error_sign = {
            \ 'text': '',
            \ 'texthl': 'ErrorMsg',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_informational_sign = {
            \ 'text': '',
            \ 'texthl': 'Question',
            \ }
let g:neomake_javascript_jshint_exe = $XDG_DATA_HOME . '/npm/bin/jshint'
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_tex_pdflatex_maker = {
            \ 'args': ['-synctex=1', '-output-directory=$HOME/docs'],
            \ }
let g:neomake_tex_enabled_makers = ['pdflatex']
let g:neomake_go_go_maker = {
            \ 'args': ['install', '%:p:h:t'],
            \ 'append_file': 0
            \ }
let g:neomake_go_enabled_makers = ['go']

" UltiSnips
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsEditSplit = "vertical"

" ========== MAPPINGS ==========

noremap             <A-j>           10j
noremap             <A-k>           10k
noremap             <A-h>           b
noremap             <A-l>           e
map                 <A-C-j>         <C-w>j
map                 <A-C-k>         <C-w>k
map                 <A-C-h>         <C-w>h
map                 <A-C-l>         <C-w>l

nnoremap            <A-b>           :b#<CR>
nnoremap            <A-Tab>         <C-w>p
nnoremap            <A-z>           :call Save()<CR>:qa<CR>
nnoremap            <A-u>           <C-r>
nnoremap            <A-r>           :e#<CR>
nnoremap            <A-Left>        :vertical resize -10<CR>
nnoremap            <A-Right>       :vertical resize +10<CR>
nnoremap            <A-Up>          :resize -10<CR>
nnoremap            <A-Down>        :resize +10<CR>
nnoremap            <A-/>           :noh<CR>
nnoremap            <A-.>           :call LocationNext()<CR>
nnoremap            <A-,>           :call LocationPrevious()<CR>
nnoremap <silent>   <Leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nmap                <A-Space>       :ls<CR>:b<Space><Tab><C-p>
nmap                <A-s>           :ls<CR>:sb<Space><Tab><C-p>
nmap                <A-v>           :ls<CR>:vert:sb<Space><Tab><C-p>
nmap                <A-S-x>         :ls<CR>:bd!<Space><Tab><C-p>
nmap                <A-x>           :bp<CR>:bd!<Space>#<CR>
nmap                <A-q>           ZZ
nmap                <A-CR>          :call Zoom()<CR>
nmap                <A-t>           :sp<CR>:term<CR>
nmap                <A-w>           :call Save()<CR>
nmap                <A-S-w>         :w !sudo tee % > /dev/null<CR>
nmap                <Leader>/       <Esc>:%s/
"nmap                <Leader>b       :Gbrowse<CR>
nmap                <Leader>b       :Git checkout<space>
nmap                <Leader>s       :Gstatus<CR><C-n>
nmap                <Leader>p       :silent w !share<CR>
nmap                <Leader>-       :e %:h<Tab><Tab><C-p>
nmap                <Leader>e       :UltiSnipsEdit<CR>
nmap                <Leader>i       zg
nmap                <Leader>m       :new<CR>:call NotmuchNeovim()<CR>
nmap                <A-1>           1gt
nmap                <A-2>           2gt
nmap                <A-3>           3gt
nmap                <A-4>           4gt
nmap                <A-5>           5gt
nmap                ga              <Plug>(EasyAlign)
nmap                <A-=>           <C-a>
nmap                <A-->           <C-x>
nmap                <A-n>           <S-n>

imap                jj              <Esc>
imap                jk              <Esc>:call Save()<CR>

cmap                <A-Tab>         <C-n>
cmap                <A-S-Tab>       <C-p>
cnoremap            <A-h>           <S-Left> 
cnoremap            <A-l>           <S-Right>
cnoremap            <A-x>           <C-E><C-U>
cmap                <A-j>           <Down>
cmap                <A-k>           <Up>
cmap                jj              <C-c><Esc>
cmap                <A-Space>       <C-c><Esc>
cmap                jk              <CR>

tmap                <A-CR>          <C-\><C-n>:call Zoom()<CR>
tmap                <A-z>           <C-\><C-n>:qa<CR>
tmap                <A-Space>       <C-\><C-n>:ls!<CR>:b<Space><Tab><C-p>
tmap                <Esc>           <C-\><C-n>
tmap                <A-x>           <C-\><C-n>:bd!<CR>
tmap                <A-q>           <C-\><C-n>ZZ
tmap                <A-b>           <C-\><C-n>:b#<CR>
tmap                <A-Tab>         <C-\><C-n><C-w>p
tmap                <A-C-j>         <C-\><C-n><C-w>j
tmap                <A-C-k>         <C-\><C-n><C-w>k
tmap                <A-C-h>         <C-\><C-n><C-w>h
tmap                <A-C-l>         <C-\><C-n><C-w>l

vnoremap            <Leader><Space> zf
vmap                <Leader>/       <Esc>:'<,'>s/
vmap                <Leader>p       <Esc>:silent '<,'>w !share<CR>
vmap                <A-,>           <gv
vmap                <A-.>           >gv
vmap                <Leader>b       <Esc>:'<,'>:Gbrowse<CR>

xmap                ga              <Plug>(EasyAlign)

" ========== AUTOCOMMANDS ==========

au FileType javascript
            \ nmap <buffer> <Leader>r :sp<CR>:te! cd %:p:h; npm start<CR> |
            \ nmap <buffer> <Leader>t :sp<CR>:te! cd %:p:h; npm test<CR>  |
au FileType go                   nmap <buffer> <Leader>r :sp<CR>:te! $GOPATH/bin/%:p:h:t<CR>
au FileType sh                   nmap <buffer> <Leader>r :sp<CR>:te! %:p<CR>

au BufWritePost *                Neomake
au BufNewFile,BufRead *.styl     set filetype=stylus
au BufNewFile,BufRead *.ejs      set filetype=js
au BufNewFile,BufRead *.ejs      set filetype=html
au BufWinEnter *.md
    \ set syntax=markdown |
    \ setlocal nofoldenable |
au BufWinEnter *.toml            set filetype=toml
au WinEnter,BufWinEnter term://* startinsert
au WinLeave,BufWinLeave term://* stopinsert
au FileType gitcommit
    \ nmap <buffer> <A-.> <C-n> |
    \ nmap <buffer> <A-,> <C-p> |
    \ nmap <buffer> c     <S-c>i |
    \ nmap <buffer> p     :wq<CR>:Gpush<space> |
au FileType git,gitcommit
    \ setlocal nofoldenable |
    \ nmap <buffer> <A-q> :bw!<CR> |
au FileType snippets nnoremap <buffer> <A-q> :bw!<CR>ZZ
au FileType help,man
    \ setlocal ro |
    \ setlocal nobuflisted |
    \ nmap <buffer> <CR>  <C-]> |
    \ nmap <buffer> u     <C-T> |
    \ nmap <buffer> <A-q> :bw!<CR> |
    \ nmap <buffer> <A-x> :bw!<CR> |
