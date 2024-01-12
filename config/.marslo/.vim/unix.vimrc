" =============================================================================
"      FileName : vimrc.autocmd
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"       Version : 2.0.1
"    LastChange : 2024-01-10 22:58:58
" =============================================================================

function! DoRedraw()
  execute "silent redraw!"
endfunction
nnoremap <C-k> :call DoRedraw()<CR>
map <C-k>      :call DoRedraw()<CR>

if isdirectory( expand(pluginHome . 'MarsloFunc') )
  nnoremap cmd    :call marslofunc#OpenCMD()<CR>
  nnoremap gf     :call marslofunc#GotoFile()<CR>
endif

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
