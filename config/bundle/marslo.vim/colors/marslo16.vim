" =============================================================================
"       FileName: marslo16.vim
"           Desc:
"             cool help screens
"             :he group-name
"             :he highlight-groups
"             :he cterm-colors
"         Author: Marslo
"          Email: marslo.jiao@gmail.com
"        Created: 2012-05-29
"        Version: 0.1.10
"     LastChange: 2014-10-23 17:47:39
" =============================================================================

set background=dark

if version > 580
  " no guarantees for version 5.8 and below, but this makes it stop
  " complaining
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name="marslo"
let color_name="marslo"

highlight Normal              guifg=#DDDDDD         guibg=#181818
highlight Cursor	            guibg=#A6E22E         guifg=#A6E22E       gui=underline
" Color for :set cursorline (Highlight the line number only)
highlight LineNr              guifg=#555555         guibg=background
highlight CursorLine          guibg=background
highlight CursorLineNr        guifg=#A6E22E         guibg=background    gui=NONE
highlight Folded	            guibg=grey15          guifg=grey60
highlight FoldColumn	        guibg=#181818         guifg=#484848
" $,>,backspace,... and other sign
highlight NonText             guifg=#808080         gui=NONE
highlight VertSplit	          guibg=#282828         guifg=grey30        gui=NONE
highlight OverLength          guibg=NONE            guifg=#383838       gui=NONE
highlight ColorColumn         guibg=NONE            guifg=#383838       gui=NONE
highlight CollumnLimit        guibg=NONE            guifg=#383838
highlight IncSearch	          guibg=khaki           guifg=slategrey
highlight ModeMsg	            guifg=goldenrod
highlight MoreMsg	            guifg=SeaGreen
highlight Question	          guifg=springgreen
highlight Search	            guibg=peru            guifg=wheat
highlight SpecialKey	        guifg=yellowgreen
" Status line for each split windows
highlight StatusLine	        guibg=gray15          guifg=black         gui=NONE
highlight StatusLineNC	      guibg=gray18          guifg=grey50        gui=NONE
highlight User1               guibg=gray15          guifg=#9876AA
highlight User2               guibg=gray15          guifg=#A5C25C
" highlight Title	              guifg=indianred
highlight Title	              guifg=gray28
highlight Visual	            guifg=khaki           guibg=olivedrab     gui=NONE
"hi VisualNOS
highlight WarningMsg	        guifg=salmon
" The color setting for complete opt
highlight Pmenu               guibg=gray14
highlight PmenuSel            guifg=GreenYellow     guibg=gray14
highlight PmenuSbar           guifg=black           guibg=gray14
"""" Function name(shell) [python: print]
highlight Identifier	        guifg=#4169E1         gui=NONE
highlight Ignore	            guifg=grey40
highlight Todo		            guifg=orangered       guibg=yellow2
" MiniBufExpl Colors
highlight MBEVisibleActive    guifg=#5DC2D6         guibg=#333333
highlight MBEVisibleNormal    guifg=#A6DB29         guibg=#333333
" Inspired from http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
" Color for :set showmatch
highlight MatchParen          gui=inverse
" NERDTree
" highlight Directory         guifg=#87afdf
highlight Directory           guifg=#1E90FF
highlight treeCWD             guifg=#dfaf87
highlight treeClosable        guifg=#df8787
highlight treeOpenable        guifg=#afdf87
highlight treePart            guifg=#808080
highlight treeDirSlash        guifg=#808080
highlight treeLink            guifg=#dfafdf
highlight String              guifg=#9acd00         gui=NONE
highlight Entity              guifg=#fa6513         gui=NONE
highlight Support             guifg=#8fa6cd         gui=NONE
highlight Comment	            guifg=#484848         gui=NONE
"""" <CR>, <leader>
highlight Special	            guifg=#fdb933         gui=NONE
"""" Strings if nohi String
highlight Constant	          guifg=#A6E22E         gui=NONE
"""" Key words (while, if, else, for, in)
highlight Statement	          guifg=#EE801E         gui=NONE
"""" #! color
highlight PreProc	            guifg=OrangeRed3      gui=NONE
" highlight Type		              guifg=#afdf66         gui=NONE
" highlight Type		              guifg=#4169E1         gui=NONE
" highlight Type		              guifg=#EE3E3E         gui=NONE
highlight Type		            guifg=#B2F432         gui=NONE
" highlight Type		              guifg=#D0E141         gui=NONE
" highlight Type		              guifg=#1E90FF         gui=NONE
" highlight Type		              guifg=#a4c148         gui=NONE
" highlight Type		              guifg=#6495ED         gui=NONE
" highlight Type		              guifg=#5F87FF         gui=NONE
highlight Underlined	        gui=NONE
" HTML
highlight htmlTag             guifg=#484848
highlight htmlEndTag          guifg=#484848
highlight htmlArg             guifg=#FF5F5F
highlight htmlValue           guifg=#D7D7AF
highlight htmlTitle           guifg=#D7D700         gui=NONE
highlight htmlTagName         guifg=#5F87FF
highlight htmlString          guifg=#87d75f
" For css3 -webkit- -moz-
highlight VendorPrefix        guifg=#FF4500         gui=NONE
" For syntax-python
highlight Boolean             guifg=#EE3E3E
" highlight Boolean             guifg=#4155EE
highlight Function            guifg=#4169E1
highlight Structure           guifg=#EE2C2C
highlight Define              guifg=#EE2C2C
highlight Conditional         guifg=#AFDF66
" highlight Operator            guifg=#836fff
highlight Operator            guifg=#FF8C00
highlight DiffAdd	            gui=NONE            guibg=#836FFF         guifg=NONE
highlight DiffDelete	        gui=NONE            guibg=#2b2b2b         guifg=#836FFF
highlight DiffChange	        gui=bold            guibg=#2b2b2b         guifg=NONE
highlight DiffText	          gui=bold,underline  guibg=#9B30FF
" highlight link Function        Entity
" highlight link Structure       Support
" highlight link Special         Support
" highlight link Test            Support
" highlight link Character       Constant
" highlight link Number          Constant
" highlight link Boolean         Constant
" highlight link Float           Number
" highlight link Conditional     Statement
" highlight link StorageClass    Statement
" highlight link Operator        Statement
" highlight link Statement       Statement

" For vim-ruby
highlight rubyIdentifier      guifg=#FF5F5F

" ===========================================================
" color terminal definitions
"                       *cterm-colors*
"    NR-16   NR-8    COLOR NAME ~
"    0	    0	      Black
"    1	    4	      DarkBlue
"    2	    2	      DarkGreen
"    3	    6	      DarkCyan
"    4	    1	      DarkRed
"    5	    5	      DarkMagenta
"    6	    3	      Brown,          DarkYellow
"    7	    7	      LightGray,      LightGrey,      Gray,       Grey
"    8	    0*	    DarkGray,       DarkGrey
"    9	    4*	    Blue,           LightBlue
"    10	    2*	    Green,          LightGreen (#90EE90)
"    11	    6*	    Cyan,           LightCyan
"    12	    1*	    Red,            LightRed
"    13	    5*	    Magenta,        LightMagenta
"    14	    3*	    Yellow,         LightYellow (#FFFFE0)
"    15	    7*	    White

highlight SpecialKey	        ctermfg=DarkGreen
" highlight NonText	            cterm=NONE          ctermfg=darkblue
highlight NonText	            cterm=NONE          ctermfg=DarkGray
highlight Directory	          ctermfg=Red
highlight ErrorMsg	          cterm=NONE          ctermfg=Red         ctermbg=0
highlight IncSearch	          cterm=NONE          ctermfg=Yellow      ctermbg=Green
highlight Search	            cterm=NONE          ctermfg=Grey        ctermbg=Blue
highlight MoreMsg	            ctermfg=DarkGreen
highlight ModeMsg	            cterm=NONE          ctermfg=Brown
highlight Question	          ctermfg=Green
highlight StatusLine	        cterm=NONE          ctermfg=DarkGray    ctermbg=Black
highlight StatusLineNC        cterm=NONE
highlight VertSplit	          cterm=NONE
highlight OverLength          cterm=NONE          ctermfg=1           ctermbg=NONE
highlight ColorColumn         cterm=NONE          ctermfg=1           ctermbg=NONE
highlight CollumnLimit        cterm=NONE          ctermfg=1           ctermbg=NONE
highlight Title	              cterm=NONE          ctermfg=5
highlight Visual	            cterm=underline     ctermbg=DarkMagenta
" highlight VisualNOS	          cterm=underline
highlight WarningMsg	        ctermfg=Yellow      ctermbg=Black
highlight WildMenu	          ctermfg=0           ctermbg=3
highlight Folded	            ctermfg=DarkGrey    ctermbg=NONE
highlight FoldColumn	        ctermfg=DarkGrey    ctermbg=NONE
" highlight DiffAdd	          ctermbg=4
highlight DiffAdd	            cterm=NONE
" highlight DiffChange	        ctermbg=2
highlight DiffDelete	        cterm=NONE
highlight DiffDelete	        cterm=NONE          ctermfg=4           ctermbg=6
highlight DiffText	          cterm=NONE          ctermbg=1
" The color setting for complete opt
highlight Pmenu               ctermbg=DarkRed
highlight PmenuSel            ctermfg=LightGreen
highlight Identifier	        ctermfg=Yellow
highlight Cursor              cterm=underline     term=underline
highlight MatchParen          cterm=inverse       term=inverse
highlight LineNr	            ctermfg=DarkGrey    ctermbg=NONE
highlight CursorLine          cterm=NONE
highlight CursorLineNr        term=bold           ctermbg=NONE        ctermfg=LightGreen
highlight Comment	            ctermfg=DarkGrey
highlight Constant	          ctermfg=DarkBlue
"""" Key words (while, if, else, for, in)
highlight Statement	          ctermfg=DarkGreen
"""" #! color
highlight PreProc	            ctermfg=Red
highlight Type		            ctermfg=Brown
highlight Special 	          ctermfg=Yellow
highlight Underlined	        cterm=underline     ctermfg=5
highlight Ignore	            cterm=NONE          ctermfg=7       ctermfg=DarkGrey
highlight Error	              cterm=NONE          ctermfg=7       ctermbg=1

highlight User1               ctermfg=Magenta     ctermbg=Black
highlight User2               ctermfg=LightGreen  ctermbg=Black

"vim: sw=4
