" =============================================================================
"       FileName: .vimrc
"           Desc:
"         Author: Marslo
"          Email: li.jiao@tieto.com
"        Created: 2013-10-16 07:19:00
"        Version: 0.0.6
"     LastChange: 2013-10-16 07:19:00
"        History:
"                 0.0.1 | Marslo | init
"                 0.0.4 | Marslo | Add Vim Bundle
"                 0.0.5 | Marslo | Add GetVundle() and GetVim() and the configuration of WinManager
"                 0.0.6 | Marslo | Change repositoy woainvzu to Marslo
" =============================================================================

let &runtimepath=printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)
let s:portable = expand('<sfile>:p:h')
let &runtimepath=printf('%s/.vim,%s/.vim,%s/.vim/after', s:portable, &runtimepath, s:portable)
" let s:portable = '$HOME/Marslo'
" let $runtimepath=~s:portable/.vim,usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/home/auto/.vim/after
set nocompatible

if &term=="xterm"
  set t_Co=8
  set t_Sb=^[[4%dm
  set t_Sf=^[[3%dm
else
    set t_Co=256
endif

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


if has('win32') || has('win64')
    set rtp+=$VIM/vimfiles/bundle/vundle
    call vundle#rc('$VIM/vimfiles/bundle/')
else
    set rtp+=$HOME/Marslo/.vim/bundle/vundle
    call vundle#rc('$HOME/Marslo/.vim/bundle')
endif

" Plugins
Bundle 'gmarik/vundle'
Bundle 'Yggdroot/indentLine'
Bundle 'kien/ctrlp.vim.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'majutsushi/tagbar'
Bundle 'dantezhu/authorinfo'
Bundle 'kien/rainbow_parentheses.vim'
" Bundle 'hdima/python-syntax.git'
Bundle 'plasticboy/vim-markdown.git'
Bundle 'Marslo/EnhCommentify.vim'

Bundle 'tpope/vim-rails'

Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'Marslo/snipmate.vim.git'
Bundle 'vantares/ruby-syntaxchecker.vim'
" Bundle 'vim-ruby/vim-ruby'
" Bundle 'semmons99/vim-ruby-matchit'

" Get from vim-scripts
Bundle 'Conque-Shell'
Bundle 'mru.vim'
Bundle 'python_fold'
" Bundle 'Tagbar'
Bundle 'taglist.vim'
Bundle 'TeTrIs.vim'
Bundle 'winmanager'
Bundle 'matrix.vim--Yang'
Bundle 'pyflakes.vim'
" Bundle 'colorsupport.vim'
" Bundle 'ruby-matchit'

" Colors
Bundle 'txt.vim'
Bundle 'css.vim'
Bundle 'gorodinskiy/vim-coloresque'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Marslo/Marslo.vim'

filetype plugin indent on

nmap <leader>bi :BundleInstall<CR>
nmap <leader>bu :BundleUpdate<CR>
nmap <leader>bi! :BundleInstall!<CR>

" Get vim from: git clone git@github.com:b4winckler/vim.git
func! GetVim()
if has('unix')
    let vimgitcfg=expand('~/Marslo/.vim/src/vim/.git/config')
    if !filereadable(vimgitcfg)
        execute 'silent !git clone git@github.com:b4winckler/vim.git "' . expand('~/Marslo/.vim/vimsrc') . '"'
    end
endif
endfunc

" automatic Pair
inoremap ( <c-r>=AutoPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ <c-r>=AutoPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { <c-r>=AutoPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
" inoremap % <c-r>=AutoPair('%')<CR>

func! AutoPair(char)
    if "(" == a:char
        if &ft =~ '^\(sql\)$'
            return "(\<Enter>);\<Up>\<Enter>"
        elseif '' == getline('.')[col('.')]
            return "()\<Left>"
        else
            return a:char
        endif
    elseif "[" == a:char
        if '' == getline('.')[col('.')]
            return "[]\<Left>"
        else
            return a:char
        endif
    elseif "{" == a:char
        if &ft =~ '^\(java\|perl\)$'
            return "{\<Enter>}\<ESC>ko"
        elseif '' == getline('.')[col('.')] && &ft =~ '^\(ruby\|python\|autohotkey\|vim\|snippet\)$'
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

" Delete the pair of parentheses, brackets and braces
function! DeletePairs()
    let AutoPaires = {')': '(', ']': '[', '}': '{'}
    if has_key(AutoPaires, getline('.')[col('.') - 1]) && getline('.')[col('.') - 2 ] == AutoPaires[getline('.')[col('.') - 1]]
        return "\<BS>\<DEL>"
    else
        return "\<BS>"
    endif
endfunction

iabbrev <leader>/* /*********************************
iabbrev <leader>*/ *********************************/
inoremap <leader>tt <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <leader>fe <C-R>=expand("%:t")<CR>

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

if has('gui_running') || 'xterm-256color' == $TERM
    colorscheme marslo256
    let psc_style='cool'
else
    colorscheme marslo16
endif

" Set mapleader
let mapleader=","
let g:mapleader=","

set encoding=utf-8
set number

" backup files settings
set nobackup noswapfile nowritebackup

syntax enable
syntax on
filetype plugin on

if has('win32')
    autocmd! bufwritepost .vimrc source %
    " Fast Edit vim configuration
    nmap <leader>v :e $VIM/.vimrc<cr>
    " Font
    set guifont=Monaco:h12
else
    autocmd! bufwritepost $HOME/Marslo/.vimrc source %
    nmap ,v :e $HOME/Marslo/.vimrc<CR>
    set guifont=Monaco\ 12
endif

" Hghlight the txt file
au BufRead,BufNewFile * setfiletype txt

" Wrap line
set nowrap

" Show matching bracets
set showmatch

set autoread
set tags=tags

" Search opts
set smarttab expandtab
set magic

" Fomart settings
" the width of <tab> in first line would refer to 'shiftwidth' parameter
set autoindent smartindent cindent
set shiftwidth=4                        " the tab width by using >> & <<
set softtabstop=4                       " the width while trigger <Tab> key
set tabstop=4
set lbr
set tw=0
autocmd FileType ruby,eruby,yaml,html set ai sw=2 sts=2 et

" set cindent
" set textwidth=150

" Mouse Settings
" set mouse=a
" set selection=exclusive
" set selectmode=mouse,key

" Show Line and colum number
set ruler

" Set status bar
set laststatus=2
set statusline=%m%r
set statusline+=%F\ \ %Y,%{&fileformat}\    " file path\filename & filetype
set statusline+=%=                          " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}    " Current time
set statusline+=\ \ %b[A],0x%B              " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L              " Current Column, Current Line/All Line
set statusline+=\ \ %p%%
set showcmd                                 " Show (partial) command in status line

" Fold
set foldenable                              "Enable Fold
set foldmethod=manual
set foldcolumn=1
set foldexpr=1                              "Shown line number after fold
set foldlevel=100                           " Not fold while VIM set up
" Load view automatic
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview
set viewoptions=folds

au BufRead,BufNewFile * setfiletype txt     " Highlight the txt file
au BufRead,BufNewFile *.t set ft=perl       " Perl test file as Perl code

" ====================================== For Function =====================================
" Make backspace key can manage normal indent, eol, start, etc
set backspace=indent,eol,start              " make backspace h, l, etc wrap to
" set whichwrap+=<,>,h,l
" set backspace=2
" set report=0

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
set incsearch hlsearch ignorecase smartcase

" Tagbar
map <leader>ta :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=20
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_autoshowtag=1

" Comments setting
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
map tif :AuthorInfoDetect<CR>
let g:vimrc_author='Marslo'
let g:vimrc_email='li.jiao@tieto.com'

" Most Recently Used(MRU)
map <C-g> :MRU<CR>
let MRU_Auto_Close = 1
let MRU_Max_Entries = 10

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
nmap tl :TlistToggle<CR>

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
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-l> <C-w>l

" Emacs Style shortcuts
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
imap <A-f> <ESC><Space>Wi
imap <A-b> <ESC>Bi
imap <A-d> <ESC>dW
" inoremap <M-b> <ESC>Bi
" inoremap <M-f> <ESC>f<Space>a
" inoremap <M-d> <ESC>cf<Space>

vmap <C-c> "+y
vmap <C-v> "+gP
" Cursor format
set guicursor=a:hor10
set guicursor+=i-r-ci-cr-o:hor10-blinkon0
set scrolloff=3
" set completeopt=longest,menu
set cursorline                        " Highlight the current line
" turn off error beep/flash
set noerrorbells novisualbell
set t_vb=

" set path+=/home/marslo/Study

" IndentLine
let g:indentLine_color_gui = "#282828"
let g:indentLine_color_term = 8
let g:indentLine_indentLevel = 20
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char = '¦'
" let g:indentLine_loaded = 1

set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.