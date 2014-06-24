" Vim syntax file
" Language:  Mouse
" Maintainer:  Michel Martens
" Last Change:  2009 February 2

syn match imapPlaceholder       /<++>/

syn match  mouseVarPlain "[[:alnum:]]"

syn keyword mouseKeyword D R S

" Numbers
"
" integer number
syn match mouseNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match mouseFloat  "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match mouseFloat  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match mouseFloat  "\<\d\+e[-+]\=\d\+\>"

"" Simple version of searches and matches; caters for m// re/casdcadc/
" syn region mouseMatch  matchgroup=mouseMatchStartEnd start=+[re]*/+ end=+/[cgimosx]*+

" syn region mouseStringSimple  matchgroup=ravenStringStartEnd start="'" end="'"
syn region mouseString    matchgroup=mouseStringStartEnd start=+"+  end=+"+

" All other # are comments, except ^#!
syn match  mouseComment    "#.*" contains=@Spell
syn match  mouseComment    "^#!.*"

hi link imapPlaceholder Debug
hi link mouseKeyword Statement
hi link mouseComment Comment
hi link mouseNumber Number
hi link mouseFloat Number
hi link mouseFloat Float
hi link mouseVarPlain Function
hi link mouseString String
hi link mouseStringStartEnd String
hi link mouseSpecialString Special
hi link mouseShellCommand String
hi link mouseMatch Number
hi link mouseMatchStartEnd Statement
hi link mouseSpecialMatch Special


syn sync maxlines=100

let b:current_syntax = "mouse"

set ts=2
set sw=2
