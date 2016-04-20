let s:primary_email = systemlist("notmuch config get user.primary_email")
let s:current_search = []
let s:current_thread = ""
let s:current_messages = []
let s:current_message = 0
let s:current_parts = []
let s:current_part = 0
let s:current_header = ""
let s:current_to = []
let s:current_cc = []
let s:current_from = []
let s:current_subj = []

function! s:new_buffer(name)
    if (bufname(a:name) != "")
        execute 'b! ' . a:name
        setlocal modifiable noreadonly
        execute 'normal! ggdG'
    else
        enew
        execute 'file ' . a:name
    endif
endfunction

function! s:next_part()
    if (s:current_part < (len(s:current_parts) - 1))
        call s:show_message(s:current_message, s:current_part + 1)
    endif
endfunction

function! s:prev_part()
    if (s:current_part > 0)
        call s:show_message(s:current_message, s:current_part - 1)
    endif
endfunction

function! s:next_message()
    if (s:current_message < (len(s:current_messages) - 1))
        call s:select_message(s:current_message + 1)
    endif
endfunction

function! s:prev_message()
    if (s:current_message > 0)
        call s:select_message(s:current_message - 1)
    endif
endfunction

function! s:tag(...)
    let message = (s:current_thread == "") ? matchstr(get(s:current_search, line('.') - 1), '^.\{-}\s') : s:current_thread
    if (a:0 == 0)
        let tag = input('Tag thread: ')
        let tags = systemlist('notmuch search --output=tags ' . message)
        let tag = (index(tags, tag) > -1) ? '-' . tag : '+' . tag
    else
        let tag = a:1
    endif
    execute system('notmuch tag ' . tag . ' ' . message)
    if (s:current_thread == "")
        call s:refresh()
    endif
endfunction

function! s:refresh()
    let pos = getcurpos()
    call s:search_threads()
    call setpos('.', pos)
endfunction

function s:send()
    let buf = getline(0, '$')
    let recipient = matchlist(buf, 'To:\zs.\{-}\ze\(,\|$\)')[0]
    "check for empty to
    execute 'silent w !msmtp -C $PRIVATE/msmtp/msmtprc -t ' . recipient
endfunction

function! s:reply()
    let from = (len(s:primary_email) > 0) ? s:primary_email[0] : ""
    let to = (len(s:current_from) > 0) ? s:current_from[0] : ""
    let cc = (len(s:current_cc) > 0) ? s:current_cc[0] : ""
    let subject = (len(s:current_subj) > 0) ? s:current_subj[0] : ""
    let subject = (match(subject, "Re:") > -1) ? subject : "Re: " . subject
    let template = "From: " . from . "\nTo: " . to . "\nCc: " . cc . "\nBcc: \nSubject: " . subject . "\n\n\n\n"
    call s:new_buffer('neovim-notmuch-compose')
    silent put =template
endfunction

function! s:compose()
    let from = (len(s:primary_email) > 0) ? s:primary_email[0] : ""
    let template = "From: " . from . "\nTo:  \nCc: \nBcc: \nSubject: \n\n\n"
    call s:new_buffer('neovim-notmuch-compose')
    silent put =template
    call cursor(3, 6)
    startinsert
    nnoremap <buffer> <Leader>p :call <SID>send()<CR>
endfunction

function! s:show_message(num, part)
    call s:new_buffer('neovim-notmuch-thread')
    let s:current_part = a:part
    let format = (get(s:current_parts, a:part) == "text/plain") ? "--format=text" : "--format=raw"
    let html = (get(s:current_parts, a:part) == "text/html") ? " | elinks --dump" : ""
    let types = deepcopy(s:current_parts)
    let types[a:part] = "*" . types[a:part] . "*"
    let status = "[" . (a:num + 1) . "/" . len(s:current_messages) . "] [ " . join(types, '  ') . " ] \n\n"
    execute 'silent r ! notmuch show ' . format . ' --part=' . (a:part + 1) . ' ' . s:current_thread . ' and ' . get(s:current_messages, a:num) . html
    silent! %s/.part[{|}].*$//g
    keepjumps 0d
    silent put =status
    keepjumps 0d
    normal! $
    set foldmethod=expr foldexpr=getline(v:lnum)[0]==\"\>\"
    setlocal buftype=nofile bufhidden=hide noswapfile nomodifiable readonly
    nnoremap <buffer> <A-Tab> :call <SID>prev_message()<CR>
    nnoremap <buffer> <Tab> :call <SID>next_message()<CR>
    nnoremap <buffer> <A-,> :call <SID>prev_part()<CR>
    nnoremap <buffer> <A-.> :call <SID>next_part()<CR>
    nnoremap <buffer> r :call <SID>reply()<CR>
    nnoremap <buffer> u :execute ':b! neovim-notmuch-search'<CR>:bw! #<CR>:call <SID>refresh()<CR>
    nnoremap <buffer> x :execute ':b! neovim-notmuch-search'<CR>:bw! #<CR>:call <SID>tag('+deleted')<CR>
    nnoremap <buffer> c :call <SID>compose()<CR>
endfunction

function! s:select_message(num)
    let s:current_message = a:num
    let s:current_parts = []
    let message = system("notmuch show --format=text " . s:current_thread . " and " . get(s:current_messages, a:num))
    call substitute(message, 'Content-type: \zs.\{-}\ze\n', '\=add(s:current_parts, submatch(0))', 'g')
    let s:current_to = matchlist(message, 'To:\ \zs.\{-}\ze\n')
    let s:current_cc = matchlist(message, 'Cc:\ \zs.\{-}\ze\n')
    let s:current_from = matchlist(message, 'From:\ \zs.\{-}\ze\n')
    let s:current_subj = matchlist(message, 'Subject:\ \zs.\{-}\ze\n')
    let text = index(s:current_parts, 'text/plain')
    let html = index(s:current_parts, 'text/html')
    if (html > -1)
        call s:show_message(a:num, html)
    elseif (text > -1)
        call s:show_message(a:num, text)
    else
        call s:show_message(a:num, 0)
    endif
endfunction

function! s:select_thread()
    let s:current_thread = matchstr(get(s:current_search, line('.') - 1), '^.\{-}\s')
    let s:current_messages = systemlist('notmuch search --output=messages ' . s:current_thread)
    call s:tag('-unread')
    call s:select_message(0)
endfunction

function! s:search_threads()
    call s:new_buffer('neovim-notmuch-search')
    let s:current_thread = ""
    let s:current_search = systemlist('notmuch search tag:inbox')
    silent put =s:current_search
    silent! %s/\_^\zs.\{-}\s//g
    keepjumps 0d
    setlocal buftype=nofile bufhidden=hide noswapfile nomodifiable readonly
    nnoremap <buffer> <CR> :call <SID>select_thread()<CR>
    nnoremap <buffer> u <nop>
    nnoremap <buffer> c :call <SID>compose()<CR>
    nnoremap <buffer> <A-x> :bw!<CR>
    nnoremap <buffer> <A-q> :bw!<CR>
    nnoremap <buffer> r :call <SID>refresh()<CR>
    nnoremap <buffer> t :call <SID>tag()<CR>
    nnoremap <buffer> x :call <SID>tag('+deleted')<CR>
endfunction

function! NotmuchNeovim()
    call s:search_threads()
endfunction
