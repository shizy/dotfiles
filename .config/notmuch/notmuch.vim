set viminfo="NONE"
set encoding=utf-8
set clipboard=unnamedplus
set textwidth=78

let mapleader = "\<Space>"
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
nmap    q           <nop>
nmap    c           <nop>
noremap <A-j>       10j
noremap <A-k>       10k
noremap <A-z>       :qa!<CR>
noremap <A-h>       B
noremap <A-l>       E
nmap    <A-c>       c
nmap    u           :call <SNR>4_kill_this_buffer()<CR>

au FileType notmuch-folders,notmuch-search
            \ nmap -           :call <SNR>4_search_tag("-inbox -unread")<CR>:call <SNR>4_search_refresh()<CR>|
            \ nmap <A-x>       :call <SNR>4_search_tag("-inbox -unread +deleted")<CR>:call <SNR>4_search_refresh()<CR>|

au FileType notmuch-compose
            \ nmap <Leader>p   ,s|
            \ nmap <A-x>       ,q|
            \ imap jj          <Esc><Esc>|
            \ imap jk          <Esc><Esc>|
