" =============================================================================
"       FileName: marslofunc.vim
"         Author: Marslo
"          Email: marslo.jiao@gmail.com
"        Created: 2014-01-19 18:41:02
"        Version: 0.0.1
"     LastChange: 2014-01-19 18:41:02
"        History:
"                 0.0.1 | Marslo | Inspired from http://stackoverflow.com/a/21197543/2940319
" =============================================================================

" function! marslofunc#callit()
  " let tcc='~/.vimrc'
  " if 0 == marslofunc#ValidFile(tcc)
    " echo tcc . ' cannot be found'
  " else
    " echo tcc . ' can be found'
  " endif
" endfunction

function! marslofunc#ValidFile()
  " echo a:thepath
  " if filereadable(a:thepath)
  if filereadable('~/.vimrc')
    echo '1'
    " return 1
  else
    echo '0'
    " return 0
  endif
endfunction

function! marslofunc#OpenCMD()
  if has('win32') || has('win95') || has('win64')
    let tcc='C:\Program Files\JPSoft\TCCLE13x64\tcc.exe'
    let console2='!cmd /c start C:\Marslo\Tools\Softwares\Windows\Console\Console2\Console.exe'

    if 'java' == &filetype
      let com = '!cmd /c start "C:\Program Files\JPSoft\TCCLE13x64\tcc.exe" /d "' . expand('%:p:h') .'"'
    else
      let com = '!cmd /c start C:\Marslo\Tools\Softwares\Windows\Console\Console2\Console.exe -d "' . expand('%:p:h') . '"'
    endif
  else
    let com = '!/usr/bin/gnome-terminal --working-directory=' . expand('%:p:h')
  endif
  let saveit = ':w!'
  echo 'Goto "' . expand('%:p:h') . '" in command line'
  silent execute saveit
  silent execute com
endfunction

function! marslofunc#OpenFoler()
  let folderpath = expand('%:p:h')
  if has('win32') || has('win95') || has('win64')
    silent execute '!C:\Windows\SysWOW64\explorer.exe "' . folderpath . '"'
  else
    silent execute '!nautilus "' . folderpath . '"'
  endif
endfunction

function! marslofunc#GetVundle()                                                   " GetVundle() inspired by: http://pastebin.com/embed_iframe.php?i=C9fUE0M3
  let vundleAlreadyExists=1
  if has('win32') || has('win64')
    let bud='$VIM\bundle'
    let vud=bud . '\vundle'
    let vudcfg=expand(vud . '\.git\config')
  else
    let bud='~/.vim/bundle'
    let vud=bud . '/vundle'
    let vudcfg=expand(vud . '/.git/config')
  endif
  if filereadable(vudcfg)
    echo "Vundle has existed at " . expand(vud)
  else
    echo "Installing Vundle..."
    echo ""
    if isdirectory(expand(bud)) == 0
      call mkdir(expand(bud), 'p')
    endif
    execute 'silent !git clone https://github.com/gmarik/vundle.git "' . expand(vud) . '"'
    let vundleAlreadyExists=0
  endif
endfunction

function! marslofunc#GetVim()                                                      " Get vim from: git clone git@github.com:b4winckler/vim.git
  if has('unix')
    let vimsrc='~/.vim/vimsrc'
    let vimgitcfg=expand(vimsrc . '/.git/config')
    if filereadable(vimgitcfg)
      echo 'vimsrc has exists at ' . expand(vimsrc)
    else
      execute 'silent !git clone git@github.com:b4winckler/vim.git "' . expand(vimsrc) . '"'
    end
  endif
endfunction

function! marslofunc#RunResult()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  exec "w"
  if "python" == &filetype
    setlocal makeprg=python\ -u
  elseif "perl" == &filetype
    setlocal makeprg=perl
  elseif "ruby" == &filetype
    setlocal makeprg=ruby
  elseif "autohotkey" == &filetype
    setlocal makeprg=AutoHotkey
  endif
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  copen
  let &makeprg     = mp
  let &errorformat = ef
endfunction

function! marslofunc#GotoFile()                                                " Add suffix '.py' if the filetype is python
  if 'python' == &filetype
    let com = expand('%:p:h') . '\' . expand('<cfile>') . '.py'
  else
    let com = expand('<cfile>')
  endif
  silent execute ':e ' . com
  echo 'Open file "' . com . '" under the cursor'
endfunction

function! marslofunc#UpdateTags()                                              " Update tags file automatic
  silent !ctags -R --fields=+ianS --extra=+q
endfunction

function! marslofunc#FontSize_Reduce()                                  " Reduce the font
  if has('unix')
    let pattern = '\<\d\+$'
  elseif has('win32') || has('win95') || has('win64')
    let pattern = ':h\zs\d\+\ze:'
  endif
  let fontsize = matchstr(&gfn, pattern)
  echo fontsize
  let cmd = substitute(&gfn, pattern, string(fontsize - 1), 'g')
  let &gfn=cmd
endfunction

function! marslofunc#FontSize_Enlarge()                                 " Enlarge the font
  if has('unix')
    let pattern = '\<\d\+$'
  elseif has('win32') || has('win95') || has('win64')
    let pattern = ':h\zs\d\+\ze:'
  endif
  let fontsize = matchstr(&gfn, pattern)
  let cmd = substitute(&gfn, pattern, string(fontsize + 1), 'g')
  let &gfn=cmd
endfunction

function! marslofunc#SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! marslofunc#ResCur()                                                  " Remember Cursor position in last time, inspired from http://vim.wikia.com/wiki/VimTip80
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
" augroup resCur
  " autocmd!
  " autocmd BufWinEnter * call ResCur()
" augroup END

func! marslofunc#PylintCheck()                                                 " Run pylint
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = '"' . expand("%:t") . '"'
  setlocal makeprg=pylint\ --reports=n\ --output-format=parseable
  set efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#
  silent make "%:p"
  copen
  let &makeprg     = mp
  let &errorformat = ef
endfunc

func! MaximizeWindow()                                            " Make vim maximize while it startup
  silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunc

function! marslofunc#MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . sub
endfunction

" Inspired from Practical Vim [P213]
" Search for the Current Selection
function! marslofunc#VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/|'), '\n', '\\n', 'g')
  let @s = temp
endfunction
