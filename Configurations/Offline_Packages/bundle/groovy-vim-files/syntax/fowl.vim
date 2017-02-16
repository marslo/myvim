" Vim syntax file
" Language:  Fowl
" Maintainer:  Michel Martens
" Last Change:  2008 March 18

" Note: This is a keyword for inserting imap from the text imap file. It is
" not Fowl, but I put it here for convenience or ignorance.
syn match imapPlaceholder       /<++>/

" Added by Michel
syn match  ravenVarPlain "[^()\[\] ]*:"
syn match  ravenVarPlain ":[^()\[\] ]*"
syn match  ravenVarPlain "&[^()\[\] ]*"

" :hola
"syn keyword ravenWordDefinition  class define extend group
"syn keyword ravenWordControl  until if else continue leave break bye scope
"syn keyword ravenWordInclude  include require import
"syn keyword ravenWordTypes  stack list hash prefer
"syn keyword ravenWordLabel  as is use into
"syn keyword ravenWordAssign  set get remove erase set push pop shift shove
syn keyword ravenWordGeneral  dup drop over swap

" Raven Identifiers.
"
syn match  ravenVarPlain  "\\\=\([%$]\|\$#\)\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" contains=ravenPackageRef nextgroup=ravenVarMember,ravenVarSimpleMember,ravenMethod
"syn match  ravenVarPlain  "$[\\\"\[\]'&`+*.,;=%~?@$<>(-]"
syn match  ravenVarPlain  "$\(0\|[1-9]\d*\)"
syn match  ravenVarNotInMatches  "$[|)]"
syn match  ravenVarSlash  "$/"

" Special characters in strings and matches
syn match  ravenSpecialString  "\\\(\d\+\|[xX]\x\+\|c\u\|.\)" contained
syn match  ravenSpecialMatch  "{\d\+\(,\d*\)\=}" contained
syn match  ravenSpecialMatch  "\[\(\]\|-\)\=[^\[\]]*\(\[\|\-\)\=\]" contained
syn match  ravenSpecialMatch  "[+*()?.]" contained
syn match  ravenSpecialMatch  "(?[#:=!]" contained
syn match  ravenSpecialMatch  "(?<[=!]" contained
syn match  ravenSpecialMatch  "(?[imsx]\+)" contained

" Variable interpolation
"
" These items are interpolated inside "" strings and similar constructs.
syn cluster ravenInterpDQ  contains=ravenSpecialString,ravenVarPlain,ravenVarNotInMatches,ravenVarSlash

" These items are interpolated inside m// matches and r/// substitutions.
syn cluster ravenInterpSlash  contains=ravenSpecialString,ravenSpecialMatch,ravenVarPlain

" Shell commands
syn region  ravenShellCommand  matchgroup=ravenMatchStartEnd start="`" end="`" contains=@ravenInterpDQ

" Numbers
syn match  ravenNumber  "[-+]\=\(\<\d[[:digit:]_]*L\=\>\|0[xX]\x[[:xdigit:]_]*\>\)"
syn match  ravenFloat  "[-+]\=\<\d[[:digit:]_]*[eE][\-+]\=\d\+"
syn match  ravenFloat  "[-+]\=\<\d[[:digit:]_]*\.[[:digit:]_]*\([eE][\-+]\=\d\+\)\="
syn match  ravenFloat  "[-+]\=\<\.[[:digit:]_]\+\([eE][\-+]\=\d\+\)\="


"" Simple version of searches and matches; caters for m//
syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[m!]/+ end=+/[cgimosx]*+ contains=@ravenInterpSlash
syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[s!]/+ end=+/[cgimosx]*+ contains=@ravenInterpSlash
syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+[f!]/+ end=+/[cgimosx]*+ contains=@ravenInterpSlash

" Substitutions; caters for r///
" ravenMatch is the first part, ravenSubstitution* is the substitution part
syn region ravenMatch  matchgroup=ravenMatchStartEnd start=+\<r/+  end=+/+me=e-1 contains=@ravenInterpSlash nextgroup=ravenSubstitutionSlash
syn region ravenSubstitutionSlash  matchgroup=perlMatchStartEnd start=+/+  end=+/[ecgimosx]*+ contained contains=@ravenInterpDQ

syn region ravenStringSimple  matchgroup=ravenStringStartEnd start="'" end="'" contains=@Spell
syn region ravenString    matchgroup=ravenStringStartEnd start=+"+  end=+"+ contains=@Spell,@ravenInterpDQ

" All other # are comments, except ^#!
syn match  ravenComment    "#.*" contains=@Spell
syn match  ravenComment    "^#!.*"

" Added by Michel Martens
hi link imapPlaceholder Debug

hi link ravenWordControl Statement
hi link ravenWordDefinition Define
hi link ravenWordInclude Include
hi link ravenWordTypes Type
hi link ravenWordLabel Label
"hi link ravenWordAssign Function
"hi link ravenWordMisc Function
hi link ravenWordGeneral Function
hi link ravenComment Comment
hi link ravenNumber Number
hi link ravenFloat Float
hi link ravenVarPlain Function " was Identifier
hi link ravenString String
hi link ravenStringSimple String
hi link ravenStringStartEnd Delimiter
hi link ravenSpecialString Special
hi link ravenShellCommand String
hi link ravenMatch String
hi link ravenMatchStartEnd Delimiter
hi link ravenSpecialMatch Special


syn sync maxlines=100

let b:current_syntax = "raven"

" vim: ts=8
set ts=2
set sw=2
