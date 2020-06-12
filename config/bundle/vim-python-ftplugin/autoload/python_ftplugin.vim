" This Vim script was modified by a Python script that I use to manage the
" inclusion of miscellaneous functions in the plug-ins that I publish to Vim
" Online and GitHub. Please don't edit this file, instead make your changes on
" the 'dev' branch of the git repository (thanks!). This file was generated on
" May 23, 2013 at 22:18.

" Vim autoload script
" Authors:
"  - Peter Odding <peter@peterodding.com>
"  - Bart Kroon <bart@tarmack.eu>
" Last Change: May 23, 2013
" URL: https://github.com/tarmack/vim-python-ftplugin

let g:python_ftplugin#version = '0.6.17'
let s:profile_dir = expand('<sfile>:p:h:h')

function! s:infer_types(base) " {{{1
  " TODO This is a quick hack that should be refactored and cleaned up!
  if !exists('s:inference_loaded')
    python import vim
    let scriptfile = s:profile_dir . '/misc/python-ftplugin/inference.py'
    execute 'pyfile' fnameescape(scriptfile)
    let s:inference_loaded = 1
  endif
  let line = line('.')
  let column = col('.')
  let lines = getline(1, '$')
  let cline = lines[line - 1]
  let before = cline[: column-1]
  let after = cline[column :]
  let temp = substitute(a:base, '\.[^.]*$', '', '')
  let lines[line - 1] = before . temp . after
  " XXX Without this ast.parse() will fail with a syntax error :-\
  let source = join(lines, "\n") . "\n"
  try
    redir => listing
    silent python complete_inferred_types()
    redir END
  catch
    redir END
    return []
  endtry
  let candidates = []
  let pattern = '^' . python_ftplugin#misc#escape#pattern(a:base)
  for line in split(listing, '\n')
    let fields = split(line, '|')
    let word = temp . '.' . remove(fields, 0)
    if word =~ pattern
      call add(candidates, {'word': word, 'menu': '(' . join(sort(fields), ', ') . ')'})
    endif
  endfor
  return candidates
endfunction

function! python_ftplugin#fold_text() " {{{1
  let line = getline(v:foldstart)
  if line =~ '^\s*#'
    " Comment block.
    let text = ['#']
    for line in getline(v:foldstart, v:foldend)
      call extend(text, split(line)[1:])
    endfor
  else
    let text = []
    let lnum = v:foldstart

    " Prepend decorator names to foldtext.
    while line =~ '^\s*@'
      " If there are multiple decorators separate them with commas.
      if !empty(text)
        let text[-1] = text[-1] . ","
      endif
      if python_ftplugin#misc#option#get('python_decorators_in_foldtext', 1)
        let decorator = matchstr(line, '@[A-Za-z0-9_]*')
        let decorator_labels = python_ftplugin#misc#option#get('python_decorator_labels', {})
        if has_key(decorator_labels, decorator[1:])
          let decorator = '@' . decorator_labels[decorator[1:]]
        endif
        call add(text, decorator)
      endif
      let lnum += 1
      let line = getline(lnum)
    endwhile
    
    if line =~ '^\s*\(def\|class\)\>'
      " Class or function body.
      let line = python_ftplugin#misc#str#trim(line)
      call add(text, substitute(line, ':$', '', ''))
      " Fall through.
      let lnum += 1
    elseif line =~ '\S.*\("""\|''\{3}\)'
      " Multiline string. Include the code before the string.
      call add(text, matchstr(line, '\s*\zs.*\%("""\|''\{3}\)\ze'))
    endif
    if python_ftplugin#misc#option#get('python_docstring_in_foldtext', 1)
      " Show joined lines from docstring in fold text (can be slow).
      let haystack = join(getline(lnum, v:foldend))
      let docstr = matchstr(haystack, '\("""\|''\{3}\)\zs\_.\{-}\ze\1')
      if docstr =~ '\S'
        if lnum > v:foldstart
          call add(text, '-')
        endif
        call extend(text, split(docstr))
      endif
    else
      " Show first actual line of docstring.
      for line in getline(lnum, lnum + 5)
        if line =~ '\w'
          call add(text, python_ftplugin#misc#str#trim(line))
          break
        endif
      endfor
    endif
  endif
  let numlines = v:foldend - v:foldstart + 1
  let format = "+%s %" . len(line('$')) . "d lines: %s "
  return printf(format, v:folddashes, numlines, join(text))
endfunction

function! python_ftplugin#syntax_check() " {{{1
  if python_ftplugin#misc#option#get('python_check_syntax', 1)
    " Enable the user to override python_makeprg and python_error_format.
    let makeprg = python_ftplugin#misc#option#get('python_makeprg', '')
    let error_format = python_ftplugin#misc#option#get('python_error_format', '')
    " Use reasonable defaults for python_makeprg and python_error_format.
    if makeprg == '' || error_format == ''
      " Use pyflakes when available, fall-back to the Python compiler.
      if executable('pyflakes')
        let makeprg = 'pyflakes "%:p"'
        let error_format = '%A%f:%l: %m,%C%s,%Z%p^,%f:%l: %m'
      else
        let makeprg = 'python -c "import os, sys, py_compile; sys.stderr = sys.stdout; py_compile.compile(r''%:p''); os.path.isfile(''%:pc'') and os.unlink(''%:pc'')"'
        let error_format = "SyntaxError: ('%m'\\, ('%f'\\, %l\\, %c\\, '%s'))"
      endif
    endif
    " Make sure the syntax checker is installed.
    let progname = matchstr(makeprg, '^\S\+')
    if !executable(progname)
      let message = "python.vim %s: The configured syntax checker"
      let message .= " doesn't seem to be available! I'm disabling"
      let message .= " automatic syntax checking for Python scripts."
      if exists('b:python_makeprg') && b:python_makeprg == makeprg
        let b:python_check_syntax = 0
      else
        let g:python_check_syntax = 0
      endif
      call python_ftplugin#misc#msg#warn(message, g:python_ftplugin#version)
    else
      let mp_save = &makeprg
      let efm_save = &errorformat
      try
        let &makeprg = makeprg
        let &errorformat = error_format
        let winnr = winnr()
        call python_ftplugin#misc#msg#info('python.vim %s: Checking Python script syntax ..', g:python_ftplugin#version)
        execute 'silent make!'
        cwindow
        if winnr() != winnr
          let w:quickfix_title = 'Issues reported by ' . progname
          execute winnr . 'wincmd w'
        endif
        redraw
        echo ''
      finally
        let &makeprg = mp_save
        let &errorformat = efm_save
      endtry
    endif
  endif
endfunction

function! python_ftplugin#jump(motion) range " {{{1
    let cnt = v:count1
    let save = @/    " save last search pattern
    mark '
    while cnt > 0
    silent! exe a:motion
    let cnt = cnt - 1
    endwhile
    call histdel('/', -1)
    let @/ = save    " restore last search pattern
endfun

function! python_ftplugin#include_expr(fname) " {{{1
  call s:load_python_script()
  redir => output
  silent python find_module_path(vim.eval('a:fname'))
  redir END
  return python_ftplugin#misc#str#trim(output)
endfunction

function! python_ftplugin#omni_complete(findstart, base) " {{{1
  if a:findstart
    return s:find_start('variable')
  else
    let starttime = python_ftplugin#misc#timer#start()
    let candidates = []
    if s:do_variable_completion(a:base[-1:])
      let base = a:base
      if match(s:get_continued_line(), '\<from\>') >= 0
        let from = s:get_base_module()
        if !empty(from)
          let base = from . '.' . a:base
        endif
      else
        let imports = s:get_imports(a:base)
      endif
      call s:load_python_script()
      redir => listing
        silent python complete_variables(vim.eval('base'))
      redir END
      let completes = split(listing, '\n')
      let pattern = '^' . python_ftplugin#misc#escape#pattern(base)
      call filter(completes, 'v:val =~# pattern')
      if exists('from') && !empty(from)
        call map(completes, 'v:val[len(from) + 1 :]')
      endif
      call extend(candidates, completes)
      if exists('imports')
        redir => listing
        let base = a:base[stridx(a:base, '.')+1 :]
        for module in keys(imports)
          let module = imports[module] . '.' . base
          silent python complete_variables(vim.eval('module'))
        endfor
        redir END
        let completes = split(listing, '\n')
        for module in keys(imports)
          let pattern = '^' . python_ftplugin#misc#escape#pattern(imports[module]) . '\.'
          let index = len(imports[module])
          for compl in completes
            if compl =~# pattern
              call add(candidates, module . '.' . compl[index+1:])
            endif
          endfor
        endfor
      endif
    endif
    if s:do_module_completion(a:base[-1:])
      if !exists('imports')
        let imports = s:get_imports(a:base)
      endif
      call extend(candidates, s:add_modules(a:base, imports))
    endif
    " Filter the completion candidates according to the given base.
    let pattern = '^' . python_ftplugin#misc#escape#pattern(a:base)
    call filter(candidates, 'v:val =~# pattern')
    let pattern = pattern . '\.'
    call filter(candidates, 'v:val !~ pattern')
    " Convert the completion candidates to dictionaries to make them
    " compatible with the candidates generated by the type inference engine.
    call map(candidates, '{"word": v:val}')
    " Add the completion candidates suggested by the type inference engine.
    call extend(candidates, s:infer_types(a:base))
    " Sort the completion candidates.
    call sort(candidates, 's:friendly_sort')
    " Provide some feedback in case of :verbose.
    call python_ftplugin#misc#timer#stop("python.vim %s: Found %s completion candidates in %s.", g:python_ftplugin#version, len(candidates), starttime)
    return candidates
  endif
endfunction

function! s:friendly_sort(a, b) " {{{1
  let a = substitute(tolower(a:a['word']), '_', '\~', 'g')
  let b = substitute(tolower(a:b['word']), '_', '\~', 'g')
  return a < b ? -1 : a > b ? 1 : 0
endfunction

function! s:add_modules(base, imports) " {{{1
  " Returns a list of completion candidates for base. Takes the imports
  " mapping as created by s:get_imports().
  let candidates = s:find_modules(a:base)
  if !empty(a:imports)
    let base = a:base[stridx(a:base, '.')+1 :]
    for name in keys(a:imports)
      let module = a:imports[name] . '.' . base
      let completes = s:find_modules(module)
      let pattern = '^' . python_ftplugin#misc#escape#pattern(a:imports[name]) . '\.'
      let index = len(a:imports[name])
      for compl in completes
        if compl =~# pattern
          call add(candidates, name . '.' . compl[index+1:])
        endif
      endfor
    endfor
  endif
  return candidates
endfunction

function! s:find_modules(base) " {{{1
  let start_load = python_ftplugin#misc#timer#start()
  let todo = []
  let fromstr = s:get_base_module()
  let from = split(fromstr, '\.')
  call extend(todo, from)
  call extend(todo, split(a:base, '\.'))
  let done = []
  let items = []
  let node = python_ftplugin#get_modules([], s:module_completion_cache)
  while !empty(todo)
    if len(todo) == 1
      " Include items from the containing node that start with the last item.
      let keys = keys(node)
      let pattern = '^' . python_ftplugin#misc#escape#pattern(todo[0])
      call filter(keys, "v:val =~# pattern")
      for key in keys
        call add(items, join(done + [key], '.'))
      endfor
    endif
    if has_key(node, todo[0])
      let name = remove(todo, 0)
      call add(done, name)
      let node = python_ftplugin#get_modules(done, node[name])
    else
      break
    endif
  endwhile
  if len(from) > len(done)
    let node = {}
  endif
  let done = done[len(from) :]
  let keys = keys(node)
  for key in keys
    call add(items, join(done + [key], '.'))
  endfor
  call python_ftplugin#misc#timer#stop("python.vim %s: Found %i module names in %s.", g:python_ftplugin#version, len(items), start_load)
  return items
endfunction

function! s:get_base_module() " {{{1
  return matchstr(s:get_continued_line(), '\<\(from\s\+\)\@<=[A-Za-z0-9_.]\+\(\s\+import\s\+\([A-Za-z0-9_,]\s*\)*\)\@=')
endfunction

function! s:get_imports(base) " {{{1
  " When completing regular code search for 'from import' and 'import as' lines
  " that match the base we are looking for.
  if empty(a:base) || a:base =~ '^\.\+$'
    return {}
  endif
  let i = stridx(a:base, '.')
  let base = i >= 0 ? a:base[: i] : a:base
  let imports = {}
  let cursor_save = getpos('.')
  call cursor(1, 1)
  let base = python_ftplugin#misc#escape#pattern(split(a:base, '\.')[0])
  while search('\<import\>', 'cW', 0, 500) && s:syntax_is_code()
    " Get the full import line and remove any trailing comments.
    let line_no = line('.')
    let line = split(getline(line_no), '\s*#')[0]
    while match(line, '\\$') >= 0
      let line_no += 1
      let line = line[0 : -2] . get(split(getline(line_no), '\s*#'), 0, '')
    endwhile
    if match(line, '\<import\>.\{-}\<' . base) >= 0

      " Get the from part if it is pressent.
      let from = matchstr(line, '\<\%(from\s\+\)\@<=[A-Za-z0-9_.]\+\%(\s\+import\>\)\@=')
      " Get the module if this is a 'import as' line.
      let module = matchstr(line, '\<\%(import\s\+\)\@<=[A-Za-z0-9_.]\+\%(\s\+as\s\+' . base . '\)\@=')
      if !empty(module)
        " If the line is a 'import as' line, get the name it is imported as.
        let names = [split(line, '\s*as\s*')[-1]]
      else
        " If there is no 'as' get the list of imported names.
        let names = split(line, ',\s*')
        let names[0] = split(names[0], '\s\+')[-1]
      endif

      for name in filter(names, 'v:val =~ "^' . base . '"')
        if empty(module)
          let imports[name] = from . '.' . name
        elseif empty(from)
          let imports[name] = module
        else
          let imports[name] = from . '.' . module
        endif
      endfor
      unlet from module names line
    endif
    call cursor(line_no + 1, 1)
  endwhile
  call setpos('.', cursor_save)
  return imports
endfunction

function! python_ftplugin#aaa(base)
  return s:get_imports(a:base)
endfunction

function! python_ftplugin#auto_complete(chr) " {{{1
  if a:chr == '.' && search('\%#[A-Za-z0-9._]', 'cn', line('.'))
    " Don't auto complete when typing in between parts of code.
    return a:chr
  elseif a:chr == ' '
        \ && search('\<from\s\+[A-Za-z0-9._]\+\s*\%#\s*$', 'bcn', line('.'))
        \ && s:syntax_is_code()
    " Fill 'import' in for the user when a space is entered after the from part.
    if python_ftplugin#misc#option#get('python_auto_complete_variables', 0)
      let type = 'variable'
      let result = "import \<C-x>\<C-o>\<C-n>"
    elseif python_ftplugin#misc#option#get('python_auto_complete_modules', 1)
      let type = 'module'
      let result = "import \<C-x>\<C-o>\<C-n>"
    endif
  elseif python_ftplugin#misc#option#get('python_auto_complete_variables', 0)
        \ && s:do_variable_completion(a:chr)
    " Automatic completion of canonical variable names.
    let type = 'variable'
    let result = "\<C-x>\<C-o>\<C-n>"
  elseif python_ftplugin#misc#option#get('python_auto_complete_modules', 1)
        \ && s:do_module_completion(a:chr)
    " Automatic completion of canonical module names,
    " only when variable name completion is not available.
    let type = 'module'
    let result = "\<C-x>\<C-o>\<C-n>"
  endif
  if exists('result')
    call python_ftplugin#misc#msg#debug("python.vim %s: %s %s completion.", g:python_ftplugin#version, pumvisible() ? "Continuing" : "Starting", type)
    " Make sure Vim opens the menu but doesn't enter the first match.
    let b:python_cot_save = &completeopt
    set cot+=menu cot+=menuone cot+=longest
    " Restore &completeopt after completion.
    augroup PluginFileTypePython
      autocmd! CursorHold,CursorHoldI <buffer> call s:restore_completeopt()
    augroup END
    " Enter character and start completion.
    return a:chr . result
  endif
  return a:chr
endfunction

function! s:do_module_completion(chr) " {{{1
  let chr = a:chr
  if chr == ''
    let chr = ' '
  endif
  let line = s:get_continued_line()

  let complete = s:do_completion_always(chr, line)
  if complete != -1
    return complete
  
  " Complete module names in the first part of a from XX import YY line.
  elseif match(line, '\<from\s*\(\s\+[A-Za-z0-9_.]*\s\@!\)\=$') >= 0
    " When a space is typed after the module name do not complete.
    if chr == ' ' && match(line, '\<from\s\+[A-Za-z0-9_.]\+\s*$') >= 0
      return 0
    endif
    return 1

  " Complete modules after an import statement not part of a from XX import YY
  " line. But only when the last non whitespace character after a preceding
  " name is a comma.
  elseif match(line, '\<import\s*\(\s\+[A-Za-z0-9_.]*\s*,\)*\s*[A-Za-z0-9_.]*\s\@!$') >= 0
        \ && match(line, '\<from.\{-}import.\{-}$') < 0
    if chr == ' ' && match(line, '\(import\|,\)\s*$') < 0
      return 0
    endif
    return 1
  endif
  return 1
endfunction

function! s:do_variable_completion(chr) " {{{1
  let chr = a:chr
  if chr == ''
    let chr = ' '
  endif
  let line = s:get_continued_line()

  let complete = s:do_completion_always(chr, line)
  if complete != -1
    return complete

  " Start variable completion when a space is typed in the second part of a
  " from XX import YY line. But only when the last non whitespace character
  " after a preceding name is a comma.
  elseif chr != ' '
        \ && match(line, '\<from\s\+[A-Za-z0-9_.]\+\s\+import\(\s*[A-Za-z0-9_]\+\s*,\)*\s*[A-Za-z0-9_]*\s\@!$') >= 0
    return 1

  " Don't complete variables when from or import is the only keyword preceding
  " the cursor on the line.
  elseif match(line, '\<\(from\|import\).*$') >= 0
    return 0
  endif
  return 1
endfunction

function! s:do_completion_always(chr, line) " {{{1
  " Function to check if completion should be started regardless of type.
  " Returns 1 when completion should be started.
  " Returns 0 if it should definitely not be started.
  " Returns -1 when no conclusion can be drawn. (i.e. completion for only one type should
  " start.)

  " Do not complete when typing a comment or string literal.
  if !s:syntax_is_code()
    return 0
  
  " Don't complete after 'self'.
  elseif a:line =~ '\<self$'
    return 0

  " Complete module and variable names when at the end of a from XX import YY line.
  elseif match(a:line, '\<from\s\+[A-Za-z0-9_.]\+\.\@<!\s\+import\(\s*[A-Za-z0-9_]\+\s*,\)*\s*[A-Za-z0-9_]*$') >= 0
    " When a space is typed check for comma separator.
    if a:chr == ' ' && match(a:line, '\(\<import\|,\)\s*$') < 0
      return 0
    " A dot is not allowed in the second part of a from XX import YY line.
    elseif a:chr == '.'
      return 0
    endif
    return 1

  " Don't complete when a space is typed and we're not on an import line.
  elseif a:chr == ' ' && match(a:line, '\<\(from\|import\|import.\{-},\)\s*$') < 0
    return 0
  endif
  return -1
endfunction

function! s:syntax_is_code() " {{{2
  return synIDattr(synID(line('.'), col('.') - 1, 1), 'name') !~? 'string\|comment'
endfunction

function! s:get_continued_line() " {{{2
  let line = getline('.')[0 : col('.') - 1]
  let line_no = line('.')
  while match(getline(line_no - 1), '\\$') >= 0
    let line_no -= 1
    let line = getline(line_no)[0 : -2] . line
  endwhile
  return line
endfunction

function! s:find_start(type) " {{{1
  let prefix = getline('.')[0 : col('.')-2]
  let ident = matchstr(prefix, '[A-Za-z0-9_.]\+$')
  call python_ftplugin#misc#msg#debug("python.vim %s: Completing %s `%s'.", g:python_ftplugin#version, a:type, ident)
  return col('.') - len(ident) - 1
endfunction

function! python_ftplugin#get_modules(base, node) " {{{2
  if empty(a:node)
    call s:load_python_script()
    redir => listing
    silent python complete_modules(vim.eval("join(a:base, '.')"))
    redir END
    let lines = split(listing, '\n')
    for token in lines
      if !has_key(a:node, token)
        let a:node[token] = {}
      endif
    endfor
  endif
  return a:node
endfunction

let s:module_completion_cache = {}

function! s:load_python_script() " {{{2
  if !exists('s:python_script_loaded')
    python import vim
    let scriptfile = s:profile_dir . '/misc/python-ftplugin/support.py'
    execute 'pyfile' fnameescape(scriptfile)
    let s:python_script_loaded = 1
  endif
endfunction

function! s:restore_completeopt() " {{{1
  " Restore the original value of &completeopt.
  if exists('b:python_cot_save')
    let &completeopt = b:python_cot_save
    unlet b:python_cot_save
  endif
  " Disable the automatic command that called us.
  augroup PluginFileTypePython
    autocmd! CursorHold,CursorHoldI <buffer>
  augroup END
endfunction

" vim: ts=2 sw=2 sts=2  et
