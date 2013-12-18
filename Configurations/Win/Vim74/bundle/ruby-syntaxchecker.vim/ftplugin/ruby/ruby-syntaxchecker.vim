" To change mapping, just put
" let g:ruby_syntaxcheck_map='whatever'
" in your .vimrc
" To change the color of
function! <SID>RubySC()
  set lazyredraw
  " Close any existing cwindows.
  cclose
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  set grepformat&vim
  set grepformat&vim
  "let &grepformat = '%f:%l:%m'
  let &errorformat = \%+E%f:%l:\ parse\ error,\%W%f:%l:\ warning:\ %m,\%E%f:%l:in\ %*[^:]:\ %m,\%E%f:%l:\ %m,\%-C%\tfrom\ %f:%l:in\ %.%#,\%-Z%\tfrom\ %f:%l,\%-Z%p^,\%-G%.%#
  let &grepprg = 'ruby -cw'
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  let l:mod_total = 0
  let l:win_count = 1
  " Determine correct window height
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/l:win_count |
        \ execute 'resize +'.l:mod_total
  " Open cwindow
  execute 'belowright copen '.l:mod_total
  nnoremap <buffer> <silent> c :cclose<CR>
  set nolazyredraw
  redraw!
  let tlist=getqflist() ", 'get(v:val, ''bufnr'')')
  if empty(tlist)
	  if !hlexists('GreenBar')
		  hi GreenBar term=reverse ctermfg=white ctermbg=darkgreen guifg=white guibg=darkgreen
	  endif
	  echohl GreenBar
	  echomsg "Syntax OK"
	  echohl None
	  cclose
  endif
endfunction

if !exists('g:ruby_syntaxcheck_map')
    let g:ruby_syntaxcheck_map='<F4>'
endif
if ( !hasmapto('<SID>RubySC()') && (maparg(g:ruby_syntaxcheck_map) == '') )
  exe 'nnoremap <silent> '. g:ruby_syntaxcheck_map .' :call <SID>RubySC()<CR>'
else
  if ( !has("gui_running") || has("win32") )
    echo "Ruby Syntax Checker Error: No Key mapped.\n".
          \ g:ruby_syntaxcheck_map ." is taken and a replacement was not assigned."
  endif
endif

