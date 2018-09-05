" File: cocoapods.vim
" Author: Keith Smiley
" Description: General file configuration for CocoaPods within vim
" Last Modified: April 26, 2014

if exists("g:loaded_cocoapods") && g:loaded_cocoapods
  finish
endif
let g:loaded_cocoapods = 1

let s:has_dispatch = 0
if exists(":Dispatch") == 2
  let s:has_dispatch = 1
else
  if exists(":Make") != 2
    command -nargs=* Make make <args> | cwindow
  endif
endif

autocmd FileType podspec,podfile call Setup()
function! Setup()
  if s:has_dispatch
    if !hasmapto(":Dispatch", "n")
      nnoremap <buffer> <leader>d :Dispatch<CR>
    endif
  else
    if !hasmapto(":Make", "n")
      nnoremap <buffer> <leader>d :Make<CR>
    endif
  endif
endfunction
