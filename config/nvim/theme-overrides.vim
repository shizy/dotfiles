let d = expand("$COLOR_DARK")
let m = expand("$COLOR_MEDIUM")
let l = expand("$COLOR_LIGHT")
let a = expand("$COLOR_ACCENT")

exec "hi Normal                               ctermbg=none                                    guibg=#1B1B1B"
exec "hi NormalNC                                                                             guibg=#141414"
exec "hi LineNr                   ctermfg=236 ctermbg=none                    guifg=#525252   guibg=none"
exec "hi CursorLine                           ctermbg=234  cterm=none                         guibg=#525252   gui=none"
exec "hi CursorLineNr             ctermfg=201 ctermbg=none cterm=bold         guifg=". l ."   guibg=none      gui=bold"
exec "hi Visual                               ctermbg=234                                     guibg=". d . "  gui=reverse"
exec "hi SignColumn                           ctermbg=none                                    guibg=none"
exec "hi Directory                ctermfg=200              cterm=bold         guifg=". a ."                   gui=bold"
exec "hi MoreMsg                  ctermfg=200                                 guifg=". a
exec "hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none         guifg=". a ."   guibg=none      gui=none"
exec "hi Error                    ctermfg=200                                 guifg=". a
exec "hi MatchParen               ctermfg=201 ctermbg=200  cterm=bold         guifg=". l ."   guibg=". a ."   gui=bold"
exec "hi TermCursor                                        cterm=reverse                                      gui=reverse"
exec "hi VertSplit                ctermfg=232 ctermbg=232  cterm=bold         guifg=". d ."   guibg=". d ."   gui=bold"
exec "hi ModeMsg                  ctermfg=239                                 guifg=". a
exec "hi NonText                  ctermfg=239                                 guifg=". d
exec "hi WarningMsg               ctermfg=201 ctermbg=none cterm=none         guifg=". l ."   guibg=none      gui=none"
exec "hi SpellBad                 ctermfg=200 ctermbg=none cterm=underline    guifg=". a ."   guibg=none      gui=underline"
exec "hi Todo                                 ctermbg=none                    guifg=". l ."   guibg=none      gui=italic"
exec "hi WildMenu                 ctermfg=201 ctermbg=232  cterm=bold         guifg=". l ."   guibg=". d ."   gui=bold"
exec "hi TabLineFill              ctermfg=239 ctermbg=232  cterm=none         guifg=". d ."   guibg=". d ."   gui=none"
exec "hi TabLineSel               ctermfg=232 ctermbg=239  cterm=none         guifg=". m ."   guibg=none      gui=bold"
exec "hi TabLine                  ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=none"
exec "hi EndOfBuffer              ctermfg=234 ctermbg=none                    guifg=". d ."   guibg=none"
exec "hi Folded                   ctermfg=239 ctermbg=none cterm=bold         guifg=". m ."   guibg=none      gui=bold"

exec "hi Pmenu                    ctermfg=201 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=bold"
exec "hi PmenuSel                 ctermfg=232 ctermbg=200  cterm=bold         guifg=". d ."   guibg=". l ."   gui=bold"

exec "hi ContextLine                          ctermbg=233  cterm=none                         guibg=#686868   gui=none"

exec "hi StatusLineThreeN         ctermfg=234 ctermbg=201  cterm=bold         guifg=". d ."   guibg=". l ."   gui=bold"
exec "hi StatusLineThreeV         ctermfg=234 ctermbg=201  cterm=bold         guifg=". l ."   guibg=". d ."   gui=bold"
exec "hi StatusLineThreeC         ctermfg=234 ctermbg=200  cterm=bold         guifg=". a ."   guibg=". d ."   gui=bold"
exec "hi StatusLineThreeI         ctermfg=234 ctermbg=200  cterm=bold         guifg=". d ."   guibg=". a ."   gui=bold"
exec "hi StatusLineTwo            ctermfg=232 ctermbg=239  cterm=none         guifg=". d ."   guibg=". m ."   gui=bold"
exec "hi StatusLine               ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=none"
exec "hi StatusLineNC             ctermfg=239 ctermbg=232  cterm=none         guifg=". m ."   guibg=". d ."   gui=italic"

exec "hi CocGitAddedSign          ctermfg=40  ctermbg=none cterm=none         guifg=#b8bb26   guibg=none      gui=none"
exec "hi CocGitChangedSign        ctermfg=220 ctermbg=none cterm=bold         guifg=#ff9800   guibg=none      gui=none"
exec "hi CocGitChangeRemovedSign  ctermfg=220 ctermbg=none cterm=bold         guifg=#ff9800   guibg=none      gui=none"
exec "hi CocGitTopRemovedSign     ctermfg=196 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none"
exec "hi CocGitRemovedSign        ctermfg=200 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none"

exec "hi CocHintSign              ctermfg=196 ctermbg=none cterm=bold         guifg=". l ."   guibg=none      gui=none"
exec "hi CocInfoSign              ctermfg=40  ctermbg=none cterm=none         guifg=#b8bb26   guibg=none      gui=none"
exec "hi CocWarningSign           ctermfg=220 ctermbg=none cterm=bold         guifg=#ff9800   guibg=none      gui=none"
exec "hi CocErrorSign             ctermfg=196 ctermbg=none cterm=bold         guifg=#fb4934   guibg=none      gui=none"
exec "hi CocFloating                                                          guifg=". l ."   guibg=". d
exec "hi CocHintFloat                                                         guifg=". l ."   guibg=". d
exec "hi CocInfoFloat                                                         guifg=#b8bb26   guibg=". d
exec "hi CocWarningFloat                                                      guifg=#ff9800   guibg=". d
exec "hi CocErrorFloat                                                        guifg=#fb4934   guibg=". d

hi Function gui=bold
hi Statement gui=bold

hi link Visual Search
hi link Visual IncSearch

au InsertEnter * exec "hi CursorLineNr ctermfg=200 guifg=" . a
au InsertLeave * exec "hi CursorLineNr ctermfg=201 guifg=" . l
au VimEnter,WinEnter,BufWinEnter * setlocal statusline=%!StatusLine()
au WinLeave * setlocal statusline=\ %f
