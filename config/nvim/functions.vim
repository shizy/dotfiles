" capitalized prefixes will persist between sessions!
function! Set_Tab_Var(prefix)
    let n = tabpagenr()
    call inputsave()
    let value = input(a:prefix . ': ', '', 'file')
    call inputrestore()
    if value == ""
        if exists("g:" . a:prefix . n)
            unlet {"g:" . a:prefix . n}
        endif
    else
        let {"g:" . a:prefix . n} = value
    endif
endfunction

function! Tab_QuickCmd(prefix)
    if exists("g:" . a:prefix . tabpagenr())
        sp
        execute "te! " . {"g:" . a:prefix . tabpagenr()}
    endif
endfunction

" Zoom
function! Zoom()
    if exists('t:zoomed_window')
        call ZoomOut()
    else
        call ZoomIn()
    endif
endfunction

function! ZoomOut()
    exe "norm! 5\<C-w>="
    if exists('t:zoomed_window')
        unlet t:zoomed_window
    endif
endfunction

function! ZoomIn()
    vertical res
    res
    let t:zoomed_window = 1
endfunction

" Tabline
set tabline=%!TabLine()
function TabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let buflist = tabpagebuflist(i + 1)
        let winnr = tabpagewinnr(i + 1)
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= "  "
        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        "let btype = getbufvar(bufnr, 'buftype')
        if file == ""
            let s .= "[new]" . "  "
        else
            let bfilt = ""
            if exists("g:Filter" . (i + 1))
                execute "let bfilt = g:Filter" . (i + 1)
            endif
            if bfilt == ""
                let s .= fnamemodify(file, ":p:t") . "  "
            else
                let s .= "'" . bfilt . "'  "
            endif
        endif
        let s .= '%#TabLineFill# '
    endfor
    let s .= '%#TabLineFill#%T'
    return s
endfunction

" Statusline
function! FugitiveStatus()
    if !empty(FugitiveHead())
        let x = fugitive#head()
        if x==""
            return ""
        endif
        let x = "    " . x
        let y = get(b:, 'coc_git_status', '')
        if (y == '')
            return x . "  "
        else
            return x . y . " "
        endif
    else
        return ""
    endif
endfunction

function! StatusLine()
    let mode=toupper(mode())
    let output = ''
    let three = '%#StatusLineThreeN#'
    if mode == 'N'
        let three = '%#StatusLineThreeN#'
        let output .= three . '     '
    endif
    if mode == 'I' || mode == 'T'
        let three = '%#StatusLineThreeI#'
        let output .= three . '     '
    endif
    if mode == 'V' || mode == "\<C-V>"
        let three = '%#StatusLineThreeV#'
        let output .= three . '     '
    endif
    if mode == 'C'
        let three = '%#StatusLineThreeC#'
        let output .= three . '     '
    endif
    let output .= '%#StatusLineTwo#'
    let output .= '  %{&filetype}  '
    let output .= '%{FileFlags()}'
    let output .= '%#StatusLine#'
    let output .= ' %F'
    let output .= '%='
    let output .= '%#StatusLineTwo#'
    let output .= '%{FugitiveStatus()}'
    let output .= three
    let output .= '  %p   '
    return output
endfunction

function! FileFlags()
    let output = ""
    if &ro == 1
        let output .= "   "
    endif
    if &modified == 1
        let output .= "   "
    endif
    let ws = search('\s\+$', 'nw')
    if ws != 0 && &ro != 1
        let output .= "   " . ws . " "
    endif
    return output
endfunction

function! Scheme(name)
    execute 'colorscheme' a:name
    source $XDG_CONFIG_HOME/nvim/theme-overrides.vim
endfunction
