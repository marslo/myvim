" This Vim script was modified by a Python script that I use to manage the
" inclusion of miscellaneous functions in the plug-ins that I publish to Vim
" Online and GitHub. Please don't edit this file, instead make your changes on
" the 'dev' branch of the git repository (thanks!). This file was generated on
" May 23, 2013 at 22:18.

" Vim file type plug-in
" Language: Python
" Authors:
"  - Peter Odding <peter@peterodding.com>
"  - Bart Kroon <bart@tarmack.eu>
" Last Change: May 20, 2013
" URL: https://github.com/tarmack/vim-python-ftplugin

if exists('b:did_ftplugin')
  finish
else
  let b:did_ftplugin = 1
endif

" Enable line continuation.
let s:cpo_save = &cpo
set cpo&vim

" Buffer local options. {{{1

" A list of commands that undo buffer local changes made below.
let s:undo_ftplugin = []

" Make sure "#" doesn't jump to the start of the line.
setlocal cinkeys-=0# indentkeys-=0#
call add(s:undo_ftplugin, 'setlocal cinkeys< indentkeys<')

" Follow import statements.
setlocal include=\s*\\(from\\\|import\\)
setlocal includeexpr=python_ftplugin#include_expr(v:fname)
setlocal suffixesadd=.py
call add(s:undo_ftplugin, 'setlocal include< includeexpr< suffixesadd<')

" Enable formatting of comments.
setlocal comments=b:#
setlocal commentstring=#%s
call add(s:undo_ftplugin, 'setlocal comments< commentstring<')

" Ignore bytecode files during completion.
set wildignore+=*.pyc wildignore+=*.pyo
call add(s:undo_ftplugin, 'setlocal wildignore<')

" Alternate fold text generating function.
setlocal foldtext=python_ftplugin#fold_text()
call add(s:undo_ftplugin, 'setlocal foldtext<')

" Completion of modules and variables using Control-X Control-O.
setlocal omnifunc=python_ftplugin#omni_complete
call add(s:undo_ftplugin, 'setlocal omnifunc<')

" File open/save dialog filename filter on Windows.
if has('gui_win32') && !exists('b:browsefilter')
  let b:browsefilter = "Python Files (*.py)\t*.py\nAll Files (*.*)\t*.*\n"
  call add(s:undo_ftplugin, 'unlet! b:browsefilter')
endif

" Syntax based folding is known to slow Vim down significantly. The following
" code implements a workaround that doesn't exactly fix the issue but at least
" makes it less obnoxious. See also:
" http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
augroup PluginFileTypePython
  autocmd! InsertEnter <buffer> if !exists('w:last_fdm') | let w:last_fdm = &fdm | setl fdm=manual | endif
  call add(s:undo_ftplugin, 'autocmd! PluginFileTypePython InsertEnter <buffer>')
  autocmd! InsertLeave,WinLeave <buffer> if exists('w:last_fdm') | let &l:fdm = w:last_fdm | unlet w:last_fdm | endif
  call add(s:undo_ftplugin, 'autocmd! PluginFileTypePython InsertLeave,WinLeave <buffer>')
augroup END

" Mappings to jump between classes and functions. {{{1
nnoremap <silent> <buffer> ]] :call python_ftplugin#jump('/^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [[ :call python_ftplugin#jump('?^\(class\\|def\)')<cr>
nnoremap <silent> <buffer> ]m :call python_ftplugin#jump('/^\s*\(class\\|def\)')<cr>
nnoremap <silent> <buffer> [m :call python_ftplugin#jump('?^\s*\(class\\|def\)')<cr>
call add(s:undo_ftplugin, 'nunmap <buffer> ]]')
call add(s:undo_ftplugin, 'nunmap <buffer> [[')
call add(s:undo_ftplugin, 'nunmap <buffer> ]m')
call add(s:undo_ftplugin, 'nunmap <buffer> [m')

" Enable syntax folding. {{{1
if python_ftplugin#misc#option#get('python_syntax_fold', 1)
  setlocal foldmethod=syntax
  call add(s:undo_ftplugin, 'setlocal foldmethod<')
  " Match docstrings that span more than one line.
  if python_ftplugin#misc#option#get('python_fold_docstrings', 1)
    syn region  pythonFoldedString start=+[Bb]\=[Rr]\=[Uu]\=\z("""\|'''\)+ end=+.*\z1+ fold transparent contained
          \ containedin=pythonString,pythonUniString,pythonUniRawString,pythonRawString
  endif
  " Match function and class definitions. 
  syntax region  pythonFunctionFold
        \ start="^\(\z(\s*\)\)\%(@.*\n\1\)\@<!\%(@.*\n\1\)*\z(\%(def\|class\)\s\+.\{-}$\)"
        \ skip="^\%(\z1\%(@.\{-}\n\z1\)*\z2\|\s*\n\|\s*#\)"
        \ end="^\ze\%(\%(\z1\s\+\)\@!\|\%$\)" fold transparent 
  " Match comments that span more than one line.
  syntax region  pythonCommentFold start="^\z(\s*\)#\%(!\|\s*-\*-\)\@!.*$" 
        \ end="^\%(\z1\#.*$\)\@!" fold contains=ALLBUT,pythonCommentFold
endif

" Automatic syntax checking. {{{1
augroup PluginFileTypePython
  autocmd! BufWritePost <buffer> call python_ftplugin#syntax_check()
  call add(s:undo_ftplugin, 'autocmd! PluginFileTypePython BufWritePost <buffer>')
augroup END

" Support for automatic completion. {{{1
inoremap <buffer> <expr> <Space> python_ftplugin#auto_complete(' ')
inoremap <buffer> <expr> . python_ftplugin#auto_complete('.')

" }}}1

" Let Vim know how to disable the plug-in.
call map(s:undo_ftplugin, "'execute ' . string(v:val)")
let b:undo_ftplugin = join(s:undo_ftplugin, ' | ')
unlet s:undo_ftplugin

" Restore "cpoptions".
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=2 sw=2 et
