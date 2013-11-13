" =============================================================================
" #     FileName: .vimrc
" #         Desc: 
" #       Author: Marslo
" #        Email: marslo.vida@gmail.com
" #      Version: 0.0.2
" #   LastChange: 2013-10-17 19:54:45
" #      History:
" =============================================================================

set encoding=utf-8
set number

" backup files settings
set nobackup
set noswapfile
set nowritebackup

syntax enable
syntax on
filetype plugin on

set clipboard+=unnamed
set clipboard+=unnamedplus

if has('gui_running')
    set lines=36
    set columns=108
endif

" Set mapleader
let mapleader=","
let g:mapleader=","

" colorscheme desert_Marslo_ForLinux_v2
" colorscheme desert_Marslo_ForLinux_v4

if has('gui_running') || 'xterm-256color' == $TERM
    colorscheme marslo256
    let psc_style='cool'
else
    colorscheme marslo16
endif

if has('win32')
    autocmd! bufwritepost .vimrc source %
    " Fast Edit vim configuration
    nmap <leader>v :e $VIM/.vimrc<CR>
    " Font
    set guifont=Monaco:h12
else
    autocmd! bufwritepost ~/.vimrc source %
    nmap <leader>v :e ~/.vimrc<CR>
    set guifont=Monaco\ 12
    set clipboard=unnamedplus
endif

" Hide the tool bar
set guioptions-=T
set guioptions-=m
" set guioptions+=b

" Hghlight the txt file
au BufRead,BufNewFile * setfiletype txt


" Wrap line
set wrap

" Make backspace key can manage normal indent, eol, start, etc 
set backspace=indent,eol,start
" set backspace=2

set report=0

" Show matching bracets
set showmatch

set autoread

" Search opts
set incsearch
set hlsearch
set ignorecase

" Fomart settings
set tabstop=4
set expandtab
set textwidth=150
set autoindent
set smartindent
set smarttab
" the width of <tab> in first line would refer to 'shiftwidth' parameter
" the tab width by using >> & <<
set shiftwidth=4
" the width while trigger <Tab> key
set softtabstop=4
" set cindent
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et

set lbr
set tw=0

" if &term=="xterm"
    " set t_Co=8
    " set t_Sb=^[[4%dm
    " set t_Sf=^[[3%dm
" endif

" Mouse Settings
" set mouse=a
" set selection=exclusive
" set selectmode=mouse,key
set scrolloff=3

nmap <F1> <ESC>
imap <F1> <ESC>

map <C-a> <ESC>^
imap <C-a> <ESC>I
map <C-e> <ESC>$
imap <C-e> <ESC>A


" Show Line and colum number
set ruler

" Set status bar
set laststatus=2
set statusline=%m%r
set statusline+=%F\ \ %Y,%{&fileformat}\    " file path\fielname & filetype
set statusline+=%=                          " right align
set statusline+=\ \ %-{strftime(\"%H:%M\ %d/%m/%Y\")}    " Current time
set statusline+=\ \ %b[A],0x%B              " ASCII code, Hex mode
set statusline+=\ \ %c%V,%l/%L              " Current Column, Current Line/All Line
set statusline+=\ \ %p%%
" Show (Partial) command in status line
set showcmd

" Tagbar
map tt :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=20
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+', '-']
let g:tagbar_autoshowtag=1

" Comments setting
" nmap <silent> <C-Q> ,x
let g:EnhCommentifyAlignRight='Yes'
let g:EnhCommentifyRespectIndent='yes'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyMultiPartBlocks='Yes'
let g:EnhCommentifyUseSyntax='Yes'

" AuthorInfo
let g:vimrc_author='Marslo'
let g:vimrc_email='li.jiao@tieto.com'
map tif :AuthorInfoDetect<CR>

" ConqueTerm
nmap <leader>s :ConqueTermSplit
map tn :ConqueTermSplit bash<CR>

" Most Recently Used(MRU)
map <C-g> :MRU<CR>
let MRU_Auto_Close = 1
let MRU_Max_Entries = 10

" Highlight the current line
set cursorline
" highlight CursorLine guibg=lightblue ctermbg=lightgray
" set cursorcolumn


" Fold
set foldenable "Enable Fold
set foldmethod=manual
set foldcolumn=1
set foldexpr=1 "Shown line number after fold
" Not fold while VIM set up
set foldlevel=100
" Load view automatic
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
set modifiable
set write
set viewoptions=folds

" automatic Pair
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {<CR>}<ESC>ka<CR>

inoremap ( <c-r>=AutoPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ <c-r>=AutoPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { <c-r>=AutoPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap % <c-r>=AutoPair('%')<CR>

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
        elseif '' == getline('.')[col('.')] && &ft =~ '^\(ruby\|eruby\|python\|autohotkey\|vim\|snippet\)$'
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
    let AutoPaires = {')': '(',']': '[','}': '{'}
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

" Cursor format
set guicursor=a:hor10
set guicursor+=i-r-ci-cr-o:hor10-blinkon0


" turn off error beep/flash
set noerrorbells
set novisualbell
set t_vb=


vmap <C-c> "+y
vmap <C-v> "+gP

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" set completeopt=longest,menu

" set cursorline
set list listchars=tab:\ \ ,trail:.,extends:>,precedes:<,nbsp:.
