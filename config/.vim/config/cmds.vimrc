" =============================================================================
"      FileName : vimrc.cmds
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"    LastChange : 2024-01-10 21:53:41
" =============================================================================

" /**************************************************************
"                                                _
"                                               | |
"   ___ ___  _ __ ___  _ __ ___   __ _ _ __   __| |___
"  / __/ _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
" | (_| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"  \___\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
"
" **************************************************************/
" reverse the lines of the whole file or a visually highlighted block.
    " :Rev is a shorter prefix you can use.
    " Adapted from http://tech.groups.yahoo.com/group/vim/message/34305
    " reference : https://superuser.com/a/387869/112396
command! -nargs=0 -bar -range=% Reverse
    \       let save_mark_t = getpos("'t")
    \<bar>      <line2>kt
    \<bar>      exe "<line1>,<line2>g/^/m't"
    \<bar>  call setpos("'t", save_mark_t)
nnoremap <Leader>r :Reverse <bar> nohlsearch<CR>
xnoremap <Leader>r :Reverse <bar> nohlsearch<CR>

command! -nargs=0 DocTocUpdate execute 'silent !/usr/local/bin/doctoc --notitle --update-only --github --maxlevel 3 %' | execute 'redraw!'
command! -nargs=0 DocTocCreate execute 'silent !/usr/local/bin/doctoc --notitle --github --maxlevel 3 %' | execute 'redraw!'
command! -nargs=1        First execute                           'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')
command! -nargs=1 -range First execute <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')
command! -nargs=0        Iname execute 'echo expand("%:p")'

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
