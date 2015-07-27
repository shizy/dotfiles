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
hi SpellBad                 ctermfg=200 ctermbg=201
hi IncSearch                ctermfg=201 ctermbg=200
hi Search                   ctermfg=234 ctermbg=201
hi StatusLine               ctermfg=201 ctermbg=203
hi WildMenu                 ctermfg=200 ctermbg=201 cterm=bold
hi TabLine                  ctermfg=203 ctermbg=none cterm=none
hi TabLineSel               ctermfg=203 ctermbg=201
hi TabLineFill              cterm=none

let s:light = 201
let s:med = 203
let s:dark = 232
let s:darker = 234
let s:warn = 200
let s:info = 202

" For Lightline
"let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
"let s:p.normal.left = [ [ s:med, s:light ], [ s:dark, s:med ], [ s:med, s:dark ] ]
"let s:p.normal.right = [ [ s:med, s:dark ], [ s:dark, s:med ], [ s:med, s:light ] ]
"let s:p.inactive.right = [ [ s:darker, s:dark ], [ s:darker, s:dark ] ]
"let s:p.inactive.left = [ [ s:darker, s:dark ], [ s:darker, s:dark ] ]
"let s:p.insert.left = [ [ s:dark, s:info ], [ s:dark, s:med ], [ s:med, s:dark ] ]
"let s:p.insert.right = [ [ s:med, s:dark ], [ s:dark, s:med ], [ s:dark, s:info ] ]
"let s:p.insert.middle = [ [ s:base03, s:base02 ] ]
"let s:p.replace.left = [ [ s:base3, s:red ], [ s:base3, s:base01 ] ]
"let s:p.visual.left = [ [ s:base3, s:orange ], [ s:base1, s:base02 ] ]
"let s:p.normal.middle = [ [ s:base1, s:base03 ] ]
"let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
"let s:p.tabline.left = [ [ s:base03, s:base02 ] ]
"let s:p.tabline.tabsel = [ [ s:base00, s:base03 ] ]
"let s:p.tabline.middle = [ [ s:base03, s:base02 ] ]
"let s:p.tabline.right =[ [ s:base01, s:base02 ] ]
"let s:p.normal.error = [ [ s:base2, s:red ] ]
"let s:p.normal.warning = [ [ s:base02, s:yellow ] ]
"let g:lightline#colorscheme#shizy#palette = lightline#colorscheme#flatten(s:p)

" For Airline
let g:airline#themes#shizy#palette = {}
let s:N1 = [ '' , '', s:med , s:light ]
let s:N2 = [ '' , '', s:dark , s:med ]
let s:N3 = [ '' , '', s:med , s:dark ]
let g:airline#themes#shizy#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#shizy#palette.normal_modified = {
      \ 'airline_c': [ '' , '', s:warn, s:dark    , '' ] ,
      \ }

let s:I1 = [ '', '' , s:dark , s:info ]
let s:I2 = [ '' , '', s:dark , s:med ]
let s:I3 = [ '' , '', s:med , s:dark ]
let g:airline#themes#shizy#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#shizy#palette.insert_modified = copy(g:airline#themes#shizy#palette.normal_modified)
"let g:airline#themes#shizy#palette.insert_paste = {
"      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
"      \ }

"let g:airline#themes#shizy#palette.replace = {
"      \ 'airline_a': [ s:I1[0]   , '#af0000' , s:I1[2] , 124     , ''     ] ,
"      \ }
"let g:airline#themes#shizy#palette.replace_modified = copy(g:airline#themes#shizy#palette.normal_modified)


let s:V1 = [ '' , '' , s:dark , s:warn ]
let s:V2 = [ '' , '' , s:dark , s:med ]
let s:V3 = [ '' , '' , s:med , s:dark ]
let g:airline#themes#shizy#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#shizy#palette.visual_modified = copy(g:airline#themes#shizy#palette.normal_modified)


let s:IA  = [ '' , '' , s:darker , s:dark  , '' ]
let s:IA2 = [ '' , '' , s:darker , s:dark , '' ]
let g:airline#themes#shizy#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA2, s:IA2)
let g:airline#themes#shizy#palette.inactive_modified = {
      \ 'airline_c': [ '', '', s:warn, s:dark, '' ] ,
      \ }

let g:airline#themes#shizy#palette.normal.airline_warning = [ '', '', s:warn, s:light ]
let g:airline#themes#shizy#palette.normal_modified.airline_warning = g:airline#themes#shizy#palette.normal.airline_warning
let g:airline#themes#shizy#palette.insert.airline_warning = g:airline#themes#shizy#palette.normal.airline_warning
let g:airline#themes#shizy#palette.insert_modified.airline_warning = g:airline#themes#shizy#palette.normal.airline_warning
let g:airline#themes#shizy#palette.visual.airline_warning = g:airline#themes#shizy#palette.normal.airline_warning
let g:airline#themes#shizy#palette.visual_modified.airline_warning = g:airline#themes#shizy#palette.normal.airline_warning
