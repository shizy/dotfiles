" Auto install Plug
if empty(glob('~/.nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" If GUI Version
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    au GUIEnter * simalt ~x
endif


" ========== PACKAGES ==========

call plug#begin('~/.nvim/plugged')

" Buffer Management
Plug 'moll/vim-bbye'

" Looks
Plug 'tomasr/molokai'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'

" Interaction
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'

" Utility
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

" Syntax & Highlighting
Plug 'scrooloose/syntastic'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'plasticboy/vim-markdown'

call plug#end()

" ========== SETTINGS ==========

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set noswapfile
set cursorline
set ttyfast
set lazyredraw
set t_Co=256
set encoding=utf-8
set clipboard=unnamedplus
set backupdir=~/.nvim,.
set directory=~/.nvim,.
set viminfo+=n~/.nvim/nviminfo
set breakindent
set linebreak

syntax on
filetype plugin indent on
let mapleader = "\<Space>"

" Molokai
color molokai
hi Normal ctermbg=none
hi LineNr ctermfg=236 ctermbg=none
hi CursorLine ctermbg=236
hi CursorLineNr ctermfg=208 ctermbg=none
hi Comment cterm=italic
let g:molokai_original = 1
let g:rehash256 = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'simple'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = ''

" Sessions
function! Save()
    :mks! ~/.nvim/sessions/session.vim
    :w
endfunction

" Multi Cursor
let g:multi_cursor_next_key = '<S-s>'
let g:multi_cursor_skip_key = 's'

" Git-Gutter
hi SignColumn ctermbg=none
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" LaTeX
let g:tex_flavor = 'latex'
let g:latexopenpreviews = []
let s:latexpreviewline = 0
function! LatexMake()
    :silent ! latexmk -pdflatex='pdflatex -synctex=1' -pdf -outdir=/home/shizukesa/Docs '%:p'
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') == -1
        :silent ! zathura '%:r.pdf' &
        :call add(g:latexopenpreviews, expand('%:p:r') . '.pdf')
        :silent ! sleep 1
    endif
    :call LatexUpdate()
    :call LatexFocus()
endfunction
function! LatexFocus()
    :silent ! i3-msg '[class="URxvt" instance="vim"] focus'
    :redraw!
endfunction
function! LatexUpdate()
    if line(".") != s:latexpreviewline
        if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
            execute "silent ! zathura --synctex-forward " . line('.') . ":" . col('.') . ":%:p %:p:r.pdf"
        endif
    endif
endfunction
function! LatexPreviewShow()
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
        :silent ! i3-msg '[class="Zathura"] scratchpad show, floating disable'
        :call LatexFocus()
    endif
endfunction
function! LatexPreviewHide()
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
        :silent ! i3-msg '[class="Zathura"] move scratchpad'
        :call LatexFocus()
    endif
endfunction
function! LatexPreviewClose()
    let z = index(g:latexopenpreviews, expand('%:p:r') . '.pdf')
    if z == 1
        :close
    elseif z > -1
        :call remove(g:latexopenpreviews, z)
    endif
    let x = system("ps -C zathura -o pid=,args | grep " . expand('%:t:r') . ".pdf | awk '{print $1}'")
    execute "! kill " . x
endfunction

" ========== MAPPINGS ==========

:noremap   <A-j>      10j
:noremap   <A-k>      10k
:nnoremap  <A-h>      :bp!<CR>
:nnoremap  <A-l>      :bn!<CR>
:nnoremap  <A-x>      :Bdelete!<CR>
:nnoremap  <A-z>      :call Save()<CR>:qa<CR>
:nnoremap  <A-u>      <C-r>
:nnoremap  <tab>      <C-w>w
:nnoremap  <A-tab>    <C-w>W
:nnoremap  <Leader>x  ZZ
:nmap      <Leader>h  <C-w>s
:nmap      <Leader>v  <C-w>v
:nmap      <Leader>w  :call Save()<CR>
:nmap      <Leader>1  :w !sudo tee % > /dev/null
:nmap      <Leader>-  :CtrlP<CR>
:nmap      <Leader>/  <Esc>:%s/
:vmap      <Leader>/  <Esc>:'<,'>s/
:nmap      <Leader>t  :Tabularize /
:vmap      <Leader>t  :Tabularize /
:nmap      <Leader>s  :Gstatus<CR>
:nmap      <Leader>c  :Gcommit -m<space>
:nmap      <Leader>p  :Gpush<space>
:nmap      <Leader>u  :PlugUpdate<CR>
:imap      jj         <Esc>
:imap      jk         <Esc>:call Save()<CR>

:nnoremap <silent> <Leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
:vnoremap          <Leader><Space> zf

" ========== AUTOCOMMANDS ==========

au BufNewFile,BufRead *.styl set filetype=stylus
au BufNewFile,BufRead *.ejs  set filetype=js
au BufNewFile,BufRead *.ejs  set filetype=html
au BufNewFile,BufRead,BufWinEnter *.tex
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nocin inde= |
    \ set syntax=tex |
    \ nnoremap <buffer> <Leader>l :call LatexMake()<CR> |
    \ nnoremap <buffer> <Leader>x :call LatexPreviewClose()<CR>
au CursorMoved *.tex :call LatexUpdate()
au BufWinEnter *.tex :call LatexPreviewShow()
au BufWinLeave *.tex :call LatexPreviewHide()
au BufNewFile,BufRead,BufWinEnter .mutt/temp/*
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nonumber |
    \ set syntax=markdown |
    \ setlocal fo+=aw |
    \ setlocal sessionoptions=""
au BufWinEnter *.md          set syntax=markdown
