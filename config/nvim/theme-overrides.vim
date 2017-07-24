hi Normal                   ctermbg=none
hi LineNr                   ctermfg=236 ctermbg=none
hi CursorLine               ctermbg=234 cterm=none
hi CursorLineNr             ctermfg=201 ctermbg=none cterm=bold
hi Visual                   ctermbg=234
hi SignColumn               ctermbg=none
hi Directory                ctermfg=200 cterm=bold
hi MoreMsg                  ctermfg=200
hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none
hi Error                    ctermfg=200
hi MatchParen               ctermfg=201 ctermbg=200 cterm=bold
hi TermCursor               cterm=reverse
hi VertSplit                cterm=bold ctermfg=232 ctermbg=232
hi ModeMsg                  ctermfg=237
hi NonText                  ctermfg=237
hi WarningMsg               ctermfg=201 ctermbg=none cterm=none
hi SpellBad                 ctermfg=200 ctermbg=none cterm=underline
"hi IncSearch                ctermfg=201 ctermbg=200
"hi Search                   ctermfg=234 ctermbg=201
hi Todo                     ctermbg=none
hi link Visual Search
hi link Visual IncSearch
hi WildMenu                 ctermfg=201 ctermbg=232 cterm=bold
hi TabLineFill              ctermfg=237 ctermbg=232 cterm=none
hi TabLineSel               ctermfg=232 ctermbg=237 cterm=none
hi TabLine                  ctermfg=237 ctermbg=232 cterm=none
hi EndOfBuffer              ctermfg=234 ctermbg=none
hi Folded                   ctermfg=236 ctermbg=none

hi ContextLine              ctermbg=233 cterm=none

hi StatusLineThree          ctermfg=234 ctermbg=201 cterm=bold
hi StatusLineTwo            ctermfg=232 ctermbg=237 cterm=none
hi StatusLine               ctermfg=237 ctermbg=232 cterm=none
hi StatusLineNC             ctermfg=237 ctermbg=232 cterm=none

hi SignifySignAdd           ctermfg=40  ctermbg=none cterm=none
hi SignifySignChange        ctermfg=220 ctermbg=none cterm=bold
hi SignifySignDelete        ctermfg=196 ctermbg=none cterm=bold
hi SignifySignChangeDelete  ctermfg=130 ctermbg=none cterm=bold

au InsertEnter *
            \ hi StatusLineThree ctermfg=234 ctermbg=200 |
            \ hi CursorLineNr    ctermfg=200 ctermbg=none cterm=bold |
au InsertLeave *
            \ hi StatusLineThree ctermfg=234 ctermbg=201 |
            \ hi CursorLineNr    ctermfg=201 ctermbg=none cterm=bold |

au VimEnter,WinEnter,BufWinEnter *
    \ set statusline=%#StatusLineThree# |
    \ set statusline+=\ \ %{toupper(mode())}\ \ |
    \ set statusline+=%#StatusLineTwo# |
    \ set statusline+=%{FugitiveStatus()} |
    \ set statusline+=%{FileFlags()} |
    \ set statusline+=%#StatusLine# |
    \ set statusline+=\ %F |
    \ set statusline+=%= |
    \ set statusline+=%#StatusLineTwo# |
    \ set statusline+=\ %{&filetype}\ |
    \ set statusline+=%#StatusLineThree# |
    \ set statusline+=\ \ %p%%\ |
au WinLeave * setlocal statusline=%f
