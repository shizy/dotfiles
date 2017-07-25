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
set relativenumber
set scrolloff=12
set sessionoptions=blank,buffers,curdir,folds,globals,help,tabpages,winsize
"set shada=!,%,'100,<50,s10,h
set wildcharm=<Tab>
set wildchar=<Tab>
set wildmenu
set wildmode=full,list

let mapleader = ";"
let maplocalleader = ";"
if !exists("g:source_once")
    source $XDG_CONFIG_HOME/nvim/functions.vim
    source $XDG_CONFIG_HOME/nvim/notmuch-neovim.vim

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

    let g:source_once=1
endif

" ========== PACKAGES ==========
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

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
Plug 'tpope/vim-repeat'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Syntax & Highlighting
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'plasticboy/vim-markdown'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-syntax-extra'

call plug#end()

" ========== SETTINGS ==========

" Deoplete
let g:deoplete#enable_at_startup = 1

" LaTeX
let g:tex_flavor = 'context'

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
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_context_context_maker = {
            \ 'cwd': '%:p:h',
            \ 'args': ['--jit', '--synctex', '--nonstopmode', '%:t'],
            \ 'append_file': 0,
            \ 'errorformat': '%.%# on line %l in file %f:%m,'.
            \                '%E%.%# on line %l in file %f:,%C,%Z%m'
            \ }
let g:neomake_context_enabled_makers = ['context']
let g:neomake_go_go_maker = {
            \ 'args': ['install', '%:p:h:t'],
            \ 'append_file': 0
            \ }
let g:neomake_go_enabled_makers = ['go']

" Signify
let g:signify_realtime = 1
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_change = '~'
let g:signify_sign_delete_first_line = '^'

" UltiSnips
let g:UltiSnipsSnippetsDir = $XDG_CONFIG_HOME . '/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsEditSplit = "vertical"

" ========== MAPPINGS ==========

noremap             j               gj
noremap             k               gk
noremap             <A-j>           10j
noremap             <A-k>           10k
noremap             <A-h>           b
noremap             <A-l>           e
map                 <A-C-j>         <C-w>j
map                 <A-C-k>         <C-w>k
map                 <A-C-h>         <C-w>h
map                 <A-C-l>         <C-w>l
nmap                <A-S-h>         :tabp<CR>
nmap                <A-S-l>         :tabn<CR>
nmap                '               `
nmap                ''              :call Context_Mark_Jump()<CR>
nmap                <A-'>           :marks<CR>:norm<Space>`

nnoremap            <Esc>           :noh<CR><Esc>
nnoremap            <A-b>           :b#<CR>
nnoremap            <Tab>           <C-w>w
nnoremap            <A-Tab>         <C-w>W
nnoremap            <A-z>           :call Save()<CR>:qa<CR>
nnoremap            <A-u>           <C-r>
nnoremap            <A-r>           :e#<CR>
nnoremap            <A-Left>        :vertical resize -10<CR>
nnoremap            <A-Right>       :vertical resize +10<CR>
nnoremap            <A-Up>          :resize -10<CR>
nnoremap            <A-Down>        :resize +10<CR>
"nnoremap            <A-C-/>         :noh<CR>
nnoremap            <A-.>           :call LocationNext()<CR>
nnoremap            <A-,>           :call LocationPrevious()<CR>
nnoremap            <A->>           ]s
nmap                <A-/>           :noh<CR>:call Clear_Context_Mark()<CR>:unlet b:alt_context<CR>
nmap                <A-Space>       :call Filter_Buffers()<CR>:B<Space><Tab><C-p>
nmap                <A-s>           :call Filter_Buffers()<CR>:SB<Space><Tab><C-p>
nmap                <A-v>           :call Filter_Buffers()<CR>:VB<Space><Tab><C-p>
nmap                <A-S-x>         :call Filter_Buffers()<CR>:BD<Space><Tab><C-p>
nmap                <A-x>           :bp<CR>:bd!<Space>#<CR>
nmap                <A-q>           ZZ
nmap                <A-CR>          :call Zoom()<CR>
nmap                <A-t>           :sp<CR>:term<CR>
nmap                <A-S-t>         :tabnew<CR>
nmap                <A-w>           :call Save()<CR>
nmap                <A-S-w>         :w !sudo tee % > /dev/null<CR>
nmap                <Leader>/       <Esc>:%s/
nmap                <Leader>-       :e %:h<Tab><Tab><C-p>
nmap                <A-1>           1gt
nmap                <A-2>           2gt
nmap                <A-3>           3gt
nmap                <A-4>           4gt
nmap                <A-5>           5gt
nmap                ga              <Plug>(EasyAlign)
nmap                <A-=>           <C-a>
nmap                <A-->           <C-x>
nmap                <A-n>           <S-n>
nmap                <Space>         <C-T>
nmap                <CR>            <C-]>

imap                jj              <Esc>
imap                jk              <Esc>:call Save()<CR>
imap                <A-j>           <C-n>
imap                <A-k>           <C-p>

cmap                <A-l>           <C-n>
cmap                <A-h>           <C-p>
cnoremap            <A-x>           <C-E><C-U>
cmap                jj              <C-c><Esc>
cmap                <A-Space>       <C-c><Esc>
cmap                jk              <CR>

tmap                <A-CR>          <C-\><C-n>:call Zoom()<CR>
tmap                <A-z>           <C-\><C-n>:qa<CR>
tmap                <A-Space>       <C-\><C-n>:call Filter_Buffers()<CR>:B<Space><Tab><C-p>
tmap                <Esc>           <C-\><C-n>
tmap                <A-x>           <C-\><C-n>:bd!<CR>
tmap                <A-q>           <C-\><C-n>ZZ
tmap                <A-b>           <C-\><C-n>:b#<CR>
tmap                <A-Tab>         <C-\><C-n><C-w>p
tmap                <A-C-j>         <C-\><C-n><C-w>j
tmap                <A-C-k>         <C-\><C-n><C-w>k
tmap                <A-C-h>         <C-\><C-n><C-w>h
tmap                <A-C-l>         <C-\><C-n><C-w>l

vnoremap            <Space><Space> zf
vmap                <Leader>/       <Esc>:'<,'>s/
vmap                <A-,>           <gv
vmap                <A-.>           >gv

" CHORDS
vmap                <Leader>sh      <Esc>:silent '<,'>w !share<CR>
nmap                <Leader>sh      :silent w !share<CR>
nmap                <Leader>vm      :new<CR>:call NotmuchNeovim()<CR>
nmap                <Leader>vf      :call Set_Buffer_Filter()<CR>
nmap                <Leader>vs      :UltiSnipsEdit<CR>
xmap                <Leader>va      <Plug>(EasyAlign)
nmap                <Leader>vu      :PlugUpdate<CR>
nmap                <Leader>gc      :Git checkout<space>
nmap                <Leader>gs      :Gstatus<CR><C-n>
nmap                <Leader>gp      :Git push<space>
nmap                <Leader>gd      :Gdiff<CR>
nmap                <Leader>gb      :Gbrowse<CR>
vmap                <Leader>gb      <Esc>:'<,'>:Gbrowse<CR>
nmap                <Leader>gl      :Gpull<CR>

" ========== AUTOCOMMANDS ==========

au FileType javascript           nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h; npm start<CR>
au FileType go                   nmap <buffer> <Leader>; :sp<CR>:te! $GOPATH/bin/%:p:h:t<CR>
au FileType sh                   nmap <buffer> <Leader>; :sp<CR>:te! %:p<CR>
au FileType c                    nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h:h; make<CR>
au BufWritePost *                Neomake
au WinEnter,BufWinEnter term://* startinsert
au WinLeave,BufWinLeave term://* stopinsert
au FileType snippets,help,man,gitcommit setlocal nobuflisted

au BufWinEnter *.md
    \ set syntax=markdown |
    \ setlocal nofoldenable |
au FileType gitcommit
    \ nmap <buffer> <A-.> <C-n> |
    \ nmap <buffer> <A-,> <C-p> |
    \ nmap <buffer> c     <S-c>i<Left>|
    \ nmap <buffer> p     :wq<CR>:Gpush<space> |
    \ nmap <buffer> A     :Gcommit --amend --reuse-message=HEAD<CR> |
au FileType help,man
    \ setlocal ro |
    \ nmap <buffer> u <C-T> |
