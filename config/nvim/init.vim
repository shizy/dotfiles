" ========== OPTIONS =========={{{
" If GUI Version
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    au GUIEnter * simalt ~x
endif

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
set foldmethod=marker
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
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%m
set completeopt-=preview
set tags=./tags;/

let mapleader = ";"
let maplocalleader = ";"
"}}}

" ========== RUNONCE =========={{{
if !exists("g:source_once")
    source $XDG_CONFIG_HOME/nvim/functions.vim

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
"}}}

" ========== PACKAGES =========={{{
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')

" Color Scheme
Plug 'morhetz/gruvbox'

" Utility
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-go', { 'do': 'make' } "go get -u github.com/mdempsky/gocode
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" Syntax & Highlighting
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'plasticboy/vim-markdown'
Plug 'mhinz/vim-signify'
Plug 'justinmk/vim-syntax-extra'
Plug 'fatih/vim-go'
Plug 'lervag/vimtex' "only for completion and highlighting

call plug#end()
"}}}

" ========== SETTINGS =========={{{

" Deoplete / Neosnippet
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#enable_optional_arguments = 0
let g:neosnippet#snippets_directory = $XDG_CONFIG_HOME . '/nvim/snippets'

" LaTeX
let g:tex_flavor = 'latex'

" Colorscheme
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
call Scheme("gruvbox")

" Neomake
let g:neomake_error_sign = {
            \ 'text': ' ',
            \ 'texthl': 'ErrorMsg',
            \ }
let g:neomake_warning_sign = {
            \ 'text': '',
            \ 'texthl': 'WarningMsg',
            \ }
let g:neomake_informational_sign = {
            \ 'text': '',
            \ 'texthl': 'Question',
            \ }
let g:neomake_javascript_enabled_makers = ['jshint']
let g:neomake_tex_rubber_maker = {
            \ 'args': ['--synctex', '--inplace', '-d'],
            \ }
let g:neomake_tex_enabled_makers = ['rubber']

" netrw
let g:netrw_dirhistmax = 0
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
let g:netrw_scp_cmd = 'scp -F $PRIVATE/ssh/ssh_config'

" Signify
let g:signify_realtime = 0
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_change = '~'
let g:signify_sign_delete_first_line = '^'

" Vim-Go
let g:go_list_height = 0
let g:go_list_type = "locationlist"
let g:go_fmt_fail_silently = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_term_mode = "split"

" vimtex
if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
  endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

"}}}

" ========== MAPPINGS =========={{{
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
"nmap                <A-'>           :marks<CR>:norm<Space>`

nnoremap            ''              <C-]>
nnoremap            <A-'>           <C-T>
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
nmap                zz              za
nmap                zC              zM
nmap                zO              zR
"nnoremap            <Space>         :Lexplore<CR>
nnoremap            <CR>            :execute 'lvimgrep /' . expand("<cword>") . '/j ' . expand("%:p:h") . '/*'<CR>

imap                jj              <Esc>
imap                jk              <Esc>:call Save()<CR>
inoremap <expr>     <A-j>           pumvisible() ? "\<C-n>" : "\<C-x>\<C-o>"
imap                <A-k>           <C-p>
imap                <A-S-h>         <Esc>:tabp<CR>
imap                <A-S-l>         <Esc>:tabn<CR>
smap    <expr>      <Tab>           neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
imap    <expr>      <Tab>           neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
xmap                <Tab>           <Plug>(neosnippet_expand_target)

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

vnoremap            <Space><Space>  zf
vnoremap            p               "_dP
vmap                <Leader>/       <Esc>:'<,'>s/
vmap                <A-,>           <gv
vmap                <A-.>           >gv

" CHORDS
vmap                <Leader>sh      <Esc>:silent '<,'>w !share<CR>
nmap                <Leader>sh      :silent w !share<CR>
nmap                <Leader>vf      :call Set_Buffer_Filter()<CR>
nmap                <Leader>vs      :NeoSnippetEdit -split -vertical<CR>
xmap                <Leader>va      <Plug>(EasyAlign)
nmap                <Leader>vu      :PlugUpdate<CR>
nmap                <Leader>vt      :tabe %<CR>
nmap                <Leader>gc      :Git checkout<space>
nmap                <Leader>gs      :Gstatus<CR><C-n>
nmap                <Leader>gp      :Git push<space>
nmap                <Leader>gd      :Gdiff<space>
nmap                <Leader>gb      :Gbrowse<CR>
vmap                <Leader>gb      <Esc>:'<,'>:Gbrowse<CR>
nmap                <Leader>gl      :Gpull<CR>
nmap                <Leader>gm      :Gmerge<space>
"}}}

" ========== AUTOCOMMANDS =========={{{
au FileType javascript           nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h; npm start<CR>
au FileType sh                   nmap <buffer> <Leader>; :sp<CR>:te! %:p<CR>
au BufWritePost *                Neomake
au TermOpen,WinEnter,BufWinEnter term://* startinsert
au WinLeave,BufWinLeave term://* stopinsert
au FileType neosnippet,help,man,gitcommit setlocal nobuflisted

au BufWritePost *.c,*.h silent call system("cd " . expand("%:p:h:h") . "; ctags -R")

" note: synctex-forward breaks on ConTeXt documents!
au BufNewFile,BufRead,BufWinEnter *.tex
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nocin inde= |
    \ setlocal syntax=tex |
    \ nmap <silent><buffer> <Leader>; :call system("zathura --synctex-forward=" . line('.') . ":" . col('.') . ":" . expand("%:p") . " " . expand("%:p:r") . ".pdf &")<CR>
au BufWinEnter *.md
    \ set syntax=markdown |
    \ setlocal nofoldenable |
au FileType go
    \ nmap <buffer> <Leader>r :GoRun<CR> |
    \ nmap <buffer> <Leader>i :GoInfo<CR> |
    \ nmap <buffer> <Leader>t :GoTest<CR> |
    \ map <buffer> <Leader>c :GoCoverageToggle<CR> |
au FileType c,cpp
    \ syn match cTodo "\<\w\+_ptr\>" |
    \ syn match cTodo "\<\w\+_cb\>" |
    \ nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h:h; make<CR> |
    \ nmap <buffer> <Leader>r :sp<CR>:te! cd %:p:h:h; make run<CR> |
    \ nmap <buffer> <Leader>t :sp<CR>:te! cd %:p:h:h; make test<CR> |
    \ nmap <buffer> <A-S-b>   :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR> |
    \ call deoplete#custom#buffer_option('auto_complete', v:false)
au FileType go,c,cpp
    \ let b:surround_47 = "/*\r*/" |
au FileType help,man
    \ setlocal ro |
    \ nnoremap <buffer> u <C-T> |
    \ nnoremap <buffer> <CR> <C-]> |
"}}}
