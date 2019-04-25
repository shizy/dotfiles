let d = expand("$COLOR_DARK")
let m = expand("$COLOR_MEDIUM")
let l = expand("$COLOR_LIGHT")
let a = expand("$COLOR_ACCENT")

exec "hi Normal                               ctermbg=none                                    guibg=none"
exec "hi LineNr                   ctermfg=236 ctermbg=none                    guifg=#525252   guibg=none"
exec "hi CursorLine                           ctermbg=234  cterm=none                         guibg=#525252   gui=none"
exec "hi CursorLineNr             ctermfg=201 ctermbg=none cterm=bold         guifg=". l ."   guibg=none      gui=bold"
exec "hi Visual                               ctermbg=234                                     guibg=". d
exec "hi SignColumn                           ctermbg=none                                    guibg=none"
exec "hi Directory                ctermfg=200              cterm=bold         guifg=". a ."                   gui=bold"
exec "hi MoreMsg                  ctermfg=200                                 guifg=". a
exec "hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none         guifg=". a ."   guibg=none      gui=none"
exec "hi Error                    ctermfg=200                                 guifg=". a
exec "hi MatchParen               ctermfg=201 ctermbg=200  cterm=bold         guifg=". l ."   guibg=". a ."   gui=bold"
exec "hi TermCursor                                        cterm=reverse                                      gui=reverse"
exec "hi VertSplit                ctermfg=232 ctermbg=232  cterm=bold         guifg=". d ."   guibg=". d ."   gui=bold"
exec "hi ModeMsg                  ctermfg=239                                 guifg=". d
exec "hi NonText                  ctermfg=239                                 guifg=". d
exec "hi WarningMsg               ctermfg=201 ctermbg=none cterm=none         guifg=". l ."   guibg=none      gui=none"
exec "hi SpellBad                 ctermfg=200 ctermbg=none cterm=underline    guifg=". a ."   guibg=none      gui=underline"
exec "hi Todo                                 ctermbg=none                                    guibg=none"
exec "hi WildMenu                 ctermfg=201 ctermbg=232  cterm=bold         guifg=". l ."   guibg=". d ."   gui=bold"
exec "hi TabLineFill              ctermfg=239 ctermbg=232  cterm=none         guifg=". d ."   guibg=". d ."   gui=none"
exec "hi TabLineSel               ctermfg=232 ctermbg=239  cterm=none         guifg=". d ."   guibg=". m ."   gui=none"
exec "hi TabLine                  ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=none"
exec "hi EndOfBuffer              ctermfg=234 ctermbg=none                    guifg=". d ."   guibg=none"
exec "hi Folded                   ctermfg=239 ctermbg=none cterm=bold         guifg=". m ."   guibg=none      gui=bold"
"
exec "hi Pmenu                    ctermfg=201 ctermbg=232  cterm=none         guifg=". l ."   guibg=". d ."   gui=none"
exec "hi PmenuSel                 ctermfg=232 ctermbg=200  cterm=bold         guifg=". d ."   guibg=". a ."   gui=bold"
"
exec "hi ContextLine                          ctermbg=233  cterm=none                         guibg=#686868   gui=none"
"
exec "hi StatusLineThree          ctermfg=234 ctermbg=201  cterm=bold         guifg=". d ."   guibg=". l ."   gui=bold"
exec "hi StatusLineTwo            ctermfg=232 ctermbg=239  cterm=none         guifg=". d ."   guibg=". m ."   gui=none"
exec "hi StatusLine               ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=none"
exec "hi StatusLineNC             ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=italic"
"
exec "hi SignifySignAdd           ctermfg=40  ctermbg=none cterm=none         guifg=#b8bb26   guibg=none      gui=none"
exec "hi SignifySignChange        ctermfg=220 ctermbg=none cterm=bold         guifg=#8ec07c   guibg=none      gui=none"
exec "hi SignifySignDelete        ctermfg=196 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none"
exec "hi SignifySignChangeDelete  ctermfg=200 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none"

hi link Visual Search
hi link Visual IncSearch

au InsertEnter *
            \ exec "hi StatusLineThree ctermfg=234 ctermbg=200 guifg=" . d . " guibg=" . a |
            \ exec "hi CursorLineNr    ctermfg=200 ctermbg=none cterm=bold guifg=" . a . " guibg=none gui=bold" |
au InsertLeave *
            \ exec "hi StatusLineThree ctermfg=234 ctermbg=201 guifg=" . d . " guibg=" . l |
            \ exec "hi CursorLineNr    ctermfg=201 ctermbg=none cterm=bold guifg=" . l . " guibg=none gui=none" |

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
au WinLeave * setlocal statusline=\ %f

