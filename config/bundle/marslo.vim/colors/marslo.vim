" =============================================================================
"       FileName: marslo.vim
"           Desc:
"             cool help screens
"             :he group-name
"             :he highlight-groups
"             :he cterm-colors
"         Author: Marslo
"          Email: marslo.jiao@gmail.com
"        Created: 2012-05-29
"        Version: 0.1.10
"     LastChange: 2014-10-23 17:46:59
" =============================================================================


set background=dark
" set background=dark
if 256 != &t_Co && ! has("gui_running")
  echomsg ""
  echomsg "Error: Please use GUI or an 256-color terminal (:set t_Co=256 && export TERM='xterm-256color')"
  echomsg ""
endif

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
" highlight Title	             guifg=indianred
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

highlight SpecialKey	        ctermfg=darkgreen
" highlight NonText	            cterm=NONE          ctermfg=157
highlight NonText	            cterm=NONE          ctermfg=239
highlight Directory	          ctermfg=63
highlight ErrorMsg	          cterm=NONE          ctermfg=red         ctermbg=0
highlight IncSearch	          cterm=NONE          ctermfg=yellow      ctermbg=green
highlight Search	            cterm=NONE          ctermfg=grey        ctermbg=blue
highlight MoreMsg	            ctermfg=darkgreen
highlight ModeMsg	            cterm=NONE          ctermfg=brown
highlight Question	          ctermfg=green
highlight StatusLine	        cterm=NONE          ctermfg=238         ctermbg=black
highlight StatusLineNC        cterm=NONE          ctermfg=235         ctermbg=black
highlight VertSplit	          cterm=NONE          ctermfg=darkgrey
highlight OverLength          cterm=NONE          ctermfg=244         ctermbg=NONE
highlight ColorColumn         cterm=NONE          ctermfg=244         ctermbg=NONE
highlight CollumnLimit        cterm=NONE          ctermfg=244         ctermbg=NONE
highlight Title	              ctermfg=5
highlight Visual	            cterm=underline     ctermbg=NONE
highlight VisualNOS	          cterm=underline
highlight WarningMsg	        ctermfg=yellow      ctermbg=black
highlight WildMenu	          ctermfg=0           ctermbg=3
highlight Folded	            ctermfg=darkgrey    ctermbg=NONE
highlight FoldColumn	        ctermfg=darkgrey    ctermbg=NONE
highlight DiffAdd	            cterm=NONE          ctermbg=56          ctermfg=255
highlight DiffDelete	        cterm=NONE          ctermbg=239
highlight DiffAdded           ctermbg=93
highlight DiffRemoved         ctermbg=129
highlight DiffChange	        cterm=bold          ctermbg=NONE        ctermfg=255
highlight DiffText	          cterm=underline     ctermbg=NONE        term=bold
" The color setting for complete opt
highlight Pmenu               ctermfg=208         ctermbg=NONE
highlight PmenuSel            ctermfg=154
highlight Identifier	        ctermfg=149
highlight Cursor              cterm=underline     term=underline
highlight MatchParen          cterm=inverse       term=inverse
highlight LineNr              ctermfg=239         ctermbg=NONE
highlight CursorLine          cterm=NONE
highlight String              ctermfg=82
highlight Entity              ctermfg=166
highlight Support             ctermfg=202
highlight CursorLineNr        ctermbg=NONE        ctermfg=118         term=bold
highlight Comment	            ctermfg=239
highlight Constant	          ctermfg=113
"""" Key words (while, if, else, for, in)
highlight Statement	          ctermfg=red
"""" #! color
highlight PreProc	            ctermfg=red
"""" classname, <key>, <Groupname> color
" highlight Type		            ctermfg=221
" highlight Type		              ctermfg=69
highlight Type		            ctermfg=106
highlight Special	            ctermfg=221
highlight Underlined	        cterm=underline     ctermfg=5
highlight Ignore	            cterm=NONE          ctermfg=7       ctermfg=darkgrey
highlight Error	              cterm=NONE          ctermfg=7       ctermbg=1
" HTML
highlight htmlTag             ctermfg=244
highlight htmlEndTag          ctermfg=244
highlight htmlArg             ctermfg=203
highlight htmlValue           ctermfg=187
highlight htmlTitle           ctermfg=184         ctermbg=NONE
highlight htmlTagName         ctermfg=69
" highlight htmlString           ctermfg=104
highlight htmlString          ctermfg=113
" NERDTree
" highlight Directory            ctermfg=110
highlight treeCWD             ctermfg=180
highlight treeClosable        ctermfg=174
highlight treeOpenable        ctermfg=150
highlight treePart            ctermfg=244
highlight treeDirSlash        ctermfg=244
highlight treeLink            ctermfg=182

highlight Boolean             ctermfg=196
highlight Function            ctermfg=105
highlight Structure           ctermfg=202
highlight Define              ctermfg=179
highlight Conditional         ctermfg=190
highlight Operator            ctermfg=208

highlight rubyIdentifier      ctermfg=9
highlight User1               ctermfg=135         ctermbg=black
highlight User2               ctermfg=193         ctermbg=black

" vim: tabstop=2:softtabstop=2:shiftwidth=2:expandtab:sw=2
