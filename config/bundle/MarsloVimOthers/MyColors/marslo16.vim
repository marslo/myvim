" Vim color file
" Maintainer:	Hans Fugal <hans@fugal.net>
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
" v1.2: Modified at 08/11/2012 16:05:59.95
"       Author: Marslo
"       Email: marslo.vida@gmail.com
"       File Name: desert_Marslo_ForLinux_3
"       Modified: g:colors_name
"                 Normal        guibg
"                 NonText       guibg
"                 StatusLine    guibg
"                 StatusLineNC  guibg
"                 Folded        guibg
"                 FoldColumn    guibg
" v1.3: Modified at 17/12/12 19:36:21
"       Author: Marslo
"       Email: marslo.vida@gmail.com
"       File Name: desert_Marslo_ForLinux_v3
"       Modifed:
"                Pmenu        guibg ctermbg
"                PmenuSel     guifg guibg ctermbg
"                PmenuSbar    guifg guibg
" v1.4: Modified at 31/10/13 15:47:08
"       Author: Marslo
"       Email:  marslo.jiao@gmail.com
"       File Name: marslo.vim
"       Added:
"               MatchParen      guibg ctermbg gui cterm term
"               LineNr          guifg guibg ctermfg ctermbg
"               CursorLineNr    guifg guibg gui ctermbg ctermfg
" v1.5: Modified at 07/11/13 17:52:47
"       Author: Marslo
"       Email: marslo.jiao@gmail.com
"       File Name: marslo.vim
"       Added:
"               MBEVisibleActive    guifg guibg
"               MBEVisibleNormal    guifg guibg
" V1.6: Modified at 12/11/13 14:20:13
"       Author: Marslo
"       Email: marslo.jiao@gmail.com
"       File Name: marslo16.vim
"       Modified:
"               Change name from marslo.vim to marslo16.vim
" v1.7: Modified at 13/11/13 18:20:09
"       Author: Marslo
"       Email: marslo.jiao@gmail.com
"       File Name: marslo16.vim
"       Modified:
"               Update the format
" v1.8: Modified at 18/11/13  20:03:20
"       Author: Marslo
"       Email: marslo.jiao@gmail.com
"       File Name: marslo16.vim
"       Modified:
"               String              guifg
"               Entity              guifg
"               Support             guifg
"               Type                guifg
"               FoldColumn          guifg
"               Directory           guifg

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
" set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="marslo16"

" hi Normal	            guifg=#DDDDDD       guibg=gray20
" hi Normal	            guifg=#DDDDDD       guibg=gray10
hi Normal	            guifg=#DDDDDD       guibg=#181818

" highlight groups
" hi Cursor	            guibg=khaki         guifg=slategrey     gui=underline
hi Cursor	            guibg=#A6E22E       guifg=#A6E22E     gui=underline
" Color for :set cursorline (Highlight the line number only)
" hi LineNr               guifg=#666666 guibg=background
hi LineNr               guifg=#555555       guibg=background
" hi CursorLine           guibg=darkgrey guifg=white
hi CursorLine           guibg=background
" hi CursorLineNr         gui=bold guifg=Yellow
hi CursorLineNr         guifg=#A6E22E       guibg=background    gui=NONE
" hi Folded	            guibg=grey15        guifg=gold
hi Folded	            guibg=grey15        guifg=grey60
hi FoldColumn	        guibg=#181818        guifg=#484848
" $,>,backspace,... and other sign
" hi NonText	        guifg=LightBlue     guibg=gray30
" hi NonText	            guifg=LightBlue     guibg=#181818
hi NonText              guifg=#808080           gui=NONE
" hi VertSplit	        guibg=#c2bfa5       guifg=grey50        gui=none
hi VertSplit	        guibg=#282828       guifg=grey30        gui=none
hi IncSearch	        guifg=slategrey     guibg=khaki
hi ModeMsg	            guifg=goldenrod
hi MoreMsg	            guifg=SeaGreen
hi Question	            guifg=springgreen
hi Search	            guibg=peru          guifg=wheat
hi SpecialKey	        guifg=yellowgreen

" Status line for each split windows
hi StatusLine	        guibg=gray15        guifg=black         gui=none
hi StatusLineNC	        guibg=gray18        guifg=grey50        gui=none

" hi Title	            guifg=indianred
hi Title	            guifg=gray28
hi Visual	            guifg=khaki         guibg=olivedrab     gui=none

"hi VisualNOS
hi WarningMsg	        guifg=salmon

" The color setting for complete opt
hi Pmenu                guibg=gray14
hi PmenuSel             guifg=GreenYellow   guibg=gray14
hi PmenuSbar            guifg=black         guibg=gray14

"""" Function name(shell) [python: print]
" hi Identifier	        guifg=#0662f9
hi Identifier	        guifg=#4169E1       gui=NONE

hi Ignore	            guifg=grey40
hi Todo		            guifg=orangered     guibg=yellow2

" MiniBufExpl Colors
hi MBEVisibleActive     guifg=#5DC2D6       guibg=#333333
hi MBEVisibleNormal     guifg=#A6DB29       guibg=#333333

" Inspired from http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
" Color for :set showmatch
" hi MatchParen           guibg=GreenYellow   gui=underline
hi MatchParen           gui=inverse

" NERDTree
" hi Directory            guifg=#87afdf
hi Directory            guifg=#1E90FF
hi treeCWD              guifg=#dfaf87
hi treeClosable         guifg=#df8787
hi treeOpenable         guifg=#afdf87
hi treePart             guifg=#808080
hi treeDirSlash         guifg=#808080
hi treeLink             guifg=#dfafdf
hi String               guifg=#9acd00       gui=NONE
hi Entity               guifg=#fa6513       gui=NONE
hi Support              guifg=#8fa6cd       gui=NONE
hi Comment	            guifg=#484848       gui=NONE
"""" <CR>, <leader>
" hi Special	            guifg=#B0F080
" hi Special	            guifg=#c63c26
" hi Special	            guifg=#faa755
hi Special	            guifg=#fdb933       gui=NONE
"""" Strings if nohi String
" hi Constant	            guifg=#7EBE4E
" hi Constant	            guifg=#EE801E
hi Constant	            guifg=#A6E22E       gui=NONE
"""" Key words (while, if, else, for, in)
" hi Statement	        guifg=#f47920
" hi Statement	        guifg=#8fe28f
" hi Statement	        guifg=#FFC864
hi Statement	        guifg=#EE801E       gui=NONE
"""" #! color
hi PreProc	            guifg=OrangeRed3    gui=NONE
"""" classname, <key>, <Groupname> color
" hi Type		            guifg=#afdf66       gui=NONE
" hi Type		            guifg=#4169E1       gui=NONE
" hi Type		            guifg=#EE3E3E       gui=NONE
" hi Type		            guifg=#B2F432       gui=NONE
" hi Type		            guifg=#D0E141       gui=NONE
" hi Type		            guifg=#1E90FF       gui=NONE
" hi Type		            guifg=#a4c148       gui=NONE
hi Type		            guifg=#6495ED       gui=NONE
hi Underlined	        gui=NONE

hi htmlArg              guifg=#dfafdf
hi htmlValue            guifg=#dfdfaf

" For syntax-python
" hi link Define          Entity
" hi link Function        Entity
" hi link Structure       Support
" hi link Special         Support
" hi link Test            Support
" hi link Character       Constant
" hi link Number          Constant
" hi link Boolean         Constant
" hi link Float           Number
" hi link Conditional     Statement
" hi link StorageClass    Statement
" hi link Operator        Statement
" hi link Statement       Statement

" hi Identifier	        guifg=palegreen = #98FB98
" hi Comment	        guifg=SkyBlue
" hi Constant	        guifg=#ffa0a0
" hi Statement	        guifg=khaki
" hi PreProc	        guifg=indianred
" hi Type		        guifg=darkkhaki
" hi Error
" hi CursorIM
" hi Directory
" hi DiffAdd
" hi DiffChange
" hi DiffDelete
" hi DiffText
" hi ErrorMsg
" hi WildMenu
" hi Menu
" hi Scrollbar
" hi Tooltip
"hi Underlined

" ===========================================================
" color terminal definitions
"                       *cterm-colors*
"    NR-16   NR-8    COLOR NAME ~
"    0	    0	    Black
"    1	    4	    DarkBlue
"    2	    2	    DarkGreen
"    3	    6	    DarkCyan
"    4	    1	    DarkRed
"    5	    5	    DarkMagenta
"    6	    3	    Brown,          DarkYellow
"    7	    7	    LightGray,      LightGrey,      Gray,       Grey
"    8	    0*	    DarkGray,       DarkGrey
"    9	    4*	    Blue,           LightBlue
"    10	    2*	    Green,          LightGreen (#90EE90)
"    11	    6*	    Cyan,           LightCyan
"    12	    1*	    Red,            LightRed
"    13	    5*	    Magenta,        LightMagenta
"    14	    3*	    Yellow,         LightYellow (#FFFFE0)
"    15	    7*	    White

hi SpecialKey	        ctermfg=darkgreen
hi NonText	            cterm=NONE          ctermfg=darkblue
hi Directory	        ctermfg=red
hi ErrorMsg	            cterm=NONE          ctermfg=red         ctermbg=0
hi IncSearch	        cterm=NONE          ctermfg=yellow      ctermbg=green
hi Search	            cterm=NONE          ctermfg=grey        ctermbg=blue
hi MoreMsg	            ctermfg=darkgreen
hi ModeMsg	            cterm=NONE          ctermfg=brown
hi Question	            ctermfg=green
hi StatusLine	        cterm=NONE          ctermfg=darkgray    ctermbg=black
hi StatusLineNC         cterm=NONE
hi VertSplit	        cterm=NONE
hi Title	            ctermfg=5
hi Visual	            cterm=underline     ctermbg=NONE
hi VisualNOS	        cterm=underline
hi WarningMsg	        ctermfg=yellow      ctermbg=black
hi WildMenu	            ctermfg=0           ctermbg=3
hi Folded	            ctermfg=darkgrey    ctermbg=NONE
hi FoldColumn	        ctermfg=darkgrey    ctermbg=NONE
hi DiffAdd	            ctermbg=4
" hi DiffChange	        ctermbg=5
hi DiffChange	        ctermbg=2
hi DiffDelete	        cterm=NONE          ctermfg=4 ctermbg=6
hi DiffText	            cterm=NONE          ctermbg=1
" The color setting for complete opt
hi Pmenu                ctermbg=darkred
hi PmenuSel             ctermfg=lightgreen
" hi Identifier	        ctermfg=LightGreen
hi Identifier	        ctermfg=Yellow
hi Cursor               cterm=underline     term=underline
" hi MatchParen           ctermbg=Green
hi MatchParen           cterm=inverse       term=inverse
hi LineNr	            ctermfg=darkgrey    ctermbg=none
" hi CursorLine           cterm=NONE          ctermbg=darkgrey    ctermfg=white
hi CursorLine 	        cterm=NONE
" hi CursorLineNr       ctermfg=Yellow
hi CursorLineNr         ctermbg=NONE        ctermfg=lightgreen     term=bold
hi Comment	            ctermfg=darkgrey
"""" Strings
" hi Constant	            ctermfg=brown
" hi Constant	            ctermfg=darkred
hi Constant	            ctermfg=green
"""" Key words (while, if, else, for, in)
hi Statement	        ctermfg=red
"""" #! color
hi PreProc	            ctermfg=red
hi Type		            ctermfg=yellow
hi Special 	            ctermfg=yellow

hi Underlined	        cterm=underline     ctermfg=5
hi Ignore	            cterm=NONE          ctermfg=7       ctermfg=darkgrey
hi Error	            cterm=NONE          ctermfg=7       ctermbg=1


" Set SignColumn highlight
" :help sign
" :help SignColumn

" hi currentLine          term=reverse        cterm=reverse       gui=reverse
" hi breakPoint           term=NONE           cterm=NONE          gui=NONE
" hi empty                term=NONE           cterm=NONE          gui=NONE

" sign define currentLine linehl=currentLine
" sign define breakPoint  linehl=breakPoint
" sign define both        linehl=currentLine
" sign define empty       linehl=empty

"vim: sw=4
