let g:tex_flavor = 'latex'
let g:latexopenpreviews = []
let s:latexpreviewline = 0

function! LatexMake()
    :silent ! latexmk -silent -pdflatex='pdflatex -synctex=1' -pdf -outdir=$HOME/docs '%:p'
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') == -1
        :silent ! zathura '%:r.pdf' &
        :call add(g:latexopenpreviews, expand('%:p:r') . '.pdf')
        :silent ! sleep 1
    endif
    :call LatexFocus()
endfunction

function! LatexFocus()
    :silent ! i3-msg '[class="Termite" title="vim"] focus'
    :redraw!
endfunction

function! LatexUpdate()
    if line(".") != s:latexpreviewline
        if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
            execute "silent ! zathura --synctex-forward " . line('.') . ":" . col('.') . ":%:p %:p:r.pdf"
        endif
    endif
endfunction

function! LatexPreviewShow()
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
        :silent ! i3-msg '[class="Zathura" title="' . expand('%:p:r') . '.pdf' . '"] scratchpad show, floating disable'
        :call LatexFocus()
    endif
endfunction

function! LatexPreviewHide()
    if index(g:latexopenpreviews, expand('%:p:r') . '.pdf') > -1
        :silent ! i3-msg '[class="Zathura" title="' . expand('%:p:r') . '.pdf' . '"] move scratchpad'
        :call LatexFocus()
    endif
endfunction
function! LatexPreviewClose()
    let z = index(g:latexopenpreviews, expand('%:p:r') . '.pdf')
    if z == 1
        :close
    elseif z > -1
        :call remove(g:latexopenpreviews, z)
    endif
    let x = system("ps -C zathura -o pid=,args | grep " . expand('%:t:r') . ".pdf | awk '{print $1}'")
    execute "silent ! kill " . x
endfunction
