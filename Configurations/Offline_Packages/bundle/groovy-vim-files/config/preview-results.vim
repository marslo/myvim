" Use the preview window to show command results
function! PreviewResults(command)
    execute "write"
    execute "ped /tmp/preview.window"
    execute "wincmd k"
    execute "normal ggdG"
    execute "read ! " . a:command
    execute "write"
    execute "wincmd j"
endfunction
