" Auto install Plug
if empty(glob('$XDG_DATA_HOME/vim/autoload/plug.vim'))
    echo "Downloading and installing Plug"
    silent !curl -fLo $XDG_DATA_HOME/vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter *
                \ PlugInstall|
                \ cd $XDG_DATA_HOME/vim/plugged/notmuch-abook |
                \ ! sudo python2 setup.py install
endif
set rtp+=$XDG_DATA_HOME/vim
syntax on
filetype plugin indent on
call plug#begin('$XDG_DATA_HOME/vim/plugged')
Plug 'guyzmo/notmuch-abook'
call plug#end()

set viminfo="NONE"
set encoding=utf-8
set clipboard=unnamedplus
set textwidth=78

let mapleader = "\<Space>"
let g:notmuch_date_format = '  %a, %b %e  '
let g:notmuch_sendmail = 'msmtp -C $PRIVATE/msmtp/msmtprc'
let g:notmuch_folders = [
            \ ['inbox', 'tag:inbox'],
            \ ['starred', 'tag:flagged']
            \ ]

execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-x>=\ex"
execute "set <A-z>=\ez"
execute "set <A-h>=\eh"
execute "set <A-l>=\el"
execute "set <A-c>=\ec"
execute "set <A-w>=\ew"
noremap <A-j>       10j
noremap <A-k>       10k
noremap <A-z>       :qa!<CR>
noremap <A-h>       B
noremap <A-l>       E
nmap    <A-c>       c

" auto tag -unread when entering notmuch-show

let g:notmuch_custom_search_maps = {
            \ 'X':                              'search_tag("-inbox -unread +deleted")'
            \ }

let g:notmuch_custom_show_maps = {
            \ 'X':                              'show_tag("-inbox -unread +deleted")'
            \ }

au FileType notmuch-folders
            \ nmap q                            <nop>|

au FileType notmuch-show,notmuch-search
            \ nmap u                            q|

au FileType notmuch-show
            \ nmap <A-w>                        e|
            \ nmap <A-x>                        Xu=|

au FileType notmuch-folders,notmuch-search
            \ nmap -                            A=|
            \ nmap <A-x>                        X=|
            \ nmap /                            s|
            "\ nmap <S-1>                       :call <SNR>14_search_tag("+flagged")

au FileType notmuch-compose
            \ nmap <Leader>p                    ,s|
            \ nmap <A-x>                        ,q|
            \ imap jj                           <Esc><Esc>|
            \ imap jk                           <Esc><Esc>|
            \ inoremap <expr> <Tab>             pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"|
            \ inoremap <expr> <S-Tab>           pumvisible() ? "\<Up>"   : "\<C-x>\<C-u>"|

