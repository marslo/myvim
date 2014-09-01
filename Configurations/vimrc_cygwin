set nocompatible
syntax enable on
filetype plugin indent on
let mapleader=","

nmap <leader>v :e ~/.cygwin/.vimrc<CR>
autocmd! bufwritepost ~/.cygwin/.vimrc source %

set nobackup noswapfile nowritebackup
set noerrorbells novisualbell
set incsearch hlsearch ignorecase smartcase
set autoindent smartindent
set smarttab expandtab
set ruler number
set iskeyword+=.
set autochdir
set autoread
set showmatch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set lbr
set tw=0
set laststatus=2
set statusline=%m%r%F\ \ %y,%{&ft}\ %=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")} 
set statusline+=\ \ %b[A],0x%B\ \ %c%V,%l/%L\ \ %p%%\
set showcmd
set modifiable
set write
set magic
set linespace=0
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.swp,*.zip,*.exe
set t_vb=
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«,nbsp:·
set cursorline
set scrolloff=3
set sidescroll=1
set sidescrolloff=5
set imcmdline
set completeopt=longest,menuone
set foldenable
set foldcolumn=1
set foldexpr=1
set foldexpr=100
set viewoptions=folds
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set hidden

noremap <F1> <ESC>
imap <F1> <ESC>a
map ,bd :bd<CR>
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A
inoremap <M-f> <ESC><Space>Wi
inoremap <M-b> <ESC>Bi
inoremap <M-d> <ESC>cW
nnoremap Y y$
nnoremap <Del> "_x
xnoremap <Del> "_d

nmap zdb :%s/\s\+$//<CR>
nmap zhh :%s/^\s\+//<CR>
nmap zmm :g/^/ s//\=line('.').' '/<CR>
nmap zws :g/^\s*$/d<CR>

" marslo256.vim: https://github.com/Marslo/marslo.vim
hi SpecialKey           ctermfg=darkgreen
hi NonText              cterm=NONE          ctermfg=239
hi Directory            ctermfg=63
hi ErrorMsg             cterm=NONE          ctermfg=red         ctermbg=0
hi IncSearch            cterm=NONE          ctermfg=yellow      ctermbg=green
hi Search               cterm=NONE          ctermfg=grey        ctermbg=blue
hi MoreMsg              ctermfg=darkgreen
hi ModeMsg              cterm=NONE          ctermfg=brown
hi Question             ctermfg=green
hi StatusLine           cterm=NONE          ctermfg=darkgray    ctermbg=black
hi StatusLineNC         cterm=NONE
hi VertSplit            cterm=NONE
hi Title                ctermfg=5
hi Visual               cterm=underline     ctermbg=NONE
hi VisualNOS            cterm=underline
hi WarningMsg           ctermfg=yellow      ctermbg=black
hi WildMenu             ctermfg=0           ctermbg=3
hi Folded               ctermfg=darkgrey    ctermbg=NONE
hi FoldColumn           ctermfg=darkgrey    ctermbg=NONE
hi DiffAdd              cterm=NONE          ctermbg=56          ctermfg=255
hi DiffDelete           cterm=NONE          ctermbg=239
hi DiffAdded            ctermbg=93
hi DiffRemoved          ctermbg=129
hi DiffChange           cterm=bold          ctermbg=99          ctermfg=255
hi DiffText             cterm=NONE          ctermbg=196
hi Pmenu                ctermfg=208         ctermbg=NONE
hi PmenuSel             ctermfg=154
hi Identifier           ctermfg=149
hi Cursor               cterm=underline     term=underline
hi MatchParen           cterm=inverse       term=inverse
hi LineNr               ctermfg=239         ctermbg=none
hi CursorLine           cterm=NONE
hi String               ctermfg=82
hi Entity               ctermfg=166
hi Support              ctermfg=202
hi CursorLineNr         ctermbg=NONE        ctermfg=118         term=bold
hi Comment              ctermfg=239
hi Constant             ctermfg=113
"""" Key words (while, if, else, for, in)
hi Statement            ctermfg=red
"""" #! color
hi PreProc              ctermfg=red
"""" classname, <key>, <Groupname> color
hi Type                 ctermfg=106
hi Special              ctermfg=221
hi Underlined           cterm=underline     ctermfg=5
hi Ignore               cterm=NONE          ctermfg=7       ctermfg=darkgrey
hi Error                cterm=NONE          ctermfg=7       ctermbg=1
" HTML
hi htmlTag              ctermfg=244
hi htmlEndTag           ctermfg=244
hi htmlArg              ctermfg=203
hi htmlValue            ctermfg=187
hi htmlTitle            ctermfg=184         ctermbg=NONE
hi htmlTagName          ctermfg=69
hi htmlString           ctermfg=113
" NERDTree
hi treeCWD              ctermfg=180
hi treeClosable         ctermfg=174
hi treeOpenable         ctermfg=150
hi treePart             ctermfg=244
hi treeDirSlash         ctermfg=244
hi treeLink             ctermfg=182

hi Boolean              ctermfg=196
hi Function             ctermfg=105
hi Structure            ctermfg=202
hi Define               ctermfg=179
hi Conditional          ctermfg=190
hi Operator             ctermfg=208

hi rubyIdentifier       ctermfg=9
