" Vim color file
" Maintainer: Hans Fugal <hans@fugal.net>
" Last Change: $Date: 2004/06/13 19:30:30 $
" Last Change: $Date: 2004/06/13 19:30:30 $
" URL:  http://hans.fugal.net/vim/colors/desert.vim
" Version: $Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
 syntax reset
    endif
endif
let g:colors_name="desert2"

hi Normal guifg=#7cb7f1 guibg=grey20

" highlight groups
hi Cursor guibg=khaki guifg=slategrey
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded guibg=grey30
hi FoldColumn guibg=grey30 guifg=tan
hi IncSearch guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg guifg=goldenrod
hi MoreMsg guifg=SeaGreen
hi NonText guifg=LightBlue guibg=grey30
hi Question guifg=springgreen
hi Search guibg=peru guifg=wheat
hi SpecialKey guifg=yellowgreen
hi StatusLine guibg=#f0eb8e guifg=black gui=none
hi StatusLineNC guibg=#f0eb8e guifg=grey50 gui=none
hi Title guifg=#f0eb75
hi Visual gui=none guifg=khaki guibg=olivedrab
"hi VisualNOS
hi WarningMsg guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip

" syntax highlighting groups
hi Comment guifg=#b2b2b2
hi Constant guifg=#f0eb8e
hi Identifier guifg=palegreen
hi Statement guifg=#8fe28f
hi PreProc guifg=white
hi Type  guifg=#7cb7f1
hi Special guifg=#f0eb75
"hi Underlined
hi Ignore guifg=grey40
"hi Error
hi Todo  guifg=#f0eb75 guibg=yellow2

" color terminal definitions
hi SpecialKey ctermfg=darkgreen
hi NonText cterm=NONE ctermfg=darkblue
hi Directory ctermfg=darkcyan
hi ErrorMsg cterm=NONE ctermfg=7 ctermbg=1
hi IncSearch cterm=NONE ctermfg=yellow ctermbg=green
hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg ctermfg=darkgreen
hi ModeMsg cterm=NONE ctermfg=brown
hi LineNr ctermfg=3
hi Question ctermfg=green
hi StatusLine cterm=NONE
hi StatusLineNC cterm=NONE
hi VertSplit cterm=NONE
hi Title ctermfg=5
hi Visual cterm=NONE
hi VisualNOS cterm=NONE
hi WarningMsg ctermfg=1
hi WildMenu ctermfg=0 ctermbg=3
hi Folded ctermfg=darkgrey ctermbg=NONE
hi FoldColumn ctermfg=darkgrey ctermbg=NONE
hi DiffAdd ctermbg=4
hi DiffChange ctermbg=5
hi DiffDelete ctermfg=4 ctermbg=6
hi DiffText ctermbg=1
hi Comment ctermfg=darkcyan gui=NONE
hi Constant ctermfg=brown gui=NONE
hi Special ctermfg=5 gui=NONE
hi Identifier ctermfg=6 gui=NONE
hi Statement ctermfg=3 gui=NONE
hi PreProc ctermfg=5 gui=NONE
hi Type  ctermfg=2 gui=NONE
hi Underlined cterm=NONE ctermfg=5 gui=NONE
hi Ignore ctermfg=7
hi Ignore ctermfg=darkgrey
hi Error ctermfg=7 ctermbg=1

"vim: sw=4