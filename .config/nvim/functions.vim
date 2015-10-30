" LaTeX
let s:latex_preview_line = 0

function! LatexMake()
    silent ! latexmk -silent -pdflatex='pdflatex -synctex=1' -pdf -outdir=$HOME/docs '%:p'
endfunction

function! LatexResetFocus()
    silent ! xdotool search --name vim windowactivate
    redraw!
endfunction

function! LatexTogglePreview()
    if !exists('t:latex_preview')
        call LatexShowPreview()
    else
        call LatexHidePreview()
    endif
endfunction

function! LatexShowPreview()
    call LatexStartPreview()
    call ZoomIn()
    call system("xdotool search --name " . expand('%:t:r') . " windowmap")
    let t:latex_preview = 1
    call LatexResetFocus()
endfunction

function! LatexHidePreview()
    call system("xdotool search --onlyvisible --name " . expand('%:t:r') . " windowunmap")
    if exists('t:latex_preview')
        unlet t:latex_preview
    endif
    call ZoomOut()
    " windows dont equalize!
endfunction

function! LatexFindPreview(file)
    return system("pgrep -f " . a:file)
endfunction

function! LatexStartPreview()
    if !LatexFindPreview(expand('%:t:r'))
        call ZoomIn()
        let t:latex_preview = 1
        silent ! zathura '%:r.pdf' &
        silent ! sleep 1
        call LatexResetFocus()
    endif
endfunction

function! LatexStopPreview()
    if exists('t:latex_preview')
        let x = LatexFindPreview(expand('%:t:r'))
        execute "silent ! kill " . x
        unlet t:latex_preview
    else
        exe "norm! 5\ZZ"
    endif
endfunction

function! LatexUpdatePreview()
    if exists('t:latex_preview')
        if line(".") != s:latex_preview_line
            let s:latex_preview_line = line(".")
            execute "silent ! zathura --synctex-forward " . line('.') . ":" . col('.') . ":%:p %:p:r.pdf"
        endif
    endif
endfunction

au BufWinLeave *.tex :call LatexHidePreview()
au CursorMoved *.tex :call LatexUpdatePreview()
au BufNewFile,BufRead,BufWinEnter *.tex
    \ setlocal spell |
    \ setlocal spelllang=en_us |
    \ setlocal nocin inde= |
    \ set syntax=tex |
    \ nnoremap <buffer> <Leader>l :call LatexMake()<CR> |
    \ nnoremap <buffer> <A-o>     :call LatexTogglePreview()<CR> |
    \ nnoremap <buffer> <A-.>      ]s |
    \ nnoremap <buffer> <A-,>      [s |
    \ nnoremap <buffer> <A-q>     :call LatexStopPreview()<CR>

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
        let output .= "  "
    endif
    if &modified == 1
        let output .= "   "
    endif
    let ws = search('\s\+$', 'nw')
    if ws != 0
        let output .= " " . ws . " "
    endif
    return output
endfunction
