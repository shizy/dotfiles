let s:primary_email = system("notmuch config get user.primary_email")[:-2]
let s:current_search = []

let s:message_list = []
let s:message_num = 0
let s:message = {}

let s:message_part_content = []
let s:message_part_list = []
let s:message_part_id = []
let s:message_part_num = 0

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
    if (s:message_part_num < (len(s:message_part_list) - 1))
        call s:show_message(s:message_part_list, s:message_part_num + 1)
    endif
endfunction

function! s:prev_part()
    if (s:message_part_num > 0)
        call s:show_message(s:message_part_list, s:message_part_num - 1)
    endif
endfunction

function! s:next_message()
    if (s:message_num < (len(s:message_list) - 1))
        call s:select_message(s:message_num + 1)
    endif
endfunction

function! s:prev_message()
    if (s:message_num > 0)
        call s:select_message(s:message_num - 1)
    endif
endfunction

" -------------------------------

function s:send()
    let buf = getline(0, '$')
    let recipient = matchlist(buf, '^To\(.\{-}<\|:\s*\)\zs.\{-}\ze\(>\|\s\|,\|$\)')
    if (len(recipient) < 1 || recipient[0] == "")
        echo "You must have at least one recipient!"
    else
        execute 'w !msmtp -C $PRIVATE/msmtp/msmtprc -t ' . recipient[0]
    endif
endfunction

function! s:tagFOO(...)
    let message = (s:current_thread == "") ? matchstr(get(s:current_search, line('.') - 1), '^.\{-}\s') : s:current_thread
    let tag = (a:0 == 0) ? input('Tag thread: ') : a:1
    if (tag[0] != '-' && tag[0] != '+')
        let tags = systemlist('notmuch search --output=tags ' . message)
        let tag = (index(tags, tag) > -1) ? '-' . tag : '+' . tag
    endif
    execute system('notmuch tag ' . tag . ' ' . message)
    if (s:current_thread == "")
        call s:refresh()
    endif
endfunction

" ------------------------

function! s:compose(type)
    call s:new_buffer('neovim-notmuch-compose')
    call s:build_header(a:type)
    if a:type == 'compose'
        call cursor(3, 5)
    elseif a:type == 'reply' || a:type == 'replyall'
        call cursor(9, 1)
    endif
    let old_undolevels = &undolevels
    set undolevels=-1
    execute "normal a \<BS>\<Esc>"
    let &undolevels = old_undolevels
    unlet old_undolevels
    startinsert!
    "nnoremap <buffer> <Leader>p :call <SID>send()<CR>
endfunction

function! s:save_part()
    let type = get(s:message_part_list, s:message_part_num)
    let dest = (type == 'text/html' || type == 'text/plain') ? input('Save as: ', '', 'file') : type
    if (dest != "")
        call system('notmuch show --format=raw --part=' . get(s:message_part_id, s:message_part_num) . ' ' . get(s:message_list, s:message_num) . ' > ' . dest)
    endif
endfunction

function! s:refresh()
    let pos = getcurpos()
    call s:search_threads()
    call setpos('.', pos)
endfunction

function s:build_status()
    normal! 0
    let parts = deepcopy(s:message_part_list)
    let parts[s:message_part_num] = "*" . parts[s:message_part_num] . "*"
    let status = "[" . (s:message_num + 1) . "/" . len(s:message_list) . "] [ " . join(parts, '  ') . " ] \n\n"
    silent put =status
endfunction

function s:build_header(type)
    let from = ''
    let to = ''
    let cc = ''
    let subject = ''
    normal! 1
    if a:type == 'show'
        let from = s:message['headers']['From']
        let to = s:message['headers']['To']
        let subject = s:message['headers']['Subject']
    endif
    if a:type == 'show' || a:type == 'replyall'
        let cc = (has_key(s:message['headers'], 'Cc')) ? s:message['headers']['Cc'] : ''
    endif
    if a:type == 'compose' || a:type == 'reply' || a:type == 'replyall'
        let from = s:primary_email
    endif
    if a:type == 'reply' || a:type == 'replyall'
        let to = s:message['headers']['From']
        let subject = (match(s:message['headers']['Subject'], '^Re:') == -1) ? 'Re: ' . s:message['headers']['Subject'] : s:message['headers']['Subject']
    endif
    if a:type == 'replyall'
        let scc = split(cc, ',')
        call add(scc, to)
        call filter(scc, 'v:val !~? "' . s:primary_email . '"')
        let cc = join(scc, ', ')
    endif
    if has_key(s:message, 'headers') && has_key(s:message['headers'], 'Date')
        silent put ='Date: ' . s:message['headers']['Date']
    endif
    silent put ='From: ' . from
    silent put ='To: ' . to
    if a:type != 'show' || cc != ''
        silent put ='Cc: ' . cc
    endif
    if a:type != 'show'
        silent put ='Bcc: '
    endif
    silent put ='Subject: ' . subject
    silent put =''
    silent put =''
endfunction

function s:show_message(num, part)
    let s:message_part_num = a:part
    call s:new_buffer('neovim-notmuch-thread')
    call s:build_status()
    call s:build_header('show')
    if (get(s:message_part_list, s:message_part_num) == 'text/html')
        execute "silent r ! elinks -dump <<< " . shellescape(get(s:message_part_content, s:message_part_num), 1)
    else
        silent put =get(s:message_part_content, s:message_part_num)
    endif
    keepjumps 0d
    normal! $
    set foldmethod=expr foldexpr=getline(v:lnum)[0]==\"\>\"
    setlocal buftype=nofile bufhidden=hide noswapfile nomodifiable readonly
    nnoremap <buffer> <A-Tab> :call <SID>prev_message()<CR>
    nnoremap <buffer> <Tab> :call <SID>next_message()<CR>
    nnoremap <buffer> <A-,> :call <SID>prev_part()<CR>
    nnoremap <buffer> <A-.> :call <SID>next_part()<CR>
    nnoremap <buffer> <A-w> :call <SID>save_part()<CR>
    nnoremap <buffer> r :call <SID>compose('reply')<CR>
    nnoremap <buffer> a :call <SID>compose('replyall')<CR>
    nnoremap <buffer> u :execute ':b! neovim-notmuch-search'<CR>:bw! #<CR>:call <SID>refresh()<CR>
    "nnoremap <buffer> x :execute ':b! neovim-notmuch-search'<CR>:bw! #<CR>:call <SID>tag('+deleted')<CR>
    "nnoremap <buffer> f :call <SID>tag('flagged')<CR>
    nnoremap <buffer> c :call <SID>compose('compose')<CR>
endfunction

function! s:get_parts(part)
    " list
    if type(a:part) == 3
        for i in a:part
            call s:get_parts(i)
        endfor
    endif

    " dictionary
    if type(a:part) == 4
        if has_key(a:part, 'content-type')
            let basetype = matchstr(a:part['content-type'], '^.\{-}\ze\/')
            if basetype == 'multipart'
                call s:get_parts(a:part['content'])
            else
                call add(s:message_part_id, a:part['id'])
                if (has_key(a:part, 'content'))
                    call add(s:message_part_content, a:part['content'])
                    call add(s:message_part_list, a:part['content-type'])
                elseif (has_key(a:part, 'filename'))
                    call add(s:message_part_content, '** Press Alt+w to save this attachment **')
                    call add(s:message_part_list, a:part['filename'])
                endif
            endif
        endif
    endif
endfunction

function! s:select_message(num)
    let s:message_part_content = []
    let s:message_part_list = []
    let s:message_part_id = []
    " enable/disable html option
    let s:message_num = a:num
    let s:message = json_decode(system('notmuch show --format=json --part=0 --include-html=true ' . get(s:message_list, s:message_num)))
    call s:get_parts(s:message['body'])
    call s:show_message(s:message_num, 0)
endfunction

function! s:select_thread()
    let thread = matchstr(get(s:current_search, line('.') - 1), '^.\{-}\s')
    let s:message_list = systemlist('notmuch search --output=messages ' . thread)
    "call s:tag('-unread')
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
    nnoremap <buffer> c :call <SID>compose('compose')<CR>
    nnoremap <buffer> <A-x> :bw!<CR>
    nnoremap <buffer> <A-q> :bw!<CR>
    nnoremap <buffer> r :call <SID>refresh()<CR>
    "nnoremap <buffer> t :call <SID>tag()<CR>
    "nnoremap <buffer> x :call <SID>tag('+deleted')<CR>
    "nnoremap <buffer> f :call <SID>tag('flagged')<CR>
endfunction

function! NotmuchNeovim()
    call s:search_threads()
endfunction
