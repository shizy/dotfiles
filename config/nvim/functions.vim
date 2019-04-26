function! Set_Buffer_Filter()
    let n = tabpagenr()
    call inputsave()
    let bfilt = input('buffer filter: ')
    call inputrestore()
    if bfilt == ""
        if exists("g:FILTER_" . n)
            execute "let g:FILTER_" . n . " = ''"
        endif
    else
        execute "let g:FILTER_" . n . " = '" . bfilt . "'"
    endif
    set tabline=%!TabLine()
endfunction

function! Filter_Buffers()
    execute 'MyBuffers'
    let n = tabpagenr()
    let b = ''
    if exists("g:FILTER_" . n)
        execute "let b = g:FILTER_" . n
    "else
        "execute "let g:FILTER_" . tabpagenr() . " = ''"
    endif
    call feedkeys(''.b.' ')
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

" Sessions
function! Save()
    if empty(glob('$XDG_CACHE_HOME/nvim'))
        silent ! mkdir $XDG_CACHE_HOME/nvim > /dev/null
    endif
    :mks! $XDG_CACHE_HOME/nvim/session.vim
    :w
    :filetype detect
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
            if exists("g:FILTER_" . (i + 1))
                execute "let bfilt = g:FILTER_" . (i + 1)
            endif
            if bfilt == ""
                let s .= fnamemodify(file, ":p:t") . "  "
            else
                let s .= "'" . bfilt . "'  "
            endif
        endif
    endfor
    let s .= '%#TabLineFill#%T'
    return s
endfunction

" Statusline
function! FugitiveStatus()
    if exists("*fugitive#head")
        let x = fugitive#head()
        if x==""
            return ""
        endif
        let y = sy#repo#get_stats()
        return "  +" . y[0] . " ~" . y[1] . " -" . y[2] . "    " . x . " "
    else
        return ""
    endif
endfunction

function! ShowMode()
    let mode=toupper(mode())
    if mode == 'N'
        return ' '
    endif
    if mode == 'I'
        return ' '
    endif
    if mode == 'V'
        return ' '
    endif
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
    if ws != 0
        let output .= "   " . ws . " "
    endif
    return output
endfunction

function! ContextTrack()
    if exists("b:alt_context")
        if b:alt_context > line(".")
            return ""
        else
            return ""
        endif
    endif
    return ""
endfunction

" Locationlist

function! LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction

function! LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  catch /^Vim\%((\a\+)\)\=:E42/
  catch /^Vim\%((\a\+)\)\=:E776/
  endtry
endfunction

function! Scheme(name)
    execute 'colorscheme' a:name
    source $XDG_CONFIG_HOME/nvim/theme-overrides.vim
endfunction
