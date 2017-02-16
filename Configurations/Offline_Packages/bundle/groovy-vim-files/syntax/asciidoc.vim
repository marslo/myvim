" Vim syntax file
" Language:	AsciiDoc style
" Author:	Alex Efros <powerman@powerman.asdfgroup.com>
" LastChange:	Sat Mar 10 23:14:56 EET 2007
" Based on syntax file by Felix Obenhuber <felix@obenhuber.de> downloaded from
" http://www.obenhuber.de/cgi-bin/gitweb.cgi?p=adocvim.git;a=summary

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'asciidoc_with_script'
endif

if version < 600
  syn include @ListingPerl  <sfile>:p:h/perl.vim
  syn include @ListingSh    <sfile>:p:h/sh.vim
else
  syn include @ListingPerl  syntax/perl.vim
  unlet b:current_syntax
  syn include @ListingSh    syntax/sh.vim
  unlet b:current_syntax
endif


syn region  asciidocL0		    start="^=" end="$" contains=@Spell
syn region  asciidocL1		    start="^==" end="$" contains=@Spell
syn region  asciidocL2		    start="^===" end="$" contains=@Spell
syn region  asciidocL3		    start="^====" end="$" contains=@Spell
syn region  asciidocL4		    start="^=====" end="$" contains=@Spell
syn match   asciidocL0		    /^=====*\s*$/
syn match   asciidocL1		    /^-----*\s*$/
syn match   asciidocL2		    /^\~\~\~\~\~*\s*$/
syn match   asciidocL3		    /^\^\^\^\^\^*\s*$/
syn match   asciidocL4		    /^+++++*\s*$/
syn match   asciidocBlkTitle	    /^\.\S.*/ contains=@Spell

syn match   asciidocList	    /^\s*[\*\-]\s/
syn match   asciidocList	    /^\s*\d*\.\s/
syn match   asciidocList	    /^\s*[a-z.]\.\s/
syn region  asciidocDefinition	    start="^" end="::$" oneline contains=@Spell

syn keyword asciidocToDo	    TODO ToDo FIXME FixMe
syn match   asciidocAdmonition	    /^\(NOTE\|TIP\|IMPORTANT\|WARNING\|CAUTION\):/
syn match   asciidocEmail	    /[a-zA-Z0-9-.]\+@[a-zA-Z0-9-.]\+/
syn match   asciidocSpecialChar	    /{amp}\w\+;/
syn match   asciidocContinue	    /^+$/
syn match   asciidocAttr	    /^\[\(\[\)\@!.*\]\s*$/


syn region  asciidocMono	start=+\(^\|[^a-zA-Z0-9_\\`]\)\@<=`+ end=+`+ oneline
syn region  asciidocMono	start=/\(^\|[^a-zA-Z0-9_\\]\)\@<=+/ end=/\(^\s*\)\@<!+/ oneline
syn region  asciidocItalic	start=+\(^\|[^a-zA-Z0-9_\\']\)\@<='+ end=+'+ oneline contains=@Spell
syn region  asciidocItalic	start=+\(^\|[^a-zA-Z0-9_\\]\)\@<=_+ end=+_+ oneline contains=@Spell
syn region  asciidocBold	start=+\(^\|[^a-zA-Z0-9_\\]\)\@<=\*+ end=+\(^\s*\)\@<!\*+ oneline contains=@Spell
syn region  asciidocBold	start=+\(^\|[^a-zA-Z0-9_\\]\)\@<=_\*+ end=+\(^\s*\)\@<!\*_+ oneline contains=@Spell
syn region  asciidocQuoted	start=+\(^\|[^a-zA-Z0-9_\\`]\)\@<=``+ end=+''+ oneline contains=@Spell

syn match   asciidocAnchor 	/^\[\[[a-zA-Z0-9_-]\+\]\]\s*$/
syn match   asciidocXref 	/<<[a-zA-Z0-9_-]\+\(,[^>]*\)\?>>/
syn match   asciidocLink 	/\(anchor\|xref\|image\|link\|https\?\|ftp\|file\|mailto\|callto\):[^\[ \t]\+\[[^\]]*\]/

syn match   asciidocComment	/^\s*\/\/.*$/ contains=@Spell
syn region  asciidocCommentBlk	start="^/////*$" end="^/////*$" contains=@Spell
syn region  asciidocSidebarBlk	start="^\*\*\*\*\**$" end="^\*\*\*\*\**$" contains=@Spell
syn region  asciidocListingBlk	start="\(^+\?\s*\n\)\@<=-----*$" end="^-----*$"
syn region  asciidocListingBlkPerl  start="\(^\[perl\]\s*\n\)\@<=-----*$" end="^-----*$" contains=@ListingPerl
syn region  asciidocListingBlkSh    start="\(^\[sh\]\s*\n\)\@<=-----*$" end="^-----*$" contains=@ListingSh

syn match   asciidocALL		/.*/ contains=@Spell,
    \ asciidocL0,asciidocL1,asciidocL2,asciidocL3,asciidocL4,asciidocBlkTitle,
    \ asciidocList,asciidocDefinition,
    \ asciidocToDo,asciidocAdmonition,asciidocEmail,asciidocSpecialChar,
    \ asciidocContinue,asciidocAttr,
    \ asciidocMono,asciidocItalic,asciidocBold,asciidocQuoted,
    \ asciidocAnchor,asciidocXref,asciidocLink,
    \ asciidocComment,asciidocCommentBlk,asciidocSidebarBlk,asciidocListingBlk,
    \ asciidocListingBlkPerl,asciidocListingBlkSh


if version <= 508 || !exists("did_asciidoc_syntax_inits")
  if version < 508
    let did_asciidoc_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink asciidocL0		Title
  HiLink asciidocL1		asciidocL0
  HiLink asciidocL2		asciidocL1
  HiLink asciidocL3		asciidocL2
  HiLink asciidocL4		asciidocL3
  HiLink asciidocBlkTitle	Title

  HiLink asciidocList		SpecialKey
  HiLink asciidocDefinition	SpecialKey

  HiLink asciidocToDo		Todo
  HiLink asciidocAdmonition	NonText
  HiLink asciidocEmail		Normal
  HiLink asciidocSpecialChar	PreProc
  HiLink asciidocContinue	PreProc
  HiLink asciidocAttr		NonText

  HiLink asciidocMono		Keyword
  HiLink asciidocBold		String
  HiLink asciidocItalic		Directory
  HiLink asciidocQuoted		Normal

  HiLink asciidocAnchor		PreProc
  HiLink asciidocXref		Underlined
  HiLink asciidocLink		Underlined 

  HiLink asciidocComment	Comment
  HiLink asciidocCommentBlk	Comment
  HiLink asciidocSidebarBlk	Search
  HiLink asciidocListingBlk	Comment
      
  delcommand HiLink
endif

let b:current_syntax = "asciidoc"

" vim: ts=8 sw=2
