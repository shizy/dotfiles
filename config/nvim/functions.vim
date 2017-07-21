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
    \ setlocal syntax=context |
    \ nnoremap <buffer> <A-r>     :call LatexTogglePreview()<CR> |

command -complete=customlist,Completion_Filter -nargs=1 B b <args>
command -complete=customlist,Completion_Filter -nargs=1 SB sb <args>
command -complete=customlist,Completion_Filter -nargs=1 VB :vert:sb <args>
command -complete=customlist,Completion_Filter -nargs=1 BD bd! <args>

function Completion_Filter(A,L,P)
    let n = tabpagenr()
    if exists("g:FILTER_" . n)
        execute "let a = getcompletion(g:FILTER_" . tabpagenr() . ", 'buffer')"
        let a = filter(a, 'v:val =~ "' . a:A . '"')
        call add(a, '')
        return a
    endif
endfunction

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
    let n = tabpagenr()
    if exists("g:FILTER_" . n)
        execute "let b = g:FILTER_" . n
        if b != ""
            echo "filter: " . b
            execute "filter " . b . " ls"
            return
        endif
    endif
    echo ""
    ls
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
        return " +" . y[0] . " ~" . y[1] . " -" . y[2] . "  " . x . " "
    endif
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
