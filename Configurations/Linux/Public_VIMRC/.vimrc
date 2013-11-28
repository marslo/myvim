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
" Set mapleader
let mapleader=","
let g:mapleader=","

set encoding=utf-8

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
Bundle 'plasticboy/vim-markdown.git'
Bundle 'Marslo/EnhCommentify.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'ervandew/supertab'
Bundle 'Marslo/snipmate.vim.git'

" Get from vim-scripts
Bundle 'Conque-Shell'
Bundle 'mru.vim'
Bundle 'taglist.vim'
Bundle 'TeTrIs.vim'
Bundle 'winmanager'
Bundle 'matrix.vim--Yang'

" For Python
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

" Bundle 'colorsupport.vim'
" Bundle 'ruby-matchit'
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
" Get vim from: git clone git@github.com:b4winckler/vim.git
func! GetVim()
if has('unix')
    let vimgitcfg=expand('~/Marslo/.vim/src/vim/.git/config')
    if !filereadable(vimgitcfg)
        execute 'silent !git clone git@github.com:b4winckler/vim.git "' . expand('~/Marslo/.vim/vimsrc') . '"'
    end
endif
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
inoremap ( <c-r>=AutoPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ <c-r>=AutoPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { <c-r>=AutoPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
" inoremap % <c-r>=AutoPair('%')<CR>

func! AutoPair(char)
    if "(" == a:char
        if &filetype =~ '^\(sql\)$'
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
        if &filetype =~ '^\(java\|perl\)$'
            return "{\<Enter>}\<ESC>ko"
        elseif '' == getline('.')[col('.')] && &filetype =~ '^\(ruby\|python\|eruby\|autohotkey\|vim\|snippet\|txt\|scss\)$'
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
    let AutoPaires = {')': '(', ']': '[', '}': '{'}
    if has_key(AutoPaires, getline('.')[col('.') - 1]) && getline('.')[col('.') - 2 ] == AutoPaires[getline('.')[col('.') - 1]]
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
" ====================================== For Inteface =====================================
if has('win32') || has('win95') || has('win64')
    autocmd! bufwritepost $VIM/_vimrc source %      " autoload _vimrc
    nmap <leader>v :e $VIM/_vimrc<CR>               " Fast Edit vim configuration
    set guifont=Monaco:h12                          " Fonts
    " Copy the content to system clipboard by using y/p
    set clipboard+=unnamed
    set clipboard+=unnamedplus
else
    autocmd! bufwritepost $HOME/Marslo/.vimrc source %
    nmap <leader>v :e $HOME/Marslo/.vimrc<CR>
    set guifont=Monaco\ 12
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

set nowrap                                  " Wrap lines

set tags=tags

" Search opts
set autoindent smartindent
set smarttab expandtab                      " smarttab: the width of <Tab> in first line would refer to 'Shiftwidth' parameter
set tabstop=4                               " Tab width
set softtabstop=4                           " the width while trigger <Tab> key
set shiftwidth=4                            " the tab width by using >> & <<
autocmd FileType ruby,eruby,yaml,html,css,scss set ai sw=2 sts=2 et
set lbr
set tw=0

" set cindent
" set textwidth=150

" Mouse Settings
" set mouse=a
" set selection=exclusive
" set selectmode=mouse,key

" Set status bar
set laststatus=2
set statusline=%m%r
set statusline+=%f\ \ %y,%{&fileformat}\                " file path\file name & filetype
set statusline+=%=                                      " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}   " Current Time
set statusline+=\ \ %b[A],0x%B                          " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L                          " current Column, current Line/All Line
set statusline+=\ \ %p%%\

set showcmd                                 " Show (partial) command in status line

au BufRead,BufNewFile * setfiletype txt     " Highlight the txt file
au BufRead,BufNewFile *.t set ft=perl       " Perl test file as Perl code

set modifiable
set write

" Disable <F1> to open help file
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
imap <M-f> <ESC><Space>Wi
imap <M-b> <ESC>Bi
imap <M-d> <ESC>cW
" inoremap <M-b> <ESC>Bi
" inoremap <M-f> <ESC>f<Space>a
" inoremap <M-d> <ESC>cf<Space>

" vmap <C-c> "+y
" vmap <C-v> "+gP

" set path+=/home/marslo/Study

" CtrlP
" let g:ctrlp_map = '<s-w>'
" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'
" let g:ctrlp_working_path_mode = '.ctrlp'
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

" ====================================== For Function =====================================
" Make backspace key can manage normal indent, eol, start, etc
set backspace=indent,eol,start                  " make backspace h, l, etc wrap to
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
let g:vimrc_email='li.jiao@tieto.com'

" Most Recently Used(MRU)
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

set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.

" Cursor format
set guicursor=a:hor1
set guicursor+=i-r-ci-cr-o:hor2-blinkon0

set cursorline                        " Highlight the current line

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
else
    let g:indentLine_char = '|'
endif
" let g:indentLine_loaded = 1


set completeopt=longest,menuone
" Supper Tab
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
