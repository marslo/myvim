" Vim syntax file
" Language:  Shiny
" Maintainer:  Michel Martens
" Last Change:  2008 December 1

syn match imapPlaceholder       /<++>/

syn match  shinyVarPlain "[^()\[\] ]*:"

syn keyword shinyKeyword function object extend copy break continue if else elsif while for each pair print end bye type in out assert

" Numbers
"
" integer number
syn match shinyNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match shinyFloat  "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match shinyFloat  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match shinyFloat  "\<\d\+e[-+]\=\d\+\>"

"" Simple version of searches and matches; caters for m// re/casdcadc/
"syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[m!]/+ end=+/[cgimosx]*+ "contains=@ravenInterpSlash
"syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[s!]/+ end=+/[cgimosx]*+ "contains=@ravenInterpSlash
"syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[f!]/+ end=+/[cgimosx]*+ "contains=@ravenInterpSlash
syn region shinyMatch  matchgroup=shinyMatchStartEnd start=+[re]*/+ end=+/[cgimosx]*+

syn region shinyStringSimple  matchgroup=ravenStringStartEnd start="'" end="'"
syn region shinyString    matchgroup=shinyStringStartEnd start=+"+  end=+"+

" All other # are comments, except ^#!
syn match  shinyComment    "#.*" contains=@Spell
syn match  shinyComment    "^#!.*"

hi link imapPlaceholder Debug
hi link shinyKeyword Statement
hi link shinyComment Comment
hi link shinyNumber Number
hi link shinyFloat Number
hi link shinyFloat Float
hi link shinyVarPlain Function
hi link shinyString String
hi link shinyStringStartEnd String
hi link shinySpecialString Special
hi link shinyShellCommand String
hi link shinyMatch Number
hi link shinyMatchStartEnd Statement
hi link shinySpecialMatch Special


syn sync maxlines=100

let b:current_syntax = "shiny"

set ts=2
set sw=2
