set viminfo="NONE"
set encoding=utf-8
set clipboard=unnamedplus

let mapleader = "\<Space>"
"let g:notmuch_reader = 'lynx -dump -width=78 -nolist %s'
let g:notmuch_sendmail = 'msmtp -C $PRIVATE/msmtp/msmtprc'
let g:notmuch_folders = [
            \ ['inbox', 'tag:inbox'],
            \ ['starred', 'tag:flagged']
            \ ]

execute "set <A-j>=\ej"
execute "set <A-k>=\ek"
execute "set <A-x>=\ex"
execute "set <A-z>=\ez"
noremap <A-j>       10j
noremap <A-k>       10k
noremap <A-z>       :qa!<CR>
map     q           <nop>
nmap    <Leader>p   ,s
nmap    <A-x>       ,q
nmap    u           q
nmap    -           A
imap    jj          <Esc><Esc>
imap    jk          <Esc><Esc>

