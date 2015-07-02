hi Normal                   ctermbg=none
hi LineNr                   ctermfg=236 ctermbg=none
hi CursorLine               ctermbg=234 cterm=none
hi CursorLineNr             ctermfg=200 ctermbg=none cterm=bold
hi Visual                   ctermbg=234
hi SignColumn               ctermbg=none
"hi GitGutterAdd             ctermfg=201 cterm=bold
"hi GitGutterChange          ctermfg=202 cterm=bold
"hi GitGutterDelete          ctermfg=200 cterm=bold
"hi GitGutterChangeDelete    ctermfg=202 cterm=bold
hi Directory                ctermfg=200 cterm=bold
hi MoreMsg                  ctermfg=200
hi ErrorMsg                 ctermfg=200 ctermbg=none cterm=none
hi Error                    ctermfg=200
hi MatchParen               ctermfg=201 ctermbg=200 cterm=bold
hi TermCursor               cterm=reverse
hi VertSplit                cterm=bold ctermfg=203 ctermbg=203
hi ModeMsg                  ctermfg=203
hi NonText                  ctermfg=203
hi WarningMsg               ctermfg=200 ctermbg=none cterm=none
hi SpellBad                 ctermbg=200
hi IncSearch                ctermfg=201 ctermbg=200
hi Search                   ctermfg=234 ctermbg=201

let g:airline#themes#shizy#palette = {}
let s:dark = 232

let s:N1 = [ '' , '', 203 , 201 ]
let s:N2 = [ '' , '', s:dark , 203 ]
let s:N3 = [ '' , '', 203 , s:dark ]
let g:airline#themes#shizy#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#shizy#palette.normal_modified = {
      \ 'airline_c': [ '' , '', 200, s:dark    , '' ] ,
      \ }

let s:I1 = [ '', '' , s:dark , 202 ]
let s:I2 = [ '' , '', s:dark , 203 ]
let s:I3 = [ '' , '', 203 , s:dark ]
let g:airline#themes#shizy#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#shizy#palette.insert_modified = copy(g:airline#themes#shizy#palette.normal_modified)
"let g:airline#themes#shizy#palette.insert_paste = {
"      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
"      \ }

"let g:airline#themes#shizy#palette.replace = {
"      \ 'airline_a': [ s:I1[0]   , '#af0000' , s:I1[2] , 124     , ''     ] ,
"      \ }
"let g:airline#themes#shizy#palette.replace_modified = copy(g:airline#themes#shizy#palette.normal_modified)


let s:V1 = [ '' , '' , s:dark , 200 ]
let s:V2 = [ '' , '' , s:dark , 203 ]
let s:V3 = [ '' , '' , 203 , s:dark ]
let g:airline#themes#shizy#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#shizy#palette.visual_modified = copy(g:airline#themes#shizy#palette.normal_modified)


let s:IA  = [ '' , '' , 234 , s:dark  , '' ]
let s:IA2 = [ '' , '' , 234 , s:dark , '' ]
let g:airline#themes#shizy#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA2, s:IA2)
let g:airline#themes#shizy#palette.inactive_modified = {
      \ 'airline_c': [ '', '', 200, s:dark, '' ] ,
      \ }

