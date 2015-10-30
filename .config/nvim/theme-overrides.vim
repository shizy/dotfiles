hi Normal                   ctermbg=none
hi LineNr                   ctermfg=236 ctermbg=none
hi CursorLine               ctermbg=234 cterm=none
hi CursorLineNr             ctermfg=200 ctermbg=none cterm=bold
hi Visual                   ctermbg=234
hi SignColumn               ctermbg=none
hi Directory                ctermfg=200 cterm=bold
hi MoreMsg                  ctermfg=200
hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none
hi Error                    ctermfg=200
hi MatchParen               ctermfg=201 ctermbg=200 cterm=bold
hi TermCursor               cterm=reverse
hi VertSplit                cterm=bold ctermfg=232 ctermbg=232
hi ModeMsg                  ctermfg=203
hi NonText                  ctermfg=203
hi WarningMsg               ctermfg=201 ctermbg=none cterm=none
hi SpellBad                 ctermfg=200 ctermbg=201
hi IncSearch                ctermfg=201 ctermbg=200
hi Search                   ctermfg=234 ctermbg=201
hi WildMenu                 ctermfg=201 ctermbg=232 cterm=bold
hi TabLine                  ctermfg=203 ctermbg=232 cterm=none
hi TabLineSel               ctermfg=232 ctermbg=203
hi TabLineFill              cterm=none

hi StatusLineThree          ctermfg=203 ctermbg=201 cterm=bold
hi StatusLineTwo            ctermfg=232 ctermbg=203 cterm=none
hi StatusLine               ctermfg=203 ctermbg=232 cterm=none
hi StatusLineNC             ctermfg=203 ctermbg=232 cterm=none

au InsertEnter * hi StatusLineThree ctermfg=232 ctermbg=200
au InsertLeave * hi StatusLineThree ctermfg=203 ctermbg=201

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
    \ set statusline+=\ %{&ff}\ |
    \ set statusline+=%#StatusLineThree# |
    \ set statusline+=\ \ %p%%\ |
au WinLeave * setlocal statusline=%f

" Just for reference
"let s:light = 201
"let s:med = 203
"let s:dark = 232
"let s:darker = 234
"let s:warn = 200
"let s:info = 202
