" =============================================================================
"      FileName : vimrc.functions
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"    LastChange : 2024-01-10 21:53:41
" =============================================================================

" /**************************************************************
"   __                  _   _
"  / _|_   _ _ __   ___| |_(_) ___  _ __
" | |_| | | | '_ \ / __| __| |/ _ \| '_ \
" |  _| |_| | | | | (__| |_| | (_) | | | |
" |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|
"
" **************************************************************/
function! GetPlug()                                                 " GetPlug() inspired by: http://pastebin.com/embed_iframe.php?i=C9fUE0M3
  if has( 'win32' ) || has( 'win64' )
    let pluginHome=$VIM . '\autoload'
    let pluginFile=pluginHome . '\plug.vim'
  else
    let pluginHome=$HOME . '/.vim/autoload'
    let pluginFile=pluginHome . '/plug.vim'
  endif

  if filereadable( pluginFile )
    echo "vim-plug has existed at " . expand( pluginFile )
  else
    echo "download vim-plug to " . expand( pluginFile ) . '...'
    echo ""
    if isdirectory( expand(pluginHome) ) == 0
      call mkdir( expand(pluginHome), 'p' )
    endif
    execute 'silent !curl --create-dirs https://github.com/junegunn/vim-plug/raw/master/plug.vim -kfLo "' . expand( pluginFile ) . '"'
  endif
endfunction
command! GetPlug :call GetPlug()

if isdirectory( expand(pluginHome . 'MarsloFunc') )
  command! GetVim :call marslofunc#GetVim()<CR>
  xnoremap *      :<C-u>call marslofunc#VSetSearch()<CR>/<C-R>=@/<CR><CR>
  xnoremap #      :<C-u>call marslofunc#VSetSearch()<CR>?<C-R>=@/<CR><CR>
  nnoremap <F12>  :call marslofunc#UpdateTags()<CR>

  augroup resCur
    autocmd!
    autocmd BufWinEnter * call marslofunc#ResCur()
  augroup END

  set foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
  set foldtext=marslofund#MyFoldText()<CR>
endif

" twiddle case : https://vim.fandom.com/wiki/Switching_case_of_characters#Twiddle_case
function! TwiddleCase(str)
  if a:str ==# toupper( a:str )
    let result = tolower( a:str )
  elseif a:str ==# tolower( a:str )
    let result = substitute( a:str,'\(\<\w\+\>\)', '\u\1', 'g' )
  else
    let result = toupper( a:str )
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

function! IgnoreSpells()                                            " ignore CamelCase words when spell checking
  syntax      match   CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syntax      cluster Spell add=CamelCase
  syntax      match   mixedCase /\<[a-z]\+[A-Z].\{-}\>/      contains=@NoSpell transparent
  syntax      cluster Spell add=mixedCase
  " or syntax match   myExNonWords +\<\p*[^A-Za-z \t]\p*\>+  contains=@NoSpell
  " or syntax match   myExCapitalWords +\<\w*[A-Z]\K*\>\|'s+ contains=@NoSpell
  " syntax    match   Url "\w\+:\/\/[:/?#[\]@!$&'()*+,;=0-9[:lower:][:upper:]_\-.~]\+" contains=@NoSpell containedin=@AllSpell transparent
  " syntax    cluster Spell add=Url
  " syntax    match   UrlNoSpell '\w\+:\/\/[^[:space:]]\+'   contains=@NoSpell transparent
  " syntax    cluster Spell add=UrlNoSpell
endfunction
autocmd BufRead,BufNewFile * :call IgnoreSpells()
set spellcapcheck=                                                  " ignore capital check

" redir into new tab: https://vim.fandom.com/wiki/Capture_ex_command_outputhttps://vim.fandom.com/wiki/Capture_ex_command_output
" `gt`, `:tabfirst`, `:tabnext`, `:tablast` ... to switch tabs : https://vim.fandom.com/wiki/Alternative_tab_navigation
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty( message )
    echoerr "no output"
  else
    tabnew                                                          " use `new` instead of `tabnew` below if you prefer split windows instead of tabs
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

" file is large from 10mb                                           " https://vim.fandom.com/wiki/Faster_loading_of_large_files
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function! BSkipQuickFix( command )                                  " switch avoid quickfix : https://vi.stackexchange.com/a/19420/7389
  let start_buffer = bufnr('%')
  execute a:command
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    execute a:command
  endwhile
endfunction
nnoremap <Tab>      :call BSkipQuickFix("bn")<CR>
nnoremap <S-Tab>    :call BSkipQuickFix("bp")<CR>
nnoremap <leader>bp :call BSkipQuickFix("bn")<CR>
nnoremap <leader>bn :call BSkipQuickFix("bp")<CR>

" set spellcamelcase=1
fun! IgnoreCamelCaseSpell()                                         " Ignore CamelCase words when spell checking
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn match mixedCase /\<[a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
  syn cluster Spell add=mixedCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell

if exists( ":Tabularize" )                                          " 'godlygeek/tabular'
  function! s:table_auto_align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists( ':Tabularize' ) && getline('.') =~# '^\s*|'
      \ && (getline(line('.')-1) =~# p || getline( line('.')+1 ) =~# p)
      let column   = strlen( substitute(getline('.')[0:col('.')],'[^|]','','g') )
      let position = strlen( matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*') )
      Tabularize/|/l1
      normal! 0
      call search( repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.') )
    endif
  endfunction
endif

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
