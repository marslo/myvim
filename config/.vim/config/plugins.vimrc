" =============================================================================
"      FileName : vimrc.plugins
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"    LastChange : 2024-01-10 21:53:41
" =============================================================================

" /**************************************************************
"                                  _
"  _ __  _ __ ___  _ __   ___ _ __| |_ _   _
" | '_ \| '__/ _ \| '_ \ / _ \ '__| __| | | |
" | |_) | | | (_) | |_) |  __/ |  | |_| |_| |
" | .__/|_|  \___/| .__/ \___|_|   \__|\__, |
" |_|             |_|                  |___/
"
" **************************************************************/
let pluginHome     = expand( '~/.vim/plugged' ) . '/'
let mapleader      = ','
let g:mapleader    = ','
let maplocalleader = '\\'
let g:plug_shallow = 0

filetype off
set runtimepath+=~/.vim/plugged
set runtimepath+=~/.vim/plugged/YouCompleteMe
set runtimepath+=/usr/local/opt/fzf                                         " $ brew install fzf
call plug#begin( '~/.vim/plugged' )

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'Yggdroot/indentLine'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sjl/gundo.vim'
Plug 'preservim/tagbar'
Plug 'marslo/vim-devicons', { 'branch': 'sandbox/marslo' }
Plug 'marslo/authorinfo'
Plug 'LunarWatcher/auto-pairs', { 'branch': 'develop' }
Plug 'tomtom/tlib_vim'
Plug 'yegappan/mru'
Plug 'fracpete/vim-large-files'
Plug 'Konfekt/FastFold'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vim-autoformat/vim-autoformat'
Plug 'mbbill/undotree'
Plug 'marslo/MarsloFunc'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --all' }
Plug 'ycm-core/lsp-examples',  { 'do': 'python3 install.py --all' }
Plug 'tpope/vim-commentary'
Plug 'preservim/vim-markdown'                                       " markdown
Plug 'valloric/MatchTagAlways'                                      " web design
Plug 'tpope/vim-fugitive'                                           " ╮
Plug 'airblade/vim-gitgutter'                                       " │
Plug 'APZelos/blamer.nvim'                                          " ├ git
Plug 'tpope/vim-git'                                                " │
Plug 'junegunn/gv.vim'                                              " │
Plug 'zivyangll/git-blame.vim'                                      " ╯
Plug 'pearofducks/ansible-vim'
Plug 'morhetz/gruvbox'                                              " theme
Plug 'luochen1990/rainbow'                                          " ╮ color
Plug 'marslo/vim-coloresque'                                        " ╯ 'ap/vim-css-color'
Plug 'amadeus/vim-css'
Plug 'stephpy/vim-yaml'                                             " ╮
Plug 'pedrohdz/vim-yaml-folds'                                      " ├ yaml
Plug 'dense-analysis/ale'                                           " ╯
Plug 'modille/groovy.vim'                                           " /usr/local/vim/share/vim/vim90/syntax/groovy.vim
Plug 'vim-scripts/vim-gradle'
Plug 'marslo/Jenkinsfile-vim-syntax'                                " jenkinfile
Plug 'ekalinin/Dockerfile.vim'                                      " dockerfile
Plug 'rizzatti/dash.vim'
" Plug 'ap/vim-css-color'                                           " cause issue in groovy.vim
" Plug 'parkr/vim-jekyll'                                           " github page

call plug#end()
call pathogen#infect( '~/.vim/plugged/{}' )
call pathogen#helptags()
filetype plugin indent on
syntax enable on

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
