" Execute actions on the current file based on the file name (F5)
function! ExecuteFile()
  let file = expand("%")

  if stridx(file, "/tmp/sample.rb") != -1
    " call PreviewResults("ruby -rubygems " . file)
    call ExecuteTest()
  elseif stridx(file, ".mo") != -1
    call PreviewResults("mo " . file)
  elseif stridx(file, ".io") != -1
    call PreviewResults("osxvm " . file)
  elseif stridx(file, ".ml") != -1
    call PreviewResults("ocaml " . file)
  elseif stridx(file, "_test.rb") != -1
    call ExecuteTest()
  elseif stridx(file, ".rb") != -1
    execute "!ruby %"
  elseif stridx(file, "Tests.groovy") != -1
    execute "!grails test-app"
  elseif stridx(file, "Story.groovy") != -1
    execute "!grails test-app -functional"
  elseif stridx(file, ".groovy") != -1
    execute "!groovy %"
  elseif stridx(file, ".lua") != -1
    call PreviewResults("lua " . file)
  elseif stridx(file, ".min") != -1
    call PreviewResults("min " . file)
  elseif stridx(file, ".haml") != -1
    execute "!haml % " . substitute(file, "\.haml$", ".html", "")
  elseif stridx(file, ".dot") != -1
    let dotfile = substitute(file, "\.dot$", ".pdf", "")
    execute "!dot -Tpdf % > " . dotfile . " && open " . dotfile
  elseif stridx(file, ".markdown") != -1
    execute "!maruku %"
  elseif stridx(file, ".md") != -1
    execute "!maruku %"
  elseif stridx(file, ".sass") != -1
    execute "!sass % " . substitute(file, "\.sass$", ".css", "")
  elseif stridx(file, ".html") != -1
    execute "!open %"
  elseif stridx(file, ".s") != -1
    call PreviewResults("shiny " . file)
  endif
endfunction

map <F5> :call ExecuteFile()<CR>
imap <F5> <ESC>:w!<CR>:call ExecuteFile()<CR>
