" =============================================================================
"      FileName : vimrc.settings
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"    LastChange : 2024-01-10 21:53:41
" =============================================================================

" /**************************************************************
"           _   _   _
"  ___  ___| |_| |_(_)_ __   __ _
" / __|/ _ \ __| __| | '_ \ / _` |
" \__ \  __/ |_| |_| | | | | (_| |
" |___/\___|\__|\__|_|_| |_|\__, |
"                           |___/
"
" **************************************************************/
set mouse=c
set mousemodel=popup_setpos
set fileformat=unix
set fileformats=unix
set nowrap                                                          " no wrap lines
set tags=tags
set updatetime=300
set maxmempattern=5000
set history=1000
set diffopt=filler,context:3
set spell spelllang=en_us
set spellcapcheck=1
set spellfile=~/.vim/spell/en.utf-8.add
set lazyredraw
set ttimeout
set ttimeoutlen=1
set ttyfast                                                         " enable fast terminal connection.
set clipboard+=unnamed                                              " copy the content to system clipboard by using y/p
set clipboard+=unnamedplus
set iskeyword-=.
set autochdir
set encoding=utf-8                                                  " input chinese (=cp936)
set termencoding=utf-8
let &termencoding=&encoding
set fileencoding=utf-8
set fileencodings=utf-8,latin1,ucs-bom,gbk,cp936,gb2312,gb18030     " code format
set selection=exclusive                                             " mouse settings
set selectmode=mouse,key
set nobackup noswapfile nowritebackup noundofile noendofline nobuflisted
set number                                                          " line number
set report=0
set autoread                                                        " set auto read when a file is changed by outside
set showmatch                                                       " show matching bracets (shortly jump to the other bracets)
set matchtime=1                                                     " the shortly time
set tabstop=2                                                       " tab width
set softtabstop=2                                                   " width for backspace
set shiftwidth=2                                                    " the tab width by using >> & <<
set autoindent smartindent expandtab
set cindent
set cinoptions=(0,u0,U0
set smarttab                                                        " smarttab: the width of <Tab> in first line would refer to 'shiftwidth' parameter
set linebreak
set modifiable
set write
set incsearch hlsearch ignorecase smartcase                         " search
set magic                                                           " regular expression
set linespace=0
set wildmenu
set wildmode=longest,list,full                                      " completion mode that is used for the character
set noerrorbells novisualbell visualbell                            " ╮ turn off
set belloff=all                                                     " ├ beep/flash
set t_vb=                                                           " ╯ error beep/flash
" set list listchars=tab:\→\ ,tab:▸,trail:·,extends:»,precedes:«,nbsp:·,eol:¬
set list
set listchars=tab:\→\ ,trail:·,extends:»,precedes:«,nbsp:·
set cursorline                                                      " highlight the current line
set cursorcolumn
set guicursor=a:hor10-Cursor-blinkon0
set guicursor+=i-r-c-ci-cr-o:hor10-iCursor-blinkon0
set guicursor+=n:hor10-Cursor-blinkwait700-blinkon400-blinkoff250
set guicursor+=v-ve:block-Cursor
set virtualedit=onemore                                             " allow for cursor beyond last character
set scrolloff=3                                                     " scroll settings
set sidescroll=1
set sidescrolloff=5
set imcmdline                                                       " fix context menu messing
set complete+=kspell
set completeopt=longest,menuone                                     " supper tab
set foldenable                                                      " enable fold
set foldcolumn=1
set foldexpr=1                                                      " shown line number after fold
set foldlevel=100                                                   " not fold while vim set up
set shortmess+=filmnrxoOtTc                                         " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds
set backspace=indent,eol,start                                      " make backspace h, l, etc wrap to
set whichwrap+=<,>,h,l
set go+=a                                                           " visual selection automatically copied to the clipboard
set hidden                                                          " switch between buffers with unsaved change
set equalalways
set formatoptions=tcrqn
set formatoptions+=rnmMB                                            " remove the backspace for combine lines (only for chinese)
set matchpairs+=<:>
set thesaurus+=~/.vim/spell/dictionary/thesaurii.txt                " ╮
set thesaurus+=~/.vim/spell/dictionary/mthesaur.txt                 " ├ spell and grammars
set dictionary=/usr/share/dict/words                                " ╯
" set autowrite
if has('cmdline_info')
  set ruler                                                         " ruler: show line and column number
  set showcmd                                                       " show (partial) command in status line
endif
set laststatus=2                                                    " set status bar
" set synmaxcol=128
" set binary
set exrc
set secure

if has('persistent_undo') | set noundofile            | endif
if version > 74399        | set cryptmethod=blowfish2 | endif

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
