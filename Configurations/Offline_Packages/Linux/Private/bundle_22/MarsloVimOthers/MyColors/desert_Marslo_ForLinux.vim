" Vim color file
" Maintainer:	Hans Fugal <hans@fugal.net>
" Last Change:	$Date: 2004/06/13 19:30:30 $
" Last Change:	$Date: 2004/06/13 19:30:30 $
" URL:		http://hans.fugal.net/vim/colors/desert.vim
" Version:	$Id: desert.vim,v 1.1 2004/06/13 19:30:30 vimboss Exp $

" v1.0: Modified at 2012.05.29
"       Author: Marslo
"       Email: marslo.vida@gmail.com
"       File Name: desert_Marslo_ForLinux

" v1.1: Modified at 18/10/2012 16:49:12.92
"       Author: Marslo
"       Email: marslo.vida@gmail.com    
"       File Name: desert_Marslo_ForLinux_2

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
let g:colors_name="desert_Marslo_ForLinux"

hi Normal	guifg=#DDDDDD guibg=gray20

" highlight groups
hi Cursor	guibg=khaki guifg=slategrey
" hi CursorLine guibg=lightblue ctermbg=lightgray
"hi CursorIM
"hi Directory
"hi DiffAdd
"hi DiffChange
"hi DiffDelete
"hi DiffText
"hi ErrorMsg
hi VertSplit	guibg=#c2bfa5 guifg=grey50 gui=none
hi Folded	guibg=grey30 guifg=gold
hi FoldColumn	guibg=grey30 guifg=tan
hi IncSearch	guifg=slategrey guibg=khaki
"hi LineNr
hi ModeMsg	guifg=goldenrod
hi MoreMsg	guifg=SeaGreen
hi NonText	guifg=LightBlue guibg=gray30
hi Question	guifg=springgreen
hi Search	guibg=peru guifg=wheat
hi SpecialKey	guifg=yellowgreen

" Status line for each split windows
hi StatusLine	guibg=gray28 guifg=black gui=none
hi StatusLineNC	guibg=gray28 guifg=grey50 gui=none

" hi Title	guifg=indianred
hi Title	guifg=gray28
hi Visual	gui=none guifg=khaki guibg=olivedrab

"hi VisualNOS
hi WarningMsg	guifg=salmon
"hi WildMenu
"hi Menu
"hi Scrollbar
"hi Tooltip


" syntax highlighting groups
" ===========================================================
"""" Comments
hi Comment	guifg=#484848
hi Comment	ctermfg=darkgrey gui=NONE

"""" Strings
" hi Constant	guifg=#7EBE4E
" hi Constant	ctermfg=brown gui=NONE

" green
hi Constant	guifg=#A6E22E
" orange
" hi Constant	guifg=#EE801E
hi Constant	ctermfg=darkred gui=NONE

"""" Key words (while, if, else, for, in)
" orange
hi Statement	guifg=#EE801E
" hi Statement	guifg=#f47920
" green
" hi Statement	guifg=#8fe28f
" yellow
" hi Statement	guifg=#FFC864
hi Statement	ctermfg=brown gui=NONE

"""" #! color
hi PreProc	guifg=OrangeRed3
hi PreProc	ctermfg=darkgreen gui=NONE 

"""" classname, <key>, <Groupname> color
" hi Type		guifg=darkkhaki
hi Type		guifg=#FF801E
hi Type		ctermfg=darkgreen gui=NONE

"""" <CR>, <leader>
" hi Special	guifg=#B0F080
" red
" hi Special	guifg=#c63c26
" yellow
hi Special	guifg=#fdb933
" hi Special	guifg=#faa755

hi Special	ctermfg=darkred gui=NONE

"""" Function name(shell) [python: print]
" hi Identifier	guifg=palegreen = #98FB98
" blue
hi Identifier	guifg=#4169E1
" hi Identifier	guifg=#0662f9
hi Identifier	ctermfg=darkred gui=NONE

" hi Comment	guifg=SkyBlue
" hi Constant	guifg=#ffa0a0
" hi Statement	guifg=khaki
" hi PreProc	guifg=indianred
" hi Type		guifg=darkkhaki
" ===========================================================


"hi Underlined
hi Ignore	guifg=grey40
"hi Error
hi Todo		guifg=orangered guibg=yellow2

" color terminal definitions
hi SpecialKey	ctermfg=darkgreen
hi NonText	cterm=NONE ctermfg=darkblue
hi Directory	ctermfg=red
hi ErrorMsg	cterm=NONE ctermfg=red ctermbg=0
hi IncSearch	cterm=NONE ctermfg=yellow ctermbg=green
hi Search	cterm=NONE ctermfg=grey ctermbg=blue
hi MoreMsg	ctermfg=darkgreen
hi ModeMsg	cterm=NONE ctermfg=brown
hi LineNr	ctermfg=darkyellow
hi Question	ctermfg=green
hi StatusLine	cterm=NONE ctermfg=darkgray ctermbg=black
hi StatusLineNC cterm=NONE
hi VertSplit	cterm=NONE
hi Title	ctermfg=5
hi Visual	cterm=NONE
hi VisualNOS	cterm=NONE
hi WarningMsg	ctermfg=yellow ctermbg=black
hi WildMenu	ctermfg=0 ctermbg=3
hi Folded	ctermfg=darkgrey ctermbg=NONE
hi FoldColumn	ctermfg=darkgrey ctermbg=NONE
hi DiffAdd	ctermbg=4
hi DiffChange	ctermbg=5
hi DiffDelete	cterm=NONE ctermfg=4 ctermbg=6
hi DiffText	cterm=NONE ctermbg=1


hi Underlined	cterm=underline ctermfg=5 gui=NONE
hi Ignore	cterm=NONE ctermfg=7
hi Ignore	ctermfg=darkgrey
hi Error	cterm=NONE ctermfg=7 ctermbg=1


"vim: sw=4
