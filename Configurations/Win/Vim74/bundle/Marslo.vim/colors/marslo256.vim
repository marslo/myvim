" =============================================================================
"       FileName: marslo256.vim
"           Desc:
"             cool help screens
"             :he group-name
"             :he highlight-groups
"             :he cterm-colors
"         Author: Marslo
"          Email: marslo.jiao@gmail.com
"        Created: 2012-05-29
"        Version: 0.1.9
"     LastChange: 2013-12-30 19:51:11
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

let g:colors_name="marslo256"

hi Normal	              guifg=#DDDDDD       guibg=#181818
hi Cursor	              guibg=#A6E22E       guifg=#A6E22E     gui=underline
" Color for :set cursorline (Highlight the line number only)
hi LineNr               guifg=#555555       guibg=background
hi CursorLine           guibg=background
hi CursorLineNr         guifg=#A6E22E       guibg=background    gui=NONE
hi Folded	              guibg=grey15        guifg=grey60
hi FoldColumn	          guibg=#181818       guifg=#484848
" $,>,backspace,... and other sign
hi NonText              guifg=#808080       gui=NONE
hi VertSplit	          guibg=#282828       guifg=grey30        gui=none
hi IncSearch	          guifg=slategrey     guibg=khaki
hi ModeMsg	            guifg=goldenrod
hi MoreMsg	            guifg=SeaGreen
hi Question	            guifg=springgreen
hi Search	              guibg=peru          guifg=wheat
hi SpecialKey	          guifg=yellowgreen
" Status line for each split windows
hi StatusLine	          guibg=gray15        guifg=black         gui=none
hi StatusLineNC	        guibg=gray18        guifg=grey50        gui=none
" hi Title	            guifg=indianred
hi Title	              guifg=gray28
hi Visual	              guifg=khaki         guibg=olivedrab     gui=none
"hi VisualNOS
hi WarningMsg	          guifg=salmon
" The color setting for complete opt
hi Pmenu                guibg=gray14
hi PmenuSel             guifg=GreenYellow   guibg=gray14
hi PmenuSbar            guifg=black         guibg=gray14
"""" Function name(shell) [python: print]
hi Identifier	          guifg=#4169E1       gui=NONE
hi Ignore	              guifg=grey40
hi Todo		              guifg=orangered     guibg=yellow2
" MiniBufExpl Colors
hi MBEVisibleActive     guifg=#5DC2D6       guibg=#333333
hi MBEVisibleNormal     guifg=#A6DB29       guibg=#333333
" Inspired from http://stackoverflow.com/questions/10746750/set-vim-bracket-highlighting-colors
" Color for :set showmatch
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
hi Special	            guifg=#fdb933       gui=NONE
"""" Strings if nohi String
hi Constant	            guifg=#A6E22E       gui=NONE
"""" Key words (while, if, else, for, in)
hi Statement	          guifg=#EE801E       gui=NONE
"""" #! color
hi PreProc	            guifg=OrangeRed3    gui=NONE
" hi Type		            guifg=#afdf66       gui=NONE
" hi Type		            guifg=#4169E1       gui=NONE
" hi Type		            guifg=#EE3E3E       gui=NONE
" hi Type		            guifg=#B2F432       gui=NONE
" hi Type		            guifg=#D0E141       gui=NONE
" hi Type		            guifg=#1E90FF       gui=NONE
" hi Type		            guifg=#a4c148       gui=NONE
" hi Type		            guifg=#6495ED       gui=NONE
hi Type		              guifg=#5F87FF       gui=NONE
hi Underlined	          gui=NONE
" HTML
hi htmlTag              guifg=#484848
hi htmlEndTag           guifg=#484848
hi htmlArg              guifg=#FF5F5F
hi htmlValue            guifg=#D7D7AF
hi htmlTitle            guifg=#D7D700         gui=NONE
hi htmlTagName          guifg=#5F87FF
hi htmlString           guifg=#87d75f

" For syntax-python
hi Boolean              guifg=#EE3E3E
" hi Boolean              guifg=#4155EE
hi Function             guifg=#4169E1
hi Structure            guifg=#EE2C2C
hi Define               guifg=#EE2C2C
hi Conditional          guifg=#AFDF66
" hi Operator             guifg=#836fff
hi Operator             guifg=#FF8C00
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

hi SpecialKey	          ctermfg=darkgreen
" hi NonText	            cterm=NONE          ctermfg=157
hi NonText	            cterm=NONE          ctermfg=239
hi Directory	          ctermfg=63
hi ErrorMsg	            cterm=NONE          ctermfg=red         ctermbg=0
hi IncSearch	          cterm=NONE          ctermfg=yellow      ctermbg=green
hi Search	              cterm=NONE          ctermfg=grey        ctermbg=blue
hi MoreMsg	            ctermfg=darkgreen
hi ModeMsg	            cterm=NONE          ctermfg=brown
hi Question	            ctermfg=green
hi StatusLine	          cterm=NONE          ctermfg=darkgray    ctermbg=black
hi StatusLineNC         cterm=NONE
hi VertSplit	          cterm=NONE
hi Title	              ctermfg=5
hi Visual	              cterm=underline     ctermbg=NONE
hi VisualNOS	          cterm=underline
hi WarningMsg	          ctermfg=yellow      ctermbg=black
hi WildMenu	            ctermfg=0           ctermbg=3
hi Folded	              ctermfg=darkgrey    ctermbg=NONE
hi FoldColumn	          ctermfg=darkgrey    ctermbg=NONE
hi DiffAdd	            cterm=NONE          ctermbg=56          ctermfg=255
hi DiffDelete	          cterm=NONE          ctermbg=239
hi DiffAdded            ctermbg=93
hi DiffRemoved          ctermbg=129
hi DiffChange	          cterm=bold          ctermbg=99          ctermfg=255
hi DiffText	            cterm=NONE          ctermbg=196
hi Pmenu                ctermbg=darkred
hi PmenuSel             ctermfg=lightgreen
hi Identifier	          ctermfg=149
hi Cursor               cterm=underline     term=underline
hi MatchParen           cterm=inverse       term=inverse
hi LineNr               ctermfg=239         ctermbg=none
hi CursorLine           cterm=NONE
hi String               ctermfg=82
hi Entity               ctermfg=166
hi Support              ctermfg=202
hi CursorLineNr         ctermbg=NONE        ctermfg=118         term=bold
hi Comment	            ctermfg=239
hi Constant	            ctermfg=113
"""" Key words (while, if, else, for, in)
hi Statement	          ctermfg=red
"""" #! color
hi PreProc	            ctermfg=red
"""" classname, <key>, <Groupname> color
" hi Type		            ctermfg=221
hi Type		              ctermfg=69
hi Special	            ctermfg=221
hi Underlined	          cterm=underline     ctermfg=5
hi Ignore	              cterm=NONE          ctermfg=7       ctermfg=darkgrey
hi Error	              cterm=NONE          ctermfg=7       ctermbg=1
" HTML
hi htmlTag              ctermfg=244
hi htmlEndTag           ctermfg=244
hi htmlArg              ctermfg=203
hi htmlValue            ctermfg=187
hi htmlTitle            ctermfg=184         ctermbg=NONE
hi htmlTagName          ctermfg=69
" hi htmlString           ctermfg=104
hi htmlString           ctermfg=113
" NERDTree
" hi Directory            ctermfg=110
hi treeCWD              ctermfg=180
hi treeClosable         ctermfg=174
hi treeOpenable         ctermfg=150
hi treePart             ctermfg=244
hi treeDirSlash         ctermfg=244
hi treeLink             ctermfg=182

"vim: sw=4
