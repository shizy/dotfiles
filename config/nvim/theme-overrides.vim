hi Normal                               ctermbg=none                                    guibg=none
hi LineNr                   ctermfg=236 ctermbg=none                    guifg=#525252   guibg=none
hi CursorLine                           ctermbg=234  cterm=none                         guibg=#525252   gui=none
hi CursorLineNr             ctermfg=201 ctermbg=none cterm=bold         guifg=#f1faee   guibg=none      gui=bold
hi Visual                               ctermbg=234                                     guibg=#101010
hi SignColumn                           ctermbg=none                                    guibg=none
hi Directory                ctermfg=200              cterm=bold         guifg=#2ec6c6                   gui=bold
hi MoreMsg                  ctermfg=200                                 guifg=#2ec6c6
hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none         guifg=#2ec6c6   guibg=none      gui=none
hi Error                    ctermfg=200                                 guifg=#2ec6c6
hi MatchParen               ctermfg=201 ctermbg=200  cterm=bold         guifg=#f1faee   guibg=#2ec6c6   gui=bold
hi TermCursor                                        cterm=reverse                                      gui=reverse
hi VertSplit                ctermfg=232 ctermbg=232  cterm=bold         guifg=#101010   guibg=#101010   gui=bold
hi ModeMsg                  ctermfg=239                                 guifg=#101010
hi NonText                  ctermfg=239                                 guifg=#101010
hi WarningMsg               ctermfg=201 ctermbg=none cterm=none         guifg=#f1faee   guibg=none      gui=none
hi SpellBad                 ctermfg=200 ctermbg=none cterm=underline    guifg=#2ec6c6   guibg=none      gui=underline
hi Todo                                 ctermbg=none                                    guibg=none
hi WildMenu                 ctermfg=201 ctermbg=232  cterm=bold         guifg=#f1faee   guibg=#101010   gui=bold
hi TabLineFill              ctermfg=239 ctermbg=232  cterm=none         guifg=#101010   guibg=#000000   gui=none
hi TabLineSel               ctermfg=232 ctermbg=239  cterm=none         guifg=#101010   guibg=#928374   gui=none
hi TabLine                  ctermfg=239 ctermbg=232  cterm=none         guifg=#928374   guibg=#000000   gui=none
hi EndOfBuffer              ctermfg=234 ctermbg=none                    guifg=#101010   guibg=none
hi Folded                   ctermfg=239 ctermbg=none cterm=bold         guifg=#928374   guibg=none      gui=bold

hi Pmenu                    ctermfg=201 ctermbg=232  cterm=none         guifg=#f1faee   guibg=#101010   gui=none
hi PmenuSel                 ctermfg=232 ctermbg=200  cterm=bold         guifg=#101010   guibg=#2ec6c6   gui=bold

hi ContextLine                          ctermbg=233  cterm=none                         guibg=#686868   gui=none

hi StatusLineThree          ctermfg=234 ctermbg=201  cterm=bold         guifg=#101010   guibg=#f1faee   gui=bold
hi StatusLineTwo            ctermfg=232 ctermbg=239  cterm=none         guifg=#101010   guibg=#928374   gui=none
hi StatusLine               ctermfg=239 ctermbg=232  cterm=none         guifg=#928374   guibg=#101010   gui=none
hi StatusLineNC             ctermfg=239 ctermbg=232  cterm=none         guifg=#928374   guibg=#101010   gui=none

hi SignifySignAdd           ctermfg=40  ctermbg=none cterm=none         guifg=#b8bb26   guibg=none      gui=none
hi SignifySignChange        ctermfg=220 ctermbg=none cterm=bold         guifg=#8ec07c   guibg=none      gui=none
hi SignifySignDelete        ctermfg=196 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none
hi SignifySignChangeDelete  ctermfg=200 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none

hi link Visual Search
hi link Visual IncSearch

au InsertEnter *
            \ hi StatusLineThree ctermfg=234 ctermbg=200 guifg=#101010 guibg=#2ec6c6 |
            \ hi CursorLineNr    ctermfg=200 ctermbg=none cterm=bold guifg=#2ec6c6 guibg=none gui=bold |
au InsertLeave *
            \ hi StatusLineThree ctermfg=234 ctermbg=201 guifg=#101010 guibg=#f1faee |
            \ hi CursorLineNr    ctermfg=201 ctermbg=none cterm=bold guifg=#f1faee guibg=none gui=none |

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
    \ set statusline+=\ \ %p\ \ \ %{ContextTrack()} |
au WinLeave * setlocal statusline=%f

