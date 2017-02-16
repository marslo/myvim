" Execute Ruby tests or a particular scenarios.
" If the cursor is on a line that contains an scenario declaration,
" only that scenario is run.
function! ExecuteTest()
  let s:file = expand("%")
  let s:line = getline(".")

  if match(s:line, '^\s*\(scenario\|test\|should\) ') != -1
    let s:name = substitute(s:line, '^.* "\(.*\)" do\s*', "\\1", "")
    let s:name = substitute(s:name, '\v\W', "_", "g")
    execute "!env ruby -Itest " . s:file . " -n '/test_" . s:name . "/'"
  else
    execute "!env ruby -Itest " . s:file
  end
endfunction
