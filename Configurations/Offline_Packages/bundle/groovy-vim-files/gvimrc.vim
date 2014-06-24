" Configure GUI
set guitablabel=%N.\ %t
set showtabline=2
set guioptions-=T
set guioptions-=F
set guioptions-=m
set guioptions+=a
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)
set winminheight=0

" Color settings
color railscasts

" Load common settings
source ~/.vim/config/config.vim
