" Toggle comments with #.
function! CommentAndUncomment()
  let s:line = getline(".")
  if match(s:line, '^\s*// ') != -1
    call setline(".", substitute(s:line, "\\(\\s*\\)// ", "\\1", ""))
  elseif match(s:line, '^\s*[^//]') != -1
    call setline(".", substitute(s:line, "\\(\\s*\\)", "\\1// ", ""))
  end
endfunction

map # :call CommentAndUncomment()<CR>
