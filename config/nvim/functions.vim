" LaTeX
let s:latex_preview_line = 0

function! LatexResetFocus()
    silent ! xdotool search --name vim windowactivate
    redraw!
endfunction

function! LatexTogglePreview()
    if !exists('b:latex_preview')
        call LatexShowPreview()
        "call ZoomIn()
        silent ! sleep 0.5
        call LatexResetFocus()
    else
        call LatexHidePreview()
        "call ZoomOut()
    endif
endfunction

function! LatexShowPreview()
    let b:latex_preview = 1
    call LatexUpdatePreview()
    call system("xdotool search --name " . expand('%:t:r') . " windowmap")
    "call ZoomIn()
endfunction

function! LatexHidePreview()
    if exists('b:latex_preview')
        unlet b:latex_preview
    endif
    call system("xdotool search --onlyvisible --name " . expand('%:t:r') . " windowunmap")
endfunction

function! LatexStopPreview()
    call system("pkill -f " . expand('<afile>:r'))
endfunction

function! LatexUpdatePreview()
    if exists('b:latex_preview')
        if line(".") != s:latex_preview_line
            let s:latex_preview_line = line(".")
            call system("zathura --synctex-forward=" . line('.') . ":" . col('.') . ":" . expand("%:p") . " " . expand("%:p:r") . ".pdf &")
        endif
    endif
endfunction

au BufWinLeave                    *.tex :call LatexHidePreview()
au CursorMoved                    *.tex :call LatexUpdatePreview()
au BufWipeout,BufDelete           *.tex :call LatexStopPreview()
au BufNewFile,BufRead,BufWinEnter *.tex
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nocin inde= |
    \ setlocal syntax=tex |
    \ nnoremap <buffer> <A-r>     :call LatexTogglePreview()<CR> |
    \ call LatexShowPreview()

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
function TabLine()
    " gettabvar({tabnr}, {varname sans t:})
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= ' %{TabLabel(' . (i + 1) . ')} '
    endfor
    let s .= '%#TabLineFill#%T'
    return s
endfunction
function TabLabel(n)
    if gettabvar(a:n, 'label') == ''
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        return bufname(buflist[winnr - 1])
    else
        return gettabvar(a:n, 'label')
endfunction

" Statusline

function! FugitiveStatus()
    let x = fugitive#head()
    if x==""
        return ""
    endif
    return "  " . x . " "
endfunction

function! FileFlags()
    let output = ""
    if &ro == 1
        let output .= "  "
    endif
    if &modified == 1
        let output .= "   "
    endif
    let ws = search('\s\+$', 'nw')
    if ws != 0
        let output .= "   " . ws . " "
    endif
    return output
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
