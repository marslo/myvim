" Vim syntax file
" Language:     Oz <http://www.mozart-oz.org>
" Original Maintainer:   Stephane Leibovitsch <stephane.leibovitsch@idealx.com>
" Current Maintainer:   Robin Lee Powell <rlpowell@digitalkingdom.org>
" Last Change:  Fri 3 Jan 2002
" URL: http://www.digitalkingdom.org/~rlpowell/hobbies/software/vim_oz.html

" There are two sets of highlighting in here:
" One is "oz_characters", another "oz_keywords"
" If you want to disable keywords highlighting, put in your .vimrc:
"       let oz_keywords=1
" If you want to disable special characters highlighting, put in
" your .vimrc:
"       let oz_characters=1

" GENERAL NOTE:
" I hate folds.  A lot.  So all the fold versions are in comment lines
" starting '"fold'.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" oz is case sensitive.
syn case match

" Very simple highlighting for comments, clause heads and
" character codes. It respects oz strings and atoms.

if ! exists("oz_characters")
    syn match    ozComment   +%.*+
"fold    syn region   ozComment  start=+/\*+ end=+\*/+ fold
    syn region   ozComment  start=+/\*+ end=+\*/+
    syn keyword  ozKeyword   functor export import define local at
    syn region   ozString1   start=+[^\&]"+ end=+[^&]*"+ skip=+[\\]"|'+ 
    syn region   ozString2   start=+[^\&]'+ end=+[^&]*'+ skip=+[\\]'|"+ 

    " some sybols
    syn match ozOperator "==\|\\=\|=>\|<=\|!=\|<\|>\|=<:\|=<:\|>=:\|=>:\|\\=:"
    syn match ozNumber "\<[0123456789]*\>"
    " syn match ozSpecialCharacter ""
    " syn match ozSpecialCharacter ";\|,\|\[\|\]\|(\|)\|{\|}\|:\||"
    " syn match ozSpecialCharacterCommand "!\|->\|\."
endif

if ! exists("oz_keywords")
    " all function
    "syn match   ozFunction  /{\(@*\w*\.\)*\w*\d*/hs=s+1,he=e

    " all keywords
    syn keyword ozKeyword  end endif else elseif if then catch lock
    syn keyword ozKeyword  case thread orelse andthen raise
    syn keyword ozKeyword  choice dis in is try feat attr class from prop
endif

syn match ozMeth "meth\s\+\S\+("hs=s,he=e-1 contains=ozParen
syn match ozMeth "proc\s\+{"hs=s,he=e-1 contains=ozFunction
syn match ozMeth "fun\s\+{"hs=s,he=e-1 contains=ozCurly

"Old stuff
"syn region ozMeth start="meth " end="end" fold
"syn region ozProc start="proc " end="end" fold
"syn region ozFun start="fun "   end="end" fold
"syn region ozCurly start="{"    end="}" fold contains=ALL

" Folding
"fold syn region ozLocal start="local" end="end" fold
"fold syn region ozSquare start="\["    end="]" fold
"fold syn region ozParen start="("    end=")" fold contains=ALL

syn region ozLocal start="local" end="end" contains=ALL
syn region ozSquare start="\["    end="]" contains=ALL
syn region ozParen start="("    end=")" contains=ALL

syn region ozRec matchgroup=ozRecIdent start="\<\S\+("    end=")" contains=ALL
syn region ozFunction  matchgroup=ozFuncIdent start=/{\S\+\>/ end=/}/ contains=ALL
"fold syn match  folding +%.*+    transparent

if version >= 600
    syn sync fromstart
    set foldmethod=syntax
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
  if version < 508
    let did_c_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

    " The default highlighting.
    HiLink ozKeyword Keyword
    HiLink ozString1 String
    HiLink ozString2 String
    HiLink ozSpecialCharacter Special
    HiLink ozNumber Number
    HiLink ozOperator Operator
    HiLink ozSpecialCharacterCommand Keyword
    HiLink ozModules Keyword
    HiLink ozMeth Statement
    HiLink ozProc Statement
    HiLink ozFun Statement
    HiLink ozParen Identifier

  delcommand HiLink


if &background == "dark"
  hi ozFunction	term=underline cterm=bold ctermfg=Red ctermbg=NONE gui=NONE guifg=Red guibg=NONE
  hi ozSquare   term=underline cterm=bold ctermfg=White ctermbg=NONE gui=NONE guifg=White guibg=NONE
  hi ozFuncIdent	term=underline cterm=bold ctermfg=Cyan ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
  hi ozComment	term=underline cterm=bold ctermfg=Blue ctermbg=NONE gui=NONE guifg=Blue guibg=NONE
  hi ozRec	term=underline cterm=bold ctermfg=Green ctermbg=NONE gui=NONE guifg=Green guibg=NONE
  hi ozRecIdent	term=underline cterm=bold ctermfg=Magenta ctermbg=NONE gui=NONE guifg=Magenta guibg=NONE
else
  hi ozFunction	term=underline cterm=NONE ctermfg=DarkRed ctermbg=NONE gui=NONE guifg=DarkRed guibg=NONE
  hi ozSquare   term=underline cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE
  hi ozFuncIdent	term=underline cterm=bold ctermfg=Cyan ctermbg=NONE gui=NONE guifg=Cyan guibg=NONE
  hi ozComment	term=underline cterm=NONE ctermfg=DarkBlue ctermbg=NONE gui=NONE guifg=DarkBlue guibg=NONE
  hi ozRec	term=underline cterm=bold ctermfg=DarkGreen ctermbg=NONE gui=NONE guifg=DarkGreen guibg=NONE
  hi ozRecIdent	term=underline cterm=bold ctermfg=Magenta ctermbg=NONE gui=NONE guifg=Magenta guibg=NONE
endif

let b:current_syntax = "oz"
