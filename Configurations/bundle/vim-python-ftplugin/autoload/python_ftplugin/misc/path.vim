" This Vim script was modified by a Python script that I use to manage the
" inclusion of miscellaneous functions in the plug-ins that I publish to Vim
" Online and GitHub. Please don't edit this file, instead make your changes on
" the 'dev' branch of the git repository (thanks!). This file was generated on
" May 23, 2013 at 22:18.

" Pathname manipulation functions.
"
" Author: Peter Odding <peter@peterodding.com>
" Last Change: May 20, 2013
" URL: http://peterodding.com/code/vim/misc/

let s:windows_compatible = python_ftplugin#misc#os#is_win()
let s:mac_os_x_compatible = has('macunix')

function! python_ftplugin#misc#path#which(...) " {{{1
  " Scan the executable search path (`$PATH`) for one or more external
  " programs. Expects one or more string arguments with program names. Returns
  " a list with the absolute pathnames of all found programs. Here's an
  " example:
  "
  "     :echo python_ftplugin#misc#path#which('gvim', 'vim')
  "     ['/usr/local/bin/gvim',
  "      '/usr/bin/gvim',
  "      '/usr/local/bin/vim',
  "      '/usr/bin/vim']
  let extensions = ['']
  if s:windows_compatible
    call extend(extensions, split($PATHEXT, ';'))
  endif
  let matches = []
  let checked = {}
  for program in a:000
    for extension in extensions
      for directory in split($PATH, s:windows_compatible ? ';' : ':')
        let directory = python_ftplugin#misc#path#absolute(directory)
        if isdirectory(directory)
          let path = python_ftplugin#misc#path#merge(directory, program . extension)
          if executable(path)
            call add(matches, path)
          endif
        endif
      endfor
    endfor
  endfor
  return matches
endfunction

function! python_ftplugin#misc#path#split(path) " {{{1
  " Split a pathname (the first and only argument) into a list of pathname
  " components.
  "
  " On Windows, pathnames starting with two slashes or backslashes are UNC
  " paths where the leading slashes are significant... In this case we split
  " like this:
  "
  " - Input: `'//server/share/directory'`
  " - Result: `['//server', 'share', 'directory']`
  "
  " Everything except Windows is treated like UNIX until someone has a better
  " suggestion :-). In this case we split like this:
  "
  " - Input: `'/foo/bar/baz'`
  " - Result: `['/', 'foo', 'bar', 'baz']`
  "
  " To join a list of pathname components back into a single pathname string,
  " use the `python_ftplugin#misc#path#join()` function.
  if type(a:path) == type('')
    if s:windows_compatible
      if a:path =~ '^[\/][\/]'
        " UNC pathname.
        return split(a:path, '\%>2c[\/]\+')
      else
        " If it's not a UNC path we can simply split on slashes & backslashes.
        return split(a:path, '[\/]\+')
      endif
    else
      " Everything else is treated as UNIX.
      let absolute = (a:path =~ '^/')
      let segments = split(a:path, '/\+')
      return absolute ? insert(segments, '/') : segments
    endif
  endif
  return []
endfunction

function! python_ftplugin#misc#path#join(parts) " {{{1
  " Join a list of pathname components (the first and only argument) into a
  " single pathname string. This is the counterpart to the
  " `python_ftplugin#misc#path#split()` function and it expects a list of pathname
  " components as returned by `python_ftplugin#misc#path#split()`.
  if type(a:parts) == type([])
    if s:windows_compatible
      return join(a:parts, python_ftplugin#misc#path#directory_separator())
    elseif a:parts[0] == '/'
      " Absolute path on UNIX (non-Windows).
      return '/' . join(a:parts[1:], '/')
    else
      " Relative path on UNIX (non-Windows).
      return join(a:parts, '/')
    endif
  endif
  return ''
endfunction

function! python_ftplugin#misc#path#directory_separator() " {{{1
  " Find the preferred directory separator for the platform and settings.
  return exists('+shellslash') && &shellslash ? '/' : '\'
endfunction

function! python_ftplugin#misc#path#absolute(path) " {{{1
  " Canonicalize and resolve a pathname, *regardless of whether it exists*.
  " This is intended to support string comparison to determine whether two
  " pathnames point to the same directory or file.
  if type(a:path) == type('')
    let path = a:path
    " Make the pathname absolute.
    if path =~ '^\~'
      " Expand ~ to $HOME.
      let path = $HOME . '/' . path[1:]
    elseif python_ftplugin#misc#path#is_relative(path)
      " Make relative pathnames absolute.
      let path = getcwd() . '/' . path
    endif
    " Resolve symbolic links to find the canonical pathname. In my tests this
    " also removes all symbolic pathname segments (`.' and `..'), even when
    " the pathname does not exist. Also there used to be a bug in resolve()
    " where it wouldn't resolve pathnames ending in a directory separator.
    " Since it's not much trouble to work around, that's what we do.
    let path = resolve(substitute(path, s:windows_compatible ? '[\/]\+$' : '/\+$', '', ''))
    " Normalize directory separators (especially relevant on Windows).
    let parts = python_ftplugin#misc#path#split(path)
    if s:windows_compatible && parts[0] =~ '^[\/][\/]'
      " Also normalize the two leading "directory separators" (I'm not
      " sure what else to call them :-) in Windows UNC pathnames.
      let parts[0] = repeat(python_ftplugin#misc#path#directory_separator(), 2) . parts[0][2:]
    endif
    return python_ftplugin#misc#path#join(parts)
  endif
  return ''
endfunction

function! python_ftplugin#misc#path#relative(path, base) " {{{1
  " Make an absolute pathname (the first argument) relative to a directory
  " (the second argument).
  let path = python_ftplugin#misc#path#split(a:path)
  let base = python_ftplugin#misc#path#split(a:base)
  while path != [] && base != [] && path[0] == base[0]
    call remove(path, 0)
    call remove(base, 0)
  endwhile
  let distance = repeat(['..'], len(base))
  return python_ftplugin#misc#path#join(distance + path)
endfunction


function! python_ftplugin#misc#path#merge(parent, child, ...) " {{{1
  " Join a directory pathname and filename into a single pathname.
  if type(a:parent) == type('') && type(a:child) == type('')
    " TODO Use python_ftplugin#misc#path#is_relative()?
    if s:windows_compatible
      let parent = substitute(a:parent, '[\\/]\+$', '', '')
      let child = substitute(a:child, '^[\\/]\+', '', '')
      return parent . '\' . child
    else
      let parent = substitute(a:parent, '/\+$', '', '')
      let child = substitute(a:child, '^/\+', '', '')
      return parent . '/' . child
    endif
  endif
  return ''
endfunction

function! python_ftplugin#misc#path#commonprefix(paths) " {{{1
  " Find the common prefix of path components in a list of pathnames.
  let common = python_ftplugin#misc#path#split(a:paths[0])
  for path in a:paths
    let index = 0
    for segment in python_ftplugin#misc#path#split(path)
      if len(common) <= index
        break
      elseif common[index] != segment
        call remove(common, index, -1)
        break
      endif
      let index += 1
    endfor
  endfor
  return python_ftplugin#misc#path#join(common)
endfunction

function! python_ftplugin#misc#path#encode(path) " {{{1
  " Encode a pathname so it can be used as a filename. This uses URL encoding
  " to encode special characters.
  if s:windows_compatible
    let mask = '[*|\\/:"<>?%]'
  elseif s:mac_os_x_compatible
    let mask = '[\\/%:]'
  else
    let mask = '[\\/%]'
  endif
  return substitute(a:path, mask, '\=printf("%%%x", char2nr(submatch(0)))', 'g')
endfunction


function! python_ftplugin#misc#path#decode(encoded_path) " {{{1
  " Decode a pathname previously encoded with `python_ftplugin#misc#path#encode()`.
  return substitute(a:encoded_path, '%\(\x\x\?\)', '\=nr2char("0x" . submatch(1))', 'g')
endfunction

" python_ftplugin#misc#path#equals(a, b) - Check whether two pathnames point to the same file. {{{1

if s:windows_compatible
  function! python_ftplugin#misc#path#equals(a, b)
    return a:a ==? a:b || python_ftplugin#misc#path#absolute(a:a) ==? python_ftplugin#misc#path#absolute(a:b)
  endfunction
else
  function! python_ftplugin#misc#path#equals(a, b)
    return a:a ==# a:b || python_ftplugin#misc#path#absolute(a:a) ==# python_ftplugin#misc#path#absolute(a:b)
  endfunction
endif

function! python_ftplugin#misc#path#is_relative(path) " {{{1
  " Returns true (1) when the pathname given as the first argument is
  " relative, false (0) otherwise.
  if a:path =~ '^\w\+://'
    return 0
  elseif s:windows_compatible
    return a:path !~ '^\(\w:\|[\\/]\)'
  else
    return a:path !~ '^/'
  endif
endfunction

function! python_ftplugin#misc#path#tempdir() " {{{1
  " Create a temporary directory and return the pathname of the directory.
  if !exists('s:tempdir_counter')
    let s:tempdir_counter = 1
  endif
  if exists('*mkdir')
    if s:windows_compatible
      let template = $TMP . '\vim_tempdir_'
    elseif filewritable('/tmp') == 2
      let template = '/tmp/vim_tempdir_'
    endif
  endif
  if !exists('template')
    throw "python_ftplugin#misc#path#tempdir() hasn't been implemented on your platform!"
  endif
  while 1
    let directory = template . s:tempdir_counter
    try
      call mkdir(directory, '', 0700)
      return directory
    catch /\<E739\>/
      " Keep looking for a non-existing directory.
    endtry
    let s:tempdir_counter += 1
  endwhile
endfunction

" vim: ts=2 sw=2 et
