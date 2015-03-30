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
Plugin 'terryma/vim-multiple-cursors'

" Utility
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

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
set foldcolumn=4
set expandtab
set number
set noswapfile
set cursorline
set ttyfast
set lazyredraw
set t_Co=256
set encoding=utf-8
set clipboard=unnamed
set backupdir=~/.vim,.
set directory=~/.vim,.
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
call airline#parts#define_function('repo', 'GetRepo')
function! GetRepo()
    let repo = system('cd '.expand('%:p:h').' && dirname $(git branch -r) 2> /dev/null')
    if repo[0:4] == "fatal"
        return ""
    else
        return substitute(repo, "\n", "", "")
endfunction
function! AirlineInit()
    let g:airline_section_b = airline#section#create(['hunks', ' ', 'repo', ' ', 'branch'])
endfunction
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.whitespace = ''

" Session
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_save_periodic = 5
let g:session_default_to_last = 1

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
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
        execute "silent ! zathura --synctex-forward " . line('.') . ":" . col('.') . ":%:p %:p:r.pdf"
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
    "kill not working
    let x = system("ps -C zathura -o pid=,args | grep " . expand('%:p:r') . ".pdf | awk '{print $1}'")
    execute "! kill " . x
endfunction

" ========== MAPPINGS ==========

:noremap   <S-j>      10j
:noremap   <S-k>      10k
:nnoremap  <S-h>      :bp!<CR>
:nnoremap  <S-l>      :bn!<CR>
:nnoremap  <S-x>      :Bdelete!<CR>
:nnoremap  <S-z>      ZZ
:nnoremap  <S-u>      <C-r>
:nnoremap  <tab>      <C-w>w
:nnoremap  <S-tab>    <C-w>W
:nnoremap  <Leader>x  ZZ
:nmap      <Leader>h  <C-w>s
:nmap      <Leader>v  <C-w>v
:nmap      <Leader>w  :SaveSession!<CR>:w<CR>
:nmap      <Leader>1  :w !sudo tee % > /dev/null
:nmap      <Leader>-  :CtrlP<CR>
:nmap      <Leader>/  <Esc>:%s/
:vmap      <Leader>/  <Esc>:'<,'>s/
:nmap      <Leader>t  :Tabularize /
:vmap      <Leader>t  :Tabularize /
:nmap      <Leader>s  :Gstatus<CR>
:nmap      <Leader>c  :Gcommit -m<space>
:nmap      <Leader>p  :Gpush<space>
:nmap      <Leader>u  :PluginUpdate<CR>
:imap      jj         <Esc>
:imap      jk         <Esc>:SaveSession!<CR>:w<CR>

:inoremap  {;         {<CR>};<Esc>O
:inoremap  {<CR>      {<CR>}<Esc>O
:inoremap  (;         ();<Left><Left>
:inoremap  <expr> }   strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
:inoremap  <expr> ]   strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

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
    \ nnoremap <buffer> <Leader>w :w<CR>:call LatexMake()<CR> |
    \ nnoremap <buffer> <Leader>x :call LatexPreviewClose()<CR> |
    \ imap     <buffer> jk        <Esc>:w<CR><CR>:call LatexMake()<CR> |
au CursorMoved *.tex :call LatexUpdate()
au BufWinEnter *.tex :call LatexPreviewShow()
au BufWinLeave *.tex :call LatexPreviewHide()
au BufNewFile,BufRead,BufWinEnter /tmp/*
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nonumber |
    \ set syntax=markdown |
    \ nnoremap <Leader>w   :w<CR> |
    \ imap jk              <Esc>:w<CR> |
    \ setlocal fo+=aw
au BufWinEnter *.md          set syntax=markdown
au VimEnter *                call AirlineInit()
