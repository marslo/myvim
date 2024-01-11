" =============================================================================
"      FileName : vimrc.interface
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"       Version : 2.0.1
"    LastChange : 2024-01-10 22:58:58
" =============================================================================

" /**************************************************************
"  _       _             __                     __  _   _
" (_)_ __ | |_ ___ _ __ / _| __ _  ___ ___     / / | |_| |__   ___ _ __ ___   ___
" | | '_ \| __/ _ \ '__| |_ / _` |/ __/ _ \   / /  | __| '_ \ / _ \ '_ ` _ \ / _ \
" | | | | | ||  __/ |  |  _| (_| | (_|  __/  / /   | |_| | | |  __/ | | | | |  __/
" |_|_| |_|\__\___|_|  |_|  \__,_|\___\___| /_/     \__|_| |_|\___|_| |_| |_|\___|
"
" **************************************************************/
if has('gui_running')
  set go=                                                           " hide everything (go = guioptions)
  set cpoptions+=n
  set guifont=Agave\ Nerd\ Font\ Mono:h32
  " set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h26
  " set guifont=Rec\ Mono\ Casual:h24
  " set guifontwide=NSimsun:h16
  set renderoptions=type:directx,renmode:5
  set lines=30                                                      " the initialize size
  set columns=106
endif

if exists( '$TMUX' )         | set term=screen-256color | endif
if 'xterm-256color' == $TERM | set t_Co=256             | endif

if has( 'gui_running' ) || 'xterm-256color' == $TERM
  set background=dark
  let psc_style='cool'

  " colorscheme marslo                                              " marslo
  colorscheme gruvbox                                               " gruvbox

  """ terminal : `:help terminal-info`
  let &t_AB = "\e[48;5;%dm"
  let &t_AF = "\e[38;5;%dm"
  let &t_Co = 256
  set t_Co=256
  "" italic
  let &t_ZH = "\e[3m"
  let &t_ZR = "\e[23m"
else
  set t_Co=8
  set t_Sb=^[[4%dm
  set t_Sf=^[[3%dm
  colorscheme marslo16
endif

"" cursor settings:                                                 " https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
"    block        : 1 -> blinking block        |  2 -> solid block
"    underscore   : 3 -> blinking underscore   |  4 -> solid underscore
"    vertical bar : 5 -> blinking vertical bar |  6 -> solid vertical bar
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=4\x7"                          " INSERT MODE  : solid underscore
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"                          " REPLACE MODE : solid block
  let &t_EI = "\<Esc>]50;CursorShape=3\x7"                          " NORMAL MODE  : blinking underscore
else
  let &t_SI .= "\e[4 q"                                             " SI = INSERT mode
  let &t_SR .= "\e[4 q"                                             " SR = REPLACE mode
  let &t_EI .= "\e[3 q"                                             " EI = NORMAL mode (ELSE)
endif

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
