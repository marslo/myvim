" =============================================================================
"       FileName: .vimrc
"           Desc:
"         Author: Marslo
"          Email: li.jiao@tieto.com
"        Created: 2013-10-16 07:19:00
"        Version: 0.0.7
"     LastChange: 2014-01-18 01:59:55
"        History:
"                 0.0.1 | Marslo | init
"                 0.0.4 | Marslo | Add Vim Bundle
"                 0.0.5 | Marslo | Add GetVundle() and GetVim() and the configuration of WinManager
"                 0.0.6 | Marslo | Change repositoy woainvzu to Marslo
"                 0.0.7 | Marslo | Delete redundancy configures
" =============================================================================

let &runtimepath=printf('%s/vimfiles,%s,%s/vimfiles/after', $VIM, $VIMRUNTIME, $VIM)
let s:portable = expand('<sfile>:p:h')
let &runtimepath=printf('%s/.vim,%s/.vim,%s/.vim/after', s:portable, &runtimepath, s:portable)
" let s:portable = '$HOME/Marslo'
" let $runtimepath=~s:portable/.vim,usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/home/auto/.vim/after

set nocompatible
syntax enable on
filetype plugin on
set history=500
set diffopt=filler,context:3
set nowrap                                                        " NoWrap lines
set tags=.\tags

" ====================================== For Property =====================================
let mapleader=","
let g:mapleader=","

" Vim Bundle
set nocompatible
filetype off
set rtp+=$HOME/Marslo/.vim/bundle/vundle
call vundle#rc('$HOME/Marslo/.vim/bundle')

Bundle 'gmarik/vundle'
Bundle 'Yggdroot/indentLine'
Bundle 'kien/ctrlp.vim.git'
Bundle 'sjl/gundo.vim.git'
Bundle 'majutsushi/tagbar'
Bundle 'dantezhu/authorinfo'
Bundle 'Marslo/EnhCommentify.vim'
Bundle 'tpope/vim-pathogen'
Bundle 'gregsexton/MatchTag'
Bundle 'ervandew/supertab'
Bundle 'Marslo/auto-pairs'
Bundle 'Marslo/snipmate.vim.git'
Bundle 'Conque-Shell'
Bundle 'mru.vim'
Bundle 'taglist.vim'
Bundle 'winmanager'
" For Python
" Bundle 'python-mode'
Bundle 'python_fold'
Bundle 'pyflakes.vim'
Bundle 'python_match.vim'
Bundle 'Marslo/python-syntax'
" For ruby
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'ruby-matchit'
" For Javascript
Bundle "pangloss/vim-javascript"
Bundle 'jelera/vim-javascript-syntax'
" For web design
Bundle "tpope/vim-surround"
Bundle 'tpope/vim-repeat'
" Colors and themes and syntax
Bundle 'luochen1990/rainbow'
Bundle 'txt.vim'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'Marslo/vim-coloresque'
Bundle 'Marslo/marslo.vim'
Bundle 'Marslo/MarsloVimOthers'
Bundle 'plasticboy/vim-markdown.git'
filetype plugin indent on

" ====================================== For Programming =====================================
func! GetVundle()                                                   " GetVundle() inspired by: http://pastebin.com/embed_iframe.php?i=C9fUE0M3
  let vundleAlreadyExists=1
  let vundle_readme=expand('~/Marslo/.vim/bunle/vundle/README.md')
  let vbundle='~/Marslo/.vim/bundle'
  let vvundle=vbundle . '/vundle'
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

func! GetVim()                                                      " Get vim from: git clone git@github.com:b4winckler/vim.git
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
  copen
  let &makeprg     = mp
  let &errorformat = ef
endfunc
map <F5> :call RunResult()<CR>

function! GotoFile()                                                " Add suffix '.py' if the filetype is python
  if 'python' == &filetype
    let com = expand('%:p:h') . '\' . expand('<cfile>') . '.py'
  else
    let com = expand('<cfile>')
  endif
  silent execute ':e ' . com
  echo 'Open file "' . com . '" under the cursor'
endfunction
nmap gf :call GotoFile()<CR>

function! UpdateTags()                                              " Update tags file automatic
  silent !ctags -R --fields=+ianS --extra=+q
endfunction
nmap <F12> :call UpdateTags()<CR>

" Programming configs for Ruby and Rails
if has("autocmd")
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
endif
autocmd FileType ruby compiler ruby
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
augroup filetypedetect                                              " Inspired from :h new-filetype
  au BufNewFile,BufRead *.r.erb set filetype=r.ruby
augroup end

" Programming configs for Python
let python_highlight_all = 1                                        " syntax-python
" ====================================== For Inteface =====================================
if 'xterm-256color' == $TERM
  set t_Co=256
else
  set t_Co=8
  set t_Sb=^[[4%dm
  set t_Sf=^[[3%dm
endif

if has('gui_running') || 'xterm-256color' == $TERM
  colorscheme marslo256
  let psc_style='cool'
else
  colorscheme marslo16
endif

autocmd! bufwritepost $HOME/Marslo/.vimrc source %
nmap <leader>v :e $HOME/Marslo/.vimrc<CR>
set guifont=Monaco\ 12
set autochdir
set encoding=utf-8                                                  " Input Chinese (=cp936)
set nobackup noswapfile nowritebackup
set ruler number                                                    " ruler: Show Line and colum number; number: line number
set report=0
set autoread                                                        " Set auto read when a file is changed by outside
set showmatch                                                       " Show matching bracets
set autoindent smartindent
set smarttab expandtab                                              " smarttab: the width of <Tab> in first line would refer to 'Shiftwidth' parameter
set tabstop=2                                                       " Tab width
set softtabstop=2                                                   " the width while trigger <Tab> key
set shiftwidth=2                                                    " the tab width by using >> & <<
set lbr                                                             " LineBreak
set tw=0
set laststatus=2                                                    " Set status bar
set statusline=%m%r
set statusline+=%F\ \ %y,%{&fileformat}\                            " file path\file name & filetype
set statusline+=%=                                                  " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}               " Current Time
set statusline+=\ \ %b[A],0x%B                                      " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L                                      " current Column, current Line/All Line
set statusline+=\ \ %p%%\
set showcmd                                                         " Show (partial) command in status line
set modifiable
set write
set incsearch hlsearch ignorecase smartcase                         " Search
set magic                                                           " Regular Expression
set linespace=0
set wildmenu
set wildmode=longest,list,full                                      " Completion mode that is used for the character
set wildignore+=*.swp,*.zip,*.exe
set noerrorbells novisualbell                                       " turn off error beep/flash
set t_vb=
set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.
set cursorline                                                      " Highlight the current line
set guicursor=a:hor1
set guicursor+=i-r-ci-cr-o:hor2-blinkon0
set scrolloff=3                                                     " Scroll settings
set sidescroll=1
set sidescrolloff=5
set imcmdline                                                       " Fix context menu messing
set completeopt=longest,menuone                                     " Supper Tab
set foldenable                                                      " Enable Fold
set foldcolumn=1
set foldexpr=1                                                      " Shown line number after fold
set foldlevel=100                                                   " Not fold while VIM set up
set viewoptions=folds
set backspace=indent,eol,start                                      " make backspace h, l, etc wrap to
set whichwrap+=<,>,h,l

noremap <F1> <ESC>
imap <F1> <ESC>a
map ,bd :bd<CR>
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-l> <C-w>l
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
inoremap <M-f> <ESC><Space>Wi
inoremap <M-b> <Esc>Bi
inoremap <M-d> <ESC>cW

" ====================================== For Function =====================================
let g:ctrlp_map = '<c-p>'                                           " CtrlP
let g:ctrlp_working_path_mode = 'ra'                                " Search parents as well (stop searching sartly)
let g:ctrlp_max_height = 8
let g:ctrlp_max_depth = 100
let g:ctrl_root_makers = ['.ctrlp']                                 " Stop search if these files present
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0                                 " Cross session caching
if has('win32') || has('win95') || has('win64')
  let g:ctrlp_cache_dir = $VIM . '/cache/ctrlp'
else
  let g:ctrlp_cache_dir = '$HOME/.vim/cache/ctrlp'
endif
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|rpm|tar|gz|bz2|zip|ctags|tags)|tags|ctags$',
    \ 'link': 'some_bad_symbolic_links',
    \ }

nnoremap <leader>g :GundoToggle<CR>
let g:gundo_width = 35
let g:gundo_preview_height = 20
let g:gundo_right = 0
let g:gundo_preview_bottom = 0

if has('win32') || has('win95') || has('win64')
  nmap <leader>tv :ConqueTermSplit cmd <CR>
else
  nmap <leader>tv :ConqueTermSplit bash <CR>
endif

nmap zdb :%s/\s\+$//<CR>
nmap zhh :%s/^\s\+//<CR>
nmap zmm :g/^/ s//\=line('.').' '/<CR>
nmap zws :g/^\s*$/d<CR>

let g:winManagerWidth = 20
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <leader>mm :WMToggle<cr>

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_SingleClick=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_show_Menu=1
let Tlist_sql_settings = 'sql;P:package;t:table'
let Tlist_Process_File_Always=0
nmap <leader>tl :TlistToggle<CR>

map <leader>ta :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=20
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_autoshowtag=1

let g:EnhCommentifyAlignRight='Yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='Yes'
let g:EnhCommentifyUseSyntax='Yes'

map <leader>aid :AuthorInfoDetect<CR>
let g:vimrc_author='Marslo'
let g:vimrc_email='marslo.jiao@gmail.com'

let MRU_Auto_Close = 1                                              " Most Recently Used(MRU)
let MRU_Max_Entries = 10
let MRU_Exclude_Files='^/tmp/.*'
let MRU_Exclude_Files='^/temp/.*'
let MRU_Exclude_Files='^/media/.*'
let MRU_Exclude_Files='^/mnt/.*'
map <C-g> :MRU<CR>

function! ResCur()                                                  " Remember Cursor position in last time, inspired from http://vim.wikia.com/wiki/VimTip80
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

augroup vimrc                                                       " For Folding
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

let g:rainbow_active = 1
let g:rainbow_operators = 1
let g:rainbow_conf = {
\   'guifgs' : ['#6A5ACD', '#B22222', '#C0FF3E', '#EEC900', '#9A32CD', '#EE7600', '#98fb98', '#686868'],
\   'ctermfgs' : 'xterm-256color' == $TERM ? ['141', '196', '112', '208', '129', '166', '85', '237'] : ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta'],
\   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\   'separately': {
\     'css': {
\       'parentheses': [['(',')'], ['\[','\]']],
\     },
\     'scss': {
\       'parentheses': [['(',')'], ['\[','\]']],
\     }
\   }
\}

let g:indentLine_color_gui = "#282828"
let g:indentLine_color_term = 8
let g:indentLine_indentLevel = 20
let g:indentLine_showFirstIndentLevel = 1
if has('gui_running') || 'xterm-256color' == $TERM
  let g:indentLine_char = '¦'
elseif has('win32')
  let g:indentLine_char = '|'
endif

let SuperTabDefaultCompletionType = '<c-p>'
let SuperTabMappingForward = '<c-p>'
let SuperTabMappingTabLiteral = '<Tab>'
let SuperTabClosePreviewOnPopupClose = 1

match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/            " For css3

autocmd BufWinLeave * silent! mkview                                " Load view automatic
autocmd BufWinEnter * silent! loadview
autocmd BufRead,BufNewFile * setfiletype txt                        " Highlight the txt file
autocmd BufRead,BufNewFile *.t set ft=perl                          " Perl test file as Perl code
autocmd FileType javascript syntax clear jsFuncBlock

iabbrev <leader>/* /*********************************
iabbrev <leader>*/ *********************************/
iabbrev <leader>#- #------------------
inoremap <leader>tt <C-R>=strftime("%d/%m/%y %H:%M:%S")<cr>
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
inoremap <leader>fe <C-R>=expand("%:t")<CR>
