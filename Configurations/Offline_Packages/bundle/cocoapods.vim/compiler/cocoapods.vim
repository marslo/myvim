" File: cocoapods.vim
" Author: Keith Smiley
" Description: Error formats for CocoaPods linting
" Last Modified: April 26, 2014

if exists("current_compiler")
  finish
endif
let current_compiler = "cocoapods"
let s:plug = expand("<sfile>:p:h:h")

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

execute 'CompilerSet makeprg=python\ ' .
      \ s:plug . '/script/build.py\ %'

CompilerSet errorformat=
      \%E%f:%l:Error\ \|\ %m,
      \%W%f:%l:WARN\ \ \|\ %m,
      \%I%f:%l:NOTE\ \ \|\ %m

let &cpo = s:save_cpo
unlet s:save_cpo
