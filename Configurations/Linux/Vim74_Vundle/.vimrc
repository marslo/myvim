" =============================================================================
"       FileName: .vimrc
"           Desc:
"         Author: Marslo
"        Created: 2010-10
"        Version: 0.1.11
"     LastChange: 2013-10-25 12:29:19
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
" =============================================================================

" Remove the Welcome interface
" set shortmess=atI

" Set color is 256
if $COLORTERM == 'gnome-terminal'
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
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
set termencoding=utf8
set encoding=utf8
set fileencoding=utf8
let &termencoding=&encoding

" Vim Bundle
" Get Vundle by: git clone https://github.com/gmarik/vundle.git ~/.vim
set nocompatible
filetype off

" Inspired from http://pastebin.com/embed_iframe.php?i=C9fUE0M3
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

if has('win32') || has('win64')
    set rtp+=$VIM/vimfiles/bundle/vundle
    call vundle#rc('$VIM/vimfiles/bundle/')
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
Bundle 'hdima/python-syntax.git'
Bundle 'plasticboy/vim-markdown.git'
Bundle 'Marslo/EnhCommentify.vim'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'Marslo/snipmate.vim.git'

" Get from vim-scripts
Bundle 'Conque-Shell'
Bundle 'mru.vim'
Bundle 'python_fold'
Bundle 'taglist.vim'
Bundle 'TeTrIs.vim'
Bundle 'winmanager'
Bundle 'matrix.vim--Yang'
" Bundle 'pyflakes.vim'
Bundle 'Conque-Shell'
Bundle 'ruby-matchit'

" Others
" Bundle 'snipMate'
" Bundle 'mattn/emmet-vim'
" Bundle 'Tagbar'
" Bundle 'AuthorInfo'

" Colors
Bundle 'txt.vim'
Bundle 'css.vim'
Bundle 'gorodinskiy/vim-coloresque'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Marslo/Marslo.vim'
" Bundle 'ap/vim-css-color'

filetype plugin indent on
nmap <leader>bi :BundleInstall<CR>
nmap <leader>bu :BundleUpdate<CR>

" Get vim by: git clone git@github.com:b4winckler/vim.git
func! GetVim()
if has('unix')
    let vimgitcfg=expand('~/.vim/src/vim/.git/config')
    if !filereadable(vimgitcfg)
        execute 'silent !git clone git@github.com:b4winckler/vim.git "' . expand('~/.vim/vimsrc') . '"'
    end
endif
endfunc

" ====================================== For Programming =====================================
func! RunResult()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    exec "w"
    if &filetype == "Python"
        setlocal makeprg=python\ -u
    elseif &filetype == "perl"
        setlocal makeprg=perl
    elseif &filetype == "ruby"
        setlocal makeprg=ruby
    endif
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    if &ft != "autohotkey"
        set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
        copen
    endif
    let &makeprg     = mp
    let &errorformat = ef
endfunc
map <F5> :call RunResult()<CR>

func! CompileRunGpp()
    exec "w"
    exec "!gcc % -o %<"
    exec "! %<"
endfunc

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


func! AutoPair(char)
    " let curchar = getline('.')[col('.') - 1]
    let bchar = getline('.')[col('.')]
    if "(" == a:char
        if &ft =~ '^\(disable_sql\)$'
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
        if &ft =~ '^\(ruby\|java\|perl\)$'
            return "{\<Enter>}\<ESC>ko"
            " return "{\<Enter>}\<Up>\<Enter>"
        elseif '' == bchar && &ft =~ '^\(python\|autohotkey\|vim\|snippet\|txt\)$'
            return "{}\<Left>"
        else
            return a:char
        endif
    elseif "%" == a:char
        if '' == getline('.')[col('.')] && &ft =~ '^\(autohotkey\)$'
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

" Delete a pair of parentheses, brackets, or braces
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

" Open the current file path by cmd
function! OpenCMD()
    if has('win32')
        " let com = '!cmd /c start C:\Marslo\Tools\Softwares\Data\System\CMD\Console2\Console.exe -d "'. expand('%:p:h') . '"'
        " let com = '!cmd /c start cd '. expand('%:p:h')
        " let com = '!cmd /c start "C:\Program Files\JPSoft\TCCLE13\tcc.exe" /c "' . expand('%:p:h') .'"'
        " let com = '!cmd /c start C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command "Set-Location ' . expand ('%:p:h') . '"'
        if 'java' == &ft
            let com = '!cmd /c start "C:\Program Files\JPSoft\TCCLE13x64\tcc.exe" /d "' . expand('%:p:h') .'"'
        else
            let com1 = '!cmd /c start C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit -Command '
            let com2 = '"Set-Location ' . "'" . expand ('%:p:h') ."'" . '"'
            let com = com1 . com2
        endif
    else
        let com = '!/usr/bin/gnome-terminal --working-directory=' . expand('%:p:h')
    endif
    echo 'Goto "' . expand('%:p:h') . '" in command line'
    silent execute com
endfunction
nmap cmd :call OpenCMD()<CR>

func! OpenFoler()
    if has('win32') || has('win95') || has('win64')
        let folderpath = expand('%:p:h')
    endif
    silent execute '!C:\Windows\explorer.exe "' . folderpath . '"'
endfunc
map <M-o> :call OpenFoler()<CR>

" Add suffix '.py' if the filetype is python
func! GotoFile()
    if 'python' == &ft
        let com = expand('<cfile>') . '.py'
    else
        let com = expand('<cfile>')
    endif
    silent execute ':e ' . com
    echo 'Open file "'. com . '" under the cursor'
endfunc
nmap gf :call GotoFile()<CR>

" Update tags file automatic
set tags=tags;
set autochdir
function! UpdateTagsFile()
    silent !ctags -R --fields=+ianS --extra=+q
endfunction
nmap <F12> :call UpdateTagsFile()<CR>

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

" vnoremap < <gv
" vnoremap > >gv

" ====================================== For Inteface =====================================
" Make vim maximize while it startup
func! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunc

" The initialize size
if has('gui_running')
    set lines=32
    set columns=108
endif

if has('win32')
    " Max after start vim
    " au GUIEnter * simalt ~x
    " autoload —vimrc
    autocmd! bufwritepost $VIM/_vimrc source %
    " Fast Edit vim configuration
    nmap <leader>v :e $VIM/_vimrc<CR>
    " Fonts
    set guifont=Monaco:h12
    set clipboard+=unnamed
    set clipboard+=unnamedplus
else
    " au GUIEnter * call MaximizeWindow()
    autocmd! bufwritepost ~/.vimrc source %
    nmap <leader>v :e ~/.vimrc<CR>
    set guifont=Monaco\ 12
    set clipboard=unnamedplus
endif

set nobackup noswapfile nowritebackup

set number
colorscheme marslo
let psc_style='cool'

" colorscheme desert
syntax enable
syntax on
filetype plugin on

" set go=                                   " Hide everything
" set guioptions+=b                         " Add the bottom scroll bar
set guioptions-=T                           " Hide the tool bar
set guioptions-=r                           " Hide the side scroll bar
set guioptions-=m                           " Hide the Menu
set cpoptions+=n

set autoread                                " Set auto read when a file is changed by outside
set showmatch                               " Show matching bracets

set nowrap                                  " Wrap lines

" Tab width
set tabstop=4
set expandtab
" set textwidth=150
set autoindent
set smartindent
set smarttab                                " the width of <Tab> in first line would refer to 'Shiftwidth' parameter
set softtabstop=4                           " the width while trigger <Tab> key
set shiftwidth=4                            " the tab width by using >> & <<
set lbr
set tw=0
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

set ruler                                   " Show Line and colum number

" Set status bar
set laststatus=2
set statusline=%m%r
set statusline=%f\ \ %y,%{&fileformat}\     " file path\file name & filetype
set statusline+=%=      " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}   " Current Time
set statusline+=\ \ %b[A],0x%B              " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L              " current Column, current Line/All Line
set statusline+=\ \ %p%%\

" At Menu
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" At Console
" language messages utf8
set showcmd                                 " Show (partial) command in status line

" Fold
set foldenable                              "Enable Fold
set foldmethod=manual
set foldcolumn=1
set foldexpr=1                              "Shown line number after fold
set foldlevel=100                           " Not fold while VIM set up
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview
set viewoptions=folds

au BufRead,BufNewFile * setfiletype txt     " Highlight the txt file
au BufRead,BufNewFile *.t set ft=perl       " Perl test file as Perl code

" ====================================== For Function =====================================
set backspace=indent,eol,start              " make backspace h, l, etc wrap to
" set whichwrap+=<,>,h,l

" nmap <leader>s :ConqueTermSplit
if has('win32') || has('win95') || has('win64')
    nmap <leader>tv :ConqueTermSplit cmd <CR>
else
    nmap <leader>tv :ConqueTermSplit bash <CR>
endif

nmap zdb :%s/\s\+$//<CR>                        " Delete the black space in the end of each line
nmap zhh :%s/^\s\+//<CR>
nmap zmm :g/^/ s//\=line('.').' '/<CR>
nmap zws :g/^\s*$/d<CR>                         " Delete white space

set incsearch hlsearch ignorecase smartcase     " Search
set ignorecase

set magic                                       " Regular Expression

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
let g:EnhCommentifyAlignRight='yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='yes'
let g:EnhCommentifyUseSyntax='Yes'
function! EnhCommentifyCallback(ft)
    if a:ft == 'autohotkey'
        let b:ECcommentOpen = ';'
        let b:ECcommentClose = ''
    endif
endfunction
let g:EnhCommentifyCallbackExists = 'Yes'
let g:EnhCommentifyAlignRight='Yes'

" AutoInfo
map <F4> :AuthorInfoDetect<CR>
let g:vimrc_author='Marslo'
let g:vimrc_email='marslo.vida@gmail.com'

" MRU
" let MRU_File=$VIM.'\Data\mru_files.txt'
let MRU_Auto_Close=1
map <C-g> :MRU<CR>
let MRU_Max_Entries=10

" CtrlP
let g:ctrlp_max_height = 8
let g:ctrlp_max_depth = 100
let g:ctrlp_working_path_mode = 'ra'
let g:ctrl_root_makers = ['ctrlp']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_use_caching = 1
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

let g:rbpt_loadcmd_toggle = 1
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
    \ ['brown', 'RoyalBlue3'],
    \ ['Darkblue', 'SeaGreen3'],
    \ ['darkgray', 'DarkOrchid3'],
    \ ['darkgreen', 'firebrick3'],
    \ ['darkcyan', 'RoyalBlue3'],
    \ ['darkred', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown', 'firebrick3'],
    \ ['gray', 'RoyalBlue3'],
    \ ['black', 'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue', 'firebrick3'],
    \ ['darkgreen', 'RoyalBlue3'],
    \ ['darkcyan', 'SeaGreen3'],
    \ ['darkred', 'DarkOrchid3'],
    \ ['red', 'firebrick3'],
    \ ]


set modifiable
set write

" E21\: Cannot make changes, 'modifiable' is off:     $delete
set linespace=0
set wildmenu
" Completion mode that is used for the character
set wildmode=longest,list,full
set wildignore+=*.swp,*.zip,*.exe

" Disable F1
noremap <F1> <ESC>
imap <F1> <ESC>a

map <C-k> <C-w>k
map <C-j> <C-w>j

" Emacs Style shortcuts
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
imap <A-f> <ESC><Space>Wi
imap <A-b> <ESC>Bi
imap <A-d> <ESC>dW

" map <C-c> "+y
" map <C-v> "+p
map gl <CR>

" Cursor format
set guicursor=a:hor10
set guicursor+=i-r-ci-cr-o:hor10-blinkon0
set scrolloff=5
" set cursorline                        " Highlight the current line

" turn off error beep/flash
set noerrorbells novisualbell
set t_vb=

set path+=/home/marslo/Study
hi LineNr guifg=#555555 guibg=background ctermfg=darkgrey ctermbg=none
hi CursorLineNr guifg=#A6E22E guibg=background gui=NONE ctermbg=black ctermfg=lightgreen
" hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white

" IndentLine
let g:indentLine_color_gui = '#282828'
let g:indentLine_color_term = 8
let g:indentLine_indentLevel = 20
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char = '¦'
" let g:indentLine_loaded = 1

set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.

" nnoremap <silent> <C-F6> :let old_reg=@"<CR>:let @"=substitute(expand("%:p"), "/", "\\", "g")<CR>:silent!!cmd /cstart <C-R><C-R>"<CR><CR>:let @"=old_reg<CR>
