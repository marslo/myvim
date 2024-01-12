" This Vim script was modified by a Python script that I use to manage the
" inclusion of miscellaneous functions in the plug-ins that I publish to Vim
" Online and GitHub. Please don't edit this file, instead make your changes on
" the 'dev' branch of the git repository (thanks!). This file was generated on
" May 23, 2013 at 22:18.

" Tab completion for user defined commands.
"
" Author: Peter Odding <peter@peterodding.com>
" Last Change: May 19, 2013
" URL: http://peterodding.com/code/vim/misc/

function! python_ftplugin#misc#complete#keywords(arglead, cmdline, cursorpos)
  " This function can be used to perform keyword completion for user defined
  " Vim commands based on the contents of the current buffer. Here's an
  " example of how you would use it:
  "
  "     :command -nargs=* -complete=customlist,python_ftplugin#misc#complete#keywords MyCmd call s:MyCmd(<f-args>)
  let words = {}
  for line in getline(1, '$')
    for word in split(line, '\W\+')
      let words[word] = 1
    endfor
  endfor
  return sort(keys(filter(words, 'v:key =~# a:arglead')))
endfunction

" vim: ts=2 sw=2 et
