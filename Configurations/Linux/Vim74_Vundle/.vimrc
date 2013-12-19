" =============================================================================
"       FileName: .vimrc
"           Desc:
"         Author: Marslo
"        Created: 2010-10
"        Version: 0.1.12
"     LastChange: 2013-12-19 17:19:26
"        History: 0.0.3 | Marslo | Add the Autoload and Fast Edit difference between win32 and non-win32
"                 0.0.4 | Marslo | Add CheckRubySyntax() function for checking and run ruby script
"                 0.0.5 | Marslo | Add the function of highlight txt file
"                       | Marslo | Add the function of Automatic paire signs (), [], {}, '', etc
"                 0.0.6 | Marslo | Remove a pair of parentheses, brackets, or braces
"                 0.0.7 | Marslo | Modification about autoPair(): if there are char behind the ( or [ or { it wont pair
"                 0.0.8 | Marslo | Add the function of OpenCMD(), GotoFile(), FontSize_Enlarge(), FontSize_Reduce() and UpdateTagsFile()
"                 0.0.9 | Marslo | Add three bundles: woainvzu/EnhCommentify.vim && woainvzu/Marslo.vim && tpope/vim-rails
"                 0.0.10 | Marslo | Add function of GetVundle() and GetVim() for git clone automaticlly"
"                 0.0.11 | Marslo | Change repository woainvzu to Marslo
"                 0.0.12 | Marslo | Modification for startup faster
" =============================================================================

" At Menu
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

runtime macros/matchit.vim
behave mswin

let g:ruby_path=$RUBY_BIN
let g:solarized_termcolors=256

" Make vim open faster :help slow-start
" set viminfo='20,<50,s10
" Inspired from https://groups.google.com/forum/#!topic/vim_use/ImK21wi_JXg
" save/restore buffer list, lines saved each register, files marks, search history, command-line history, disable 'hlsearch', 'file marks 0 = NOT stored'
set viminfo=%,\"4,'4,/50,:50,h,f0
set history=50

set diffopt=filler,context:3

" Remove the Welcome interface
" set shortmess=atI

" Set color is 256
if 'xterm-256color' == $TERM
  set t_Co=256
endif

" ====================================== For Property =====================================
" Set mapleader
let mapleader=","
let g:mapleader=","

" set paste
set go+=a

" document format
set fileformat=unix
" :%s/\r\+$//e

" Code format
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
let &termencoding=&encoding

set scrolloff=3

" Vim Bundle
" Get Vundle from: git clone https://github.com/gmarik/vundle.git ~/.vim
set nocompatible
filetype off

" GetVundle() inspired by: http://pastebin.com/embed_iframe.php?i=C9fUE0M3
func! GetVundle()
  " execute 'silent !git clone https://github.com/Marslo/snipmate.vim.git "' . expand('$VIM') . '"'

  let vundleAlreadyExists=1
  if has('win32') || has('win64')
    let vundle_readme=expand('$VIM\bundle\vundle\README.md')
    let vbundle='$VIM\bundle'
    let vvundle=vbundle . '\vundle'
  else
    let vundle_readme=expand('~/.vim/bunle/vundle/README.md')
    let vbundle='~/.vim/bundle'
    let vvundle=vbundle . '/vundle'
  endif

  if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    if isdirectory(expand(vbundle)) == 0
      call mkdir(expand(vbundle), 'p')
    endif
    execute 'silent !git clone https://github.com/gmarik/vundle.git "' . expand(vvundle) . '"'
    let vundleAlreadyExists=0
  endif
endfunc

" Setting runtimepath for Vundle use
if has('win32') || has('win64')
  set rtp+=$VIM/bundle/vundle
  call vundle#rc('$VIM/bundle')
else
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()
endif

" Plugins
Bundle 'gmarik/vundle'
Bundle 'Yggdroot/indentLine'
Bundle 'kien/ctrlp.vim.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'majutsushi/tagbar'
Bundle 'dantezhu/authorinfo'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'plasticboy/vim-markdown.git'
Bundle 'Marslo/EnhCommentify.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'ervandew/supertab'

" snipmate works on windows by using pathogen
Bundle 'Marslo/snipmate.vim.git'

" Get from vim-scripts
Bundle 'Conque-Shell'
Bundle 'mru.vim'
Bundle 'taglist.vim'
Bundle 'winmanager'

" Bundle 'TeTrIs.vim'
" Bundle 'matrix.vim--Yang'

" For Python
" Bundle 'python-mode'
Bundle 'python_fold'
Bundle 'pyflakes.vim'

" For ruby
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
if "ruby" == &filetype
  Bundle 'ruby-matchit'
endif

" Others
" Bundle 'snipMate'
" Bundle 'mattn/emmet-vim'
" Bundle 'Tagbar'
" Bundle 'AuthorInfo'
" Bundle 'colorsupport.vim'
" Bundle 'ruby-matchit'
" Bundle 'hdima/python-syntax.git'
" Bundle 'vantares/ruby-syntaxchecker.vim'
" Bundle 'semmons99/vim-ruby-matchit'
" Bundle 'ap/vim-css-color'

" Colors and themes
Bundle 'txt.vim'
Bundle 'gui2term.py'
Bundle 'colorsel.vim'
Bundle 'JulesWang/css.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Marslo/vim-coloresque'
Bundle 'Marslo/marslo.vim'
Bundle 'Marslo/python-syntax'

filetype plugin indent on

" ====================================== For Programming =====================================
" Open the current file path by cmd
func! OpenCMD()
  if has('win32') || has('win95') || has('win64')
    let com = '!cmd /c start C:\Marslo\Tools\Software\System\CommandLine\Console2\Console.exe -d "'. expand('%:p:h') . '"'
    " let com = '!cmd /c start cd '. expand('%:p:h')
    " let com = '!cmd /c start "C:\Program Files\JPSoft\TCCLE13\tcc.exe" /c "' . expand('%:p:h') .'"'
    " let com = '!cmd /c start C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "Set-Location ' . expand ('%:p:h') . '"'
    if 'java' == &filetype
      let com = '!cmd /c start "C:\Program Files\JPSoft\TCCLE13x64\tcc.exe" /d "' . expand('%:p:h') .'"'
    else
      let com1 = '!cmd /c start C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command '
      let com2 = '"Set-Location ' . "'" . expand ('%:p:h') ."'" . '"'
      " let com = com1 . com2
    endif
  else
    let com = '!/usr/bin/gnome-terminal --working-directory=' . expand('%:p:h')
  endif
  echo 'Goto "' . expand('%:p:h') . '" in command line'
  silent execute com
endfunc
nmap cmd :call OpenCMD()<CR>

func! OpenFoler()
  if has('win32') || has('win95') || has('win64')
    let folderpath = expand('%:p:h')
  endif
  silent execute '!C:\Windows\explorer.exe "' . folderpath . '"'
endfunc
map <M-o> :call OpenFoler()<CR>

" Get vim from: git clone git@github.com:b4winckler/vim.git
func! GetVim()
  if has('unix')
    let vimgitcfg=expand('~/.vim/src/vim/.git/config')
    if !filereadable(vimgitcfg)
      execute 'silent !git clone git@github.com:b4winckler/vim.git "' . expand('~/.vim/vimsrc') . '"'
    end
  endif
endfunc

if "python" == &filetype
  " Run pylint
  func! PylintCheck()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = '"' . expand("%:t") . '"'
    setlocal makeprg=pylint\ --reports=n\ --output-format=parseable
    set efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#
    silent make "%:p"
    copen
    let &makeprg     = mp
    let &errorformat = ef
  endfunc
  nmap <leader>li :call PylintCheck()<CR>
endif

" ====================================== For Programming =====================================
func! CompileRunGpp()
  exec "w"
  exec "!gcc % -o %<"
  exec "! %<"
endfunc

func! RunResult()
  let mp = &makeprg
  let ef = &errorformat
  let exeFile = expand("%:t")
  exec "w"
  if "python" == &filetype
    setlocal makeprg=python\ -u
  elseif "perl" == &filetype
    setlocal makeprg=perl
  elseif "ruby" == &filetype
    setlocal makeprg=ruby
  elseif "autohotkey" == &filetype
    setlocal makeprg=AutoHotkey
  endif
  set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  silent make %
  if "autohotkey" != &filetype
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    copen
  endif
  let &makeprg     = mp
  let &errorformat = ef
endfunc
map <F5> :call RunResult()<CR>

" Automatic Pair
" inoremap ( ()<ESC>i
inoremap <buffer> ( <c-r>=AutoPair('(')<CR>
inoremap <buffer> ) <c-r>=ClosePair(')')<CR>
" inoremap [ []<ESC>i
inoremap <buffer> [ <c-r>=AutoPair('[')<CR>
inoremap <buffer> ] <c-r>=ClosePair(']')<CR>
" inoremap { {<CR>}<ESC>ka<CR>
inoremap <buffer> { <c-r>=AutoPair('{')<CR>
inoremap <buffer> } <c-r>=ClosePair('}')<CR>
inoremap <buffer> % <c-r>=AutoPair('%')<CR>

func! AutoPair(char)
  " let curchar = getline('.')[col('.') - 1]
  let bchar = getline('.')[col('.')]
  if "(" == a:char
    if &filetype =~ '^\(disable_sql\)$'
      return "(\<Enter>);\<Up>\<Enter>"
    elseif '' == bchar
      return "()\<Left>"
    else
      return a:char
    endif
  elseif "[" == a:char
    if '' == bchar
      return "[]\<Left>"
    else
      return a:char
    endif
  elseif "{" == a:char
    if &filetype =~ '^\(java\|perl\)$'
      return "{\<Enter>}\<ESC>ko"
      " return "{\<Enter>}\<Up>\<Enter>"
    elseif '' == bchar && &filetype =~ '^\(ruby\|python\|eruby\|autohotkey\|vim\|snippet\|txt\|scss\)$'
      return "{}\<Left>"
    else
      return a:char
    endif
  elseif "%" == a:char
    if '' == getline('.')[col('.')] && &filetype =~ '^\(autohotkey\)$'
      return "%%\<left>"
    else
      return a:char
    endif
  endif
endfunc

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction

inoremap <buffer> <BS> <c-r>=DeletePairs()<CR>
inoremap <buffer> <C-h> <c-r>=DeletePairs()<CR>

" Delete the pair of parentheses, brackets and braces
function! DeletePairs()
  let curchar = getline('.')[col('.') - 1]
  let prechar = getline('.')[col('.') - 2]

  let AutoPaires = {')': '(',']': '[','}': '{'}
  if has_key(AutoPaires, curchar) && prechar == AutoPaires[curchar]
    return "\<BS>\<DEL>"
  else
    return "\<BS>"
  endif
endfunction

iabbrev <leader>/* /*********************************
iabbrev <leader>*/ *********************************/
iabbrev <leader>#- #------------------
inoremap <leader>tt <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <leader>fe <C-R>=expand("%:t")<CR>

" Add suffix '.py' if the filetype is python
function! GotoFile()
  if 'python' == &filetype
    let com = expand('%:p:h') . '\' . expand('<cfile>') . '.py'
    " elseif 'ruby' == &filetype
    " let com = expand('%:p:h') . '\' . expand('<cfile>')
    " let com = 'C:\Marslo\Job\Summa\TEX\SVN\netact-mpp-lab-scripts\' . expand('<cfile>')
  else
    let com = expand('<cfile>')
  endif
  silent execute ':e ' . com
  echo 'Open file "' . com . '" under the cursor'
endfunction
nmap gf :call GotoFile()<CR>

" Update tags file automatic
set tags=tags;
set autochdir
function! UpdateTags()
  silent !ctags -R --fields=+ianS --extra=+q
endfunction
nmap <F12> :call UpdateTags()<CR>

if has('gui_running')
  " Reduce the font
  function! <SID>FontSize_Reduce()
    if has('unix')
      let pattern = '\<\d\+$'
    elseif has('win32') || has('win95') || has('win64')
      let pattern = ':h\zs\d\+\ze:'
    endif
    let fontsize = matchstr(&gfn, pattern)
    echo fontsize
    let cmd = substitute(&gfn, pattern, string(fontsize - 1), 'g')
    let &gfn=cmd
  endfunction
  nnoremap <A--> :call <SID>FontSize_Reduce()<CR>

  " Enlarge the font
  function! <SID>FontSize_Enlarge()
    if has('unix')
      let pattern = '\<\d\+$'
    elseif has('win32') || has('win95') || has('win64')
      let pattern = ':h\zs\d\+\ze:'
    endif
    let fontsize = matchstr(&gfn, pattern)
    let cmd = substitute(&gfn, pattern, string(fontsize + 1), 'g')
    let &gfn=cmd
  endfunction
  nnoremap <A-+> :call <SID>FontSize_Enlarge()<CR>

  " Show syntax highlighting groups for word under cursor
  function! SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc
endif

" ====================================== For Inteface =====================================
if has('gui_running')
  " The initialize size
  set lines=32
  set columns=108

  " Make vim maximize while it startup
  func! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
  endfunc

  " set go=                                    Hide everything
  " set guioptions+=b                          Add the bottom scroll bar
  set guioptions-=T                           " Hide the tool bar
  set guioptions-=r                           " Hide the side scroll bar
  set guioptions-=m                           " Hide the Menu
  set cpoptions+=n
endif

if has('win32') || has('win95') || has('win64')
  nmap <leader>v :e $VIM/_vimrc<CR>
  " au GUIEnter * simalt ~x                       " Max after start vim
  autocmd! bufwritepost $VIM/_vimrc source %      " autoload _vimrc
  set guifont=Monaco:h12                          " Fonts
  " Copy the content to system clipboard by using y/p
  set clipboard+=unnamed
  set clipboard+=unnamedplus
else
  nmap <leader>v :e ~/.vimrc<CR>
  " au GUIEnter * call MaximizeWindow()
  autocmd! bufwritepost ~/.vimrc source %
  set guifont=Monaco\ 12
  set clipboard=unnamedplus
endif

set nobackup noswapfile nowritebackup

" ruler: Show Line and colum number; number: line number
set ruler number
set report=0

if has('gui_running') || 'xterm-256color' == $TERM
  colorscheme marslo256
  let psc_style='cool'
else
  colorscheme marslo16
endif

syntax enable
syntax on
filetype plugin on

set autoread                                " Set auto read when a file is changed by outside
set showmatch                               " Show matching bracets
set wrap                                    " Wrap lines

" Tab width
" set textwidth=150
set autoindent smartindent
set smarttab expandtab                      " smarttab: the width of <Tab> in first line would refer to 'Shiftwidth' parameter
set tabstop=2                               " Tab width
set softtabstop=2                           " the width while trigger <Tab> key
set shiftwidth=2                            " the tab width by using >> & <<
" autocmd FileType ruby,eruby,yaml,html,css,scss set ai sw=2 sts=2 et
set lbr
set tw=0

" Set status bar
set laststatus=2
set statusline=%m%r
set statusline+=%F\ \ %y,%{&fileformat}\                " file path\file name & filetype
set statusline+=%=                                      " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}   " Current Time
set statusline+=\ \ %b[A],0x%B                          " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L                          " current Column, current Line/All Line
set statusline+=\ \ %p%%\

" At Console
" language messages utf-8
set showcmd                                 " Show (partial) command in status line

au BufRead,BufNewFile * setfiletype txt     " Highlight the txt file
au BufRead,BufNewFile *.t set ft=perl       " Perl test file as Perl code

set modifiable
set write

" Disable <F1> to open help file
noremap <F1> <ESC>
imap <F1> <ESC>a

" Set the Ctrl-K/Ctrl-J switch the Top/Bottom window
map <C-k> <C-w>k
map <C-j> <C-w>j

" Emacs Style shortcuts
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
imap <M-f> <ESC><Space>Wi
imap <M-b> <ESC>Bi
imap <M-d> <ESC>cW

" map <C-c> "+y
" map <C-v> "+p
map gl <CR>

" set path+=/home/marslo/Study

function! FindProjectRoot(lookFor)
  let pathMaker='%:p'
  while(len(expand(pathMaker))>len(expand(pathMaker.':h')))
    let pathMaker=pathMaker.':h'
    let fileToCheck=expand(pathMaker).'/'.a:lookFor
    if filereadable(fileToCheck)||isdirectory(fileToCheck)
      return expand(pathMaker)
    endif
  endwhile
  return 0
endfunction

" CtrlP
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'                " Search parents as well (stop searching sartly)
let g:ctrlp_max_height = 8
let g:ctrlp_max_depth = 100
let g:ctrlp_working_path_mode = 'ra'
let g:ctrl_root_makers = ['.ctrlp']                 " Stop search if these files present
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0                 " Cross session caching
let g:ctrlp_cache_dir = $VIM . '/cache/ctrlp'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll|rpm|tar|gz|bz2|zip|ctags|tags)|tags|ctags$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

" GundoToggle
nnoremap <leader>g :GundoToggle<CR>
let g:gundo_width = 35
let g:gundo_preview_height = 20
let g:gundo_right = 0
let g:gundo_preview_bottom = 0

" ====================================== For Function =====================================
set backspace=indent,eol,start                  " make backspace h, l, etc wrap to
" set whichwrap+=<,>,h,l

" nmap <leader>s :ConqueTermSplit
if has('win32') || has('win95') || has('win64')
  nmap <leader>tv :ConqueTermSplit cmd <CR>
else
  nmap <leader>tv :ConqueTermSplit bash <CR>
endif

nmap zdb :%s/\s\+$//<CR>
nmap zhh :%s/^\s\+//<CR>
nmap zmm :g/^/ s//\=line('.').' '/<CR>
nmap zws :g/^\s*$/d<CR>

set incsearch hlsearch ignorecase smartcase     " Search
set magic                                       " Regular Expression

" WinManager
" let g:AutoOpenWinManager=1
let g:winManagerWidth = 20
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <leader>mm :WMToggle<cr>

" Tlist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_show_Menu=1
let Tlist_sql_settings = 'sql;P:package;t:table'
let Tlist_Process_File_Always=0
" let Tlist_Close_On_Select=1
" let Tlist_Auto_Open=1
" let Tlist_Ctags_Cmd=$VIM . 'vimfiles\ctags58\ctags.exe'
" let updatetime=1000
nmap <leader>tl :TlistToggle<CR>

" Tagbar
map <leader>ta :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=20
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_autoshowtag=1

" Comments
let g:EnhCommentifyAlignRight='Yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='Yes'
let g:EnhCommentifyUseSyntax='Yes'
function! EnhCommentifyCallback(ft)
  if a:ft == 'autohotkey'
    let b:ECcommentOpen = ';'
    let b:ECcommentClose = ''
  endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'
let g:EnhCommentifyAlignRight='Yes'

" AuthorInfo
map <leader>aid :AuthorInfoDetect<CR>
let g:vimrc_author='Marslo'
let g:vimrc_email='marslo.jiao@gmail.com'

" Most Recently Used(MRU)
" let MRU_File=$VIM . 'vimfiles\Data\mru_files.txt'
let MRU_Auto_Close = 1
let MRU_Max_Entries = 10
let MRU_Exclude_Files='^/tmp/.*'
let MRU_Exclude_Files='^/temp/.*'
let MRU_Exclude_Files='^/media/.*'
let MRU_Exclude_Files='^/mnt/.*'
map <C-g> :MRU<CR>

" E21\: Cannot make changes, 'modifiable' is off:     $delete
set linespace=0
set wildmenu
" Completion mode that is used for the character
set wildmode=longest,list,full
set wildignore+=*.swp,*.zip,*.exe

" turn off error beep/flash
set noerrorbells novisualbell
set t_vb=

" set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«,nbsp:·

" Cursor format
set guicursor=a:hor1
set guicursor+=i-r-ci-cr-o:hor2-blinkon0

set cursorline                        " Highlight the current line

" Remember Cursor position in last time, inspired from http://vim.wikia.com/wiki/VimTip80
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  " if has("folding")
  " autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
  " else
  autocmd BufWinEnter * call ResCur()
  " endif
augroup END

" Block comment in vimrc
if 0
  if has("folding")
    function! UnfoldCur()
      if !&foldenable
        return
      endif
      let cl = line(".")
      if cl <= 1
        return
      endif
      let cf  = foldlevel(cl)
      let uf  = foldlevel(cl - 1)
      let min = (cf > uf ? uf : cf)
      if min
        execute "normal!" min . "zo"
        return 1
      endif
    endfunction
  endif
endif

" Rainbow bracket
let g:rbpt_loadcmd_toggle = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
      \ ['Darkblue',    'SeaGreen3'],
      \ ['darkgray',    'DarkOrchid3'],
      \ ['darkgreen',   'firebrick3'],
      \ ['darkcyan',    'RoyalBlue3'],
      \ ['darkred',     'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['brown',       'firebrick3'],
      \ ['gray',        'RoyalBlue3'],
      \ ['black',       'SeaGreen3'],
      \ ['darkmagenta', 'DarkOrchid3'],
      \ ['Darkblue',    'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkcyan',    'SeaGreen3'],
      \ ['darkred',     'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]

" IndentLine
let g:indentLine_color_gui = "#282828"
let g:indentLine_color_term = 8
let g:indentLine_indentLevel = 20
let g:indentLine_showFirstIndentLevel = 1
if has('gui_running') || 'xterm-256color' == $TERM
  let g:indentLine_char = '¦'
elseif has('win32')
  let g:indentLine_char = '|'
endif
" let g:indentLine_loaded = 1

" nnoremap <silent> <C-F6> :let old_reg=@"<CR>:let @"=substitute(expand("%:p"), "/", "\\", "g")<CR>:silent!!cmd /cstart <C-R><C-R>"<CR><CR>:let @"=old_reg<CR>

" Supper Tab
set completeopt=longest,menuone
" let SuperTabDefaultCompletionType = "context"
let SuperTabDefaultCompletionType = '<c-p>'
let SuperTabMappingForward = '<c-p>'
let SuperTabMappingTabLiteral = '<Tab>'
let SuperTabClosePreviewOnPopupClose = 1

" Config for ruby
if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  " autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  " autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif

" vim-ruby
autocmd FileType ruby compiler ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
" let g:ruby_syntaxcheck_map='<F10>'
" autocmd FileType ruby map <F4> :w<CR>:!ruby -c %<CR>

" syntax-python
let python_highlight_all = 1

" Fold
set foldenable                              " Enable Fold
" set foldmethod=manual
set foldcolumn=1
set foldexpr=1                              " Shown line number after fold
set foldlevel=100                           " Not fold while VIM set up
" Load view automatic
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview
set viewoptions=folds

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
