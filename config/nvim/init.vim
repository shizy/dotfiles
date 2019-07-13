" RUNONCE {{{
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

" SETTINGS {{{

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
set relativenumber
set noswapfile
set cursorline
set guicursor=n-v-c-sm:block,i-ci-ve:hor100,r-cr-o:hor20
set inccommand=nosplit
set lazyredraw
set encoding=utf-8
set clipboard=unnamedplus
set breakindent
set foldmethod=marker
set foldtext=getline(v:foldstart)
set linebreak
set nobackup
set nowritebackup
set scrolloff=12
set sessionoptions=blank,buffers,curdir,folds,globals,help,tabpages,winsize
"set shada=!,%,'100,<50,s10,h
set wildcharm=<Tab>
set wildchar=<Tab>
set wildmenu
set wildmode=full,list
"TODO: wait for 4.x: set wildoptions=pum
set grepprg=rg\ --vimgrep\ $*
set grepformat=%f:%l:%m
set completeopt-=preview
set shortmess+=c
set tags=./tags;/
let mapleader = ";"
let maplocalleader = ";"
"}}}

" PACKAGES {{{
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')

Plug 'morhetz/gruvbox'

Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-syntax-extra'
Plug 'lervag/vimtex'
Plug 'mhinz/vim-signify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()
"}}}

" OPTIONS {{{

" C
let c_syntax_for_h = 1

" Coc
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'
let g:coc_extension_root = $XDG_DATA_HOME . '/coc/extension'
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Colorscheme
set background=dark
set termguicolors
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
call Scheme("gruvbox")

" Fzf
let g:fzf_colors = {
            \ 'fg':         ['fg', 'Comment'],
            \ 'bg':         ['bg', 'Normal'],
            \ 'hl':         ['fg', 'MoreMsg'],
            \ 'info':       ['fg', 'CursorLine'],
            \ 'fg+':        ['fg', 'CursorLine'],
            \ 'bg+':        ['bg', 'CursorLine', 'CursorLine'],
            \ 'hl+':        ['fg', 'MoreMsg'],
            \ 'prompt':     ['fg', 'MoreMsg'],
            \ 'pointer':    ['fg', 'MoreMsg'],
            \ }
let g:fzf_action = {
            \ 'alt-x': 'bdelete',
            \ 'alt-t': '$tab sbuffer',
            \ 'alt-s': 'sbuffer',
            \ 'alt-v': 'vert sbuffer',
            \ }
function! s:parse_fzf_buffer_results(e)
    if len(a:e) < 2
        return
    endif
    let action = get(g:fzf_action, a:e[0])
    let buffer = matchstr(a:e[1], '\[\zs[0-9]*\ze\]')
    if action == "0" "default action
        execute 'b ' buffer
    else
        execute action ' ' buffer
        if action == 'bdelete'
            execute 'MyBuffers'
            call feedkeys('i')
        endif
    endif
endfunction
command! -bang -nargs=* MyBuffers call fzf#vim#buffers(fzf#wrap({
            \ 'options': ['--prompt=Buffers > '],
            \ 'sink*'  : function('s:parse_fzf_buffer_results'),
            \ }))

" LaTeX
let g:tex_flavor = 'latex'

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

" Surround
let g:surround_{char2nr("/")} = "/*\r*/"

" vimtex
let g:vimtex_quickfix_enabled = 0
let g:vimtex_view_method = 'zathura'

"}}}

" MAPPINGS {{{
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

nnoremap            ''              <C-o>:noh<CR>
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
nmap       <silent> <A-.>           <Plug>(coc-diagnostic-next)
nmap       <silent> <A-,>           <Plug>(coc-diagnostic-prev)
nnoremap            <A->>           ]s
nmap                <A-Space>       :call Filter_Buffers()<CR>
nmap                <A-;>           :Commands<CR>
nmap                <A-/>           :Lines<CR>
nmap                <A-e>           :Files<CR>
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
nnoremap            <CR>            :execute 'lvimgrep /' . expand("<cword>") . '/j ' . expand("%:p:h") . '/*'<CR>

imap                <C-l>           <Plug>(coc-snippets-expand)
imap                jj              <Esc>
imap                jk              <Esc>:call Save()<CR>
imap                <A-S-h>         <Esc>:tabp<CR>
imap                <A-S-l>         <Esc>:tabn<CR>
inoremap <expr>     <A-j>           pumvisible() ? "\<Down>" : "\<C-x>\<C-o>"
inoremap <expr>     <A-k>           pumvisible() ? "\<Up>" : "\<C-s>\<C-o>"
inoremap <silent><expr> <TAB>       pumvisible() ? "\<C-y>" : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : "\<TAB>"

cmap                <A-l>           <Right>
cmap                <A-h>           <Left>
cmap                <A-j>           <C-n>
cmap                <A-k>           <C-p>
cnoremap            <A-x>           <C-E><C-U>
cmap                jj              <C-c><Esc>
cmap                <A-Space>       <C-c><Esc>
cmap                jk              <CR>

tmap                jj              <Esc>
tmap                <A-CR>          <C-\><C-n>:call Zoom()<CR>
tmap                <A-z>           <C-\><C-n>:qa<CR>
tmap                <A-Space>       <C-\><C-n>:call Filter_Buffers()<CR>
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
vmap                <Leader>/       <Esc>:'<,'>s/\%V
vmap                <A-,>           <gv
vmap                <A-.>           >gv

" CHORDS
nmap                <Leader>sb      :Buffers<CR>
vmap                <Leader>sh      <Esc>:silent '<,'>w !share<CR>
nmap                <Leader>sh      :silent w !share<CR>
nmap                <Leader>vf      :call Set_Buffer_Filter()<CR>
"nmap                <Leader>vs      :NeoSnippetEdit -split -vertical<CR>
xmap                <Leader>va      <Plug>(EasyAlign)
nmap                <Leader>vu      :PlugUpdate<CR>
nmap                <Leader>vt      :tabe %<CR>
nmap                <Leader>gc      :Git checkout<space>
nmap                <Leader>gs      :Gstatus<CR><C-n>
nmap                <Leader>gp      :Git push<space>
nmap                <Leader>gd      :Gdiff<space>
nmap                <Leader>gb      :Gbrowse<CR>
vmap                <Leader>gb      <Esc>:'<,'>:Gbrowse<CR>
nmap                <Leader>gg      :Gpull<space>
nmap                <Leader>gm      :Gmerge<space>
"}}}

" AUTOCOMMANDS {{{
au TermOpen,WinEnter,BufWinEnter term://* startinsert
au WinLeave,BufWinLeave          term://* stopinsert

" Filetype specific
au FileType javascript nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h; npm start<CR>
au FileType sh         nmap <buffer> <Leader>; :sp<CR>:te! %:p<CR>
au FileType fzf
    \ setlocal nonu nornu |
    \ tmap <buffer> <A-Space> <A-q> |
    \ tmap <buffer> <Esc> <A-q> |
    \ tmap <buffer> <A-CR> <A-CR> |
    \ tmap <buffer> <A-x> <A-x> |
" note: synctex-forward breaks on ConTeXt documents!
au Filetype tex,latex,context
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nocin inde= |
    \ setlocal syntax=tex |
    \ nmap <silent><buffer> <Leader>; :VimtexCompileSS<CR> \| :VimtexView<CR>
au FileType c,cpp
    \ syn match cTodo "\<\w\+_e\>" |
    \ syn match cTodo "\<\w\+_s\>" |
    \ syn match cTodo "\<\w\+_u\>" |
    \ syn match cTodo "\<\w\+_cb\>" |
    \ nmap <buffer> <Leader>; :sp<CR>:te! cd %:p:h:h; make<CR> |
    \ nmap <buffer> <Leader>r :sp<CR>:te! cd %:p:h:h; make run<CR> |
    \ nmap <buffer> <Leader>t :sp<CR>:te! cd %:p:h:h; make test<CR> |
    \ nmap <buffer> <A-S-b>   :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR> |
    \ setlocal foldmethod=syntax |
    \ setlocal foldnestmax=1 |
au FileType help,man
    \ setlocal ro nobuflisted |
    \ nmap <buffer> u <C-T> |
    \ nmap <buffer> <CR> <C-]> |
"}}}
