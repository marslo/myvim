" Edit IMAP snippets for the current file type (F7)
function! EditSnippets()
  execute "tabedit " SnippetsDirectory() . &ft . "_snippets.vim"
endfunction

function! SnippetsDirectory()
  return "~/.vim/after/ftplugin/" . &ft . "/"
endfunction

map <F7> :call EditSnippets()<CR>
