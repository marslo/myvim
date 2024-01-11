" =============================================================================
"      FileName : vimrc.cmds
"        Author : marslo.jiao@gmail.com
"       Created : 2010-10
"    LastChange : 2024-01-10 21:53:41
" =============================================================================

" /**************************************************************
"        _             _                  _   _   _
"  _ __ | |_   _  __ _(_)_ __    ___  ___| |_| |_(_)_ __   __ _ ___
" | '_ \| | | | |/ _` | | '_ \  / __|/ _ \ __| __| | '_ \ / _` / __|
" | |_) | | |_| | (_| | | | | | \__ \  __/ |_| |_| | | | | (_| \__ \
" | .__/|_|\__,_|\__, |_|_| |_| |___/\___|\__|\__|_|_| |_|\__, |___/
" |_|            |___/                                    |___/
"
" **************************************************************/
nnoremap <leader>tb :TagbarToggle<CR>
let g:tagbar_width       = 30
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package:1',
        \ 'c:classes',
        \ 'i:interfaces',
        \ 't:traits',
        \ 'e:enums',
        \ 'm:methods',
        \ 'd:def',
        \ 'f:fields:1'
    \ ]
\ }

" tpope/vim-commentary
map  <C-/>     gcc
map  <leader>x gcc
imap <C-/>     <Esc><Plug>CommentaryLineA
xmap <C-/>     <Plug>Commentary

noremap <leader>aid :AuthorInfoDetect<CR>
let g:vimrc_author = 'marslo'
let g:vimrc_email  = 'marslo.jiao@gmail.com'

" most recently used(mru)
noremap <leader>re :MRU<CR>
let MRU_Auto_Close    = 1
let MRU_Max_Entries   = 10
let MRU_Exclude_Files = '^/tmp/.*\|^/temp/.*\|^/media/.*\|^/mnt/.*\|^/private/.*'

noremap <Leader>u :GundoToggle<CR>
set undodir=~/.vim/undo/
set undofile

" luochen1990/rainbow
" for i in '75' '147' '108' '196' '208' '66' '106' '172' '115' '129'; do echo -e "\e[38;05;${i}m${i}"; done | column -c 250 -s ' '; echo -e "\e[m"
let g:rainbow_active    = 1
let g:rainbow_operators = 1
let g:rainbow_conf      = {
\   'guifgs' : [ '#6A5ACD', '#ff6347', '#b58900', '#9acd32', '#EEC900', '#9A32CD', '#EE7600', '#268bd2', '#183172' ],
\   'ctermfgs' : 'xterm-256color' == $TERM ? [ '75', '147', '108', '196', '208', '66', '106', '172', '115', '129' ] : [ 'lightblue', 'lightgreen', 'yellow', 'red', 'magenta' ],
\   'parentheses': [ ['(',')'], ['\[','\]'], ['{','}'] ],
\   'separately': {
\     '*': {},
\     'markdown': {
\       'parentheses_options': 'containedin=markdownCode contained',
\     },
\     'css': {
\       'parentheses': [ ['(',')'], ['\[','\]'] ],
\     },
\     'scss': {
\       'parentheses': [ ['(',')'], ['\[','\]'] ],
\     },
\     'html': {
\       'parentheses': [ ['(',')'], ['\[','\]'], ['{','}'] ],
\     },
\     'stylus': {
\       'parentheses': [ 'start=/{/ end=/}/ fold contains=@colorableGroup' ],
\     }
\   }
\}

" Yggdroot/indentLine
let g:indentLine_enabled              = 1
let g:indentLine_color_gui            = "#282828"
let g:indentLine_color_term           = 239
let g:indentLine_indentLevel          = 20
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_tty            = 0
let g:indentLine_faster               = 1
let g:indentLine_concealcursor        = 'inc'
let g:indentLine_conceallevel         = 2
let g:indentLine_char                 = '¦'

" LunarWatcher/auto-pairs
let g:AutoPairs                             = autopairs#AutoPairsDefine({ '<': '>' })
let g:AutoPairsMapBS                        = 1
let g:AutoPairsFlyMode                      = 0
let g:AutoPairsCompleteOnlyOnSpace          = 1
let g:AutoPairsNoJump                       = 0
let g:AutoPairsSpaceCompletionRegex         = '\w'
" let g:AutoPairsJumpBlacklist              = [ '<', '>' ]
" to avoid impact with ctrl-p ( :Files )
let g:AutoPairsShortcutToggleMultilineClose = 0
let g:AutoPairsShortcutBackInsert           = '<M-b>'
let g:AutoPairsPrefix                       = '<M-j>'
let g:AutoPairsShortcutJump                 = '<M-n>'
let g:AutoPairsShortcutToggle               = '<M-j>'

" vim-airline/vim-airline
let g:airline_powerline_fonts                      = 1
let g:airline_highlighting_cache                   = 1
let g:airline_detect_spelllang                     = 0              " disable spelling language
let g:airline_exclude_preview                      = 0              " disable in preview window
let g:airline_theme                                = 'base16_embers'" 'apprentice', 'base16', 'gruvbox', 'zenburn', 'base16_atelierheath'
let g:Powerline_symbols                            = 'fancy'
let g:airline_section_y                            = ''             " fileencoding
let g:airline_section_x                            = ''
let g:airline_section_z                            = "%3p%% %l/%L:%c [%B]"
let g:airline_skip_empty_sections                  = 1
let g:airline_detect_modified                      = 1
let g:airline_detect_paste                         = 1
let g:airline#extensions#wordcount#enabled         = 1
let g:airline#extensions#wordcount#filetypes       = '\vtext|nroff|plaintex'
let g:airline#extensions#quickfix#enabled          = 0
let g:airline#extensions#quickfix#quickfix_text    = 'Quickfix'
let g:airline_stl_path_style                       = 'short'
let g:airline#extensions#tabline#enabled           = 1              " ╮ enable airline tabline
let g:airline#extensions#tabline#fnamemod          = ':t'           " │
let g:airline#extensions#tabline#show_close_button = 0              " │ remove 'X' at the end of the tabline
let g:airline#extensions#tabline#show_buffers      = 1              " │
let g:airline#extensions#tabline#show_splits       = 0              " │ disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#tab_min_count     = 2              " │ minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_tabs         = 0              " │
let g:airline#extensions#tabline#tab_nr_type       = 1              " ╯ tab number
let g:airline#extensions#branch#format             = 2
let g:airline#extensions#ale#enabled               = 1              " ╮
let airline#extensions#ale#error_symbol            = ' ᓆ :'         " │
let airline#extensions#ale#warning_symbol          = ' ᣍ :'         " ├ ale
let airline#extensions#ale#show_line_numbers       = 1              " │
let airline#extensions#ale#open_lnum_symbol        = '(␊:'          " │
let airline#extensions#ale#close_lnum_symbol       = ')'            " ╯
let g:airline_mode_map                             = { '__': '-', 'n' : 'N', 'i' : 'I', 'R' : 'R', 'c' : 'C', 'v' : 'V', 'V' : 'V', '': 'V', 's' : 'S', 'S' : 'S', '': 'S', }
if !exists('g:airline_symbols') | let g:airline_symbols = {} | endif
let g:airline_symbols.dirty                        = ' ♪'
let g:airline_left_sep                             = ''
let g:airline_right_sep                            = ''
function! AirlineInit()
  let g:airline_section_a = airline#section#create([ '[', 'mode', ']' ])
  let g:airline_section_y = airline#section#create([ '%{strftime("%H:%M %b-%d %a")} ', '['.&ff.']' ])
  let g:airline_section_c = '%<' . airline#section#create([ '%F' ]) " let g:airline_section_c = '%<' . '%{expand(%:p:~)}'
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" preservim/vim-markdown
let g:vim_markdown_toc_autofit          = 1
let g:vim_markdown_conceal              = 0
let g:vim_markdown_conceal_code_blocks  = 0
let g:vim_markdown_strikethrough        = 1
let g:vim_markdown_folding_disabled     = 1                         " =1 to disable folding
let g:vim_markdown_new_list_item_indent = 2

" dhruvasagar/vim-table-mode
noremap <Leader>tm :TableModeToggle<CR>
let g:table_mode_corner          = '|'
let g:table_mode_header_fillchar = '-'
let g:table_mode_align_char      = ":"
let g:table_mode_corner          = "|"
let g:table_mode_align_char      = ":"

" godlygeek/tabular
if exists( ":Tabularize" )
  noremap  <Leader>a= :Tabularize /=<CR>
  vnoremap <Leader>a= :Tabularize /=<CR>
  noremap  <leader>a: :Tabularize /:\zs<CR>
  vnoremap <leader>a: :Tabularize /:\zs<CR>
  inoremap <silent> <Bar>   <Bar><Esc>:call <SID>table_auto_align()<CR>
endif

" git
nnoremap <leader>mp  :execute 'silent !git mp' \| redraw!<CR>
" zivyangll/git-blame.vim
nnoremap <Leader>ebb :<C-u>call gitblame#echo()<CR>
" APZelos/blamer.nvim
nnoremap <Leader>bb  :BlamerToggle<CR>
let g:blamer_enabled              = 0
let g:blamer_delay                = 100
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_relative_time        = 1
" let g:blamer_prefix             = ' » '

" airblade/vim-gitgutter
set updatetime=250
set signcolumn=yes
let g:gitgutter_git_executable = '/usr/local/bin/git'
let g:gitgutter_enabled        = 1
let g:gitgutter_realtime       = 0
let g:gitgutter_eager          = 0
highlight clear SignColumn

" ycm-core/YouCompleteMe
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>go :YcmCompleter GoToInclude<cr>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmDiags<CR>
let g:ycm_extra_conf_globlist                      = [ '~/.marslo/ycm/*', '~/.vim/plugged/YouCompleteMe/*' ]
let g:ycm_key_invoke_completion                    = '<C-\>'
let g:ycm_echo_current_diagnostic                  = 0
let g:ycm_error_symbol                             = '✗'
let g:ycm_warning_symbol                           = '✹'
let g:ycm_update_diagnostics_in_insert_mode        = 0
let g:ycm_seed_identifiers_with_syntax             = 1
let g:ycm_complete_in_comments                     = 1
let g:ycm_complete_in_strings                      = 1
let g:ycm_collect_identifiers_from_tags_files      = 1
let g:ycm_keep_logfiles                            = 1
let g:ycm_log_level                                = 'debug'
let g:ycm_show_detailed_diag_in_popup              = 1
let g:ycm_filepath_completion_use_working_dir      = 1
let g:ycm_min_num_of_chars_for_completion          = 1
let g:ycm_complete_in_comments                     = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_filetype_whitelist                       = { '*': 1, 'ycm_nofiletype': 1 }
let g:ycm_filetype_specific_completion_to_disable  = { 'gitcommit': 1, 'vim': 1 }
let g:ycm_filetype_blacklist                       = {
  \   'tagbar'  : 1,
  \   'notes'   : 1,
  \   'netrw'   : 1,
  \   'unite'   : 1,
  \   'vimwiki' : 1,
  \   'infolog' : 1,
  \   'leaderf' : 1,
  \   'mail'    : 1,
  \   'help'    : 1,
  \   'undo'    : 1
  \ }
let g:ycm_semantic_triggers                        =  {
  \   'c'         : [ '->', '.' ],
  \   'objc'      : [ '->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s' ],
  \   'ocaml'     : [ '.', '#' ],
  \   'cpp,cuda,objcpp' : [ '->', '.', '::' ],
  \   'perl'      : [ '->' ],
  \   'php'       : [ '->', '::' ],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': [ '.' ],
  \   'ruby,rust' : [ '.', '::' ],
  \   'lua'       : [ '.', ':' ],
  \   'erlang'    : [ ':' ],
  \ }
augroup YCMCustomized
  autocmd!
  autocmd FileType c,cpp,sh,python,groovy,Jenkinsfile let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype,
    \ 'popup_params': {
    \     'maxwidth': 80,
    \     'border': [],
    \     'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
    \   },
    \ }
augroup END

" ycm-core/lsp-examples
let g:ycm_lsp_dir = expand( pluginHome . 'lsp-examples' )
let s:pip_os_dir  = 'bin'
if has( 'win32' ) | let s:pip_os_dir = 'Scripts' | end
source $HOME/.vim/plugged/lsp-examples/vimrc.generated

" Konfekt/FastFold
nnoremap zuz <Plug>(FastFoldUpdate)
xnoremap <silent> <leader>iz :<c-u>FastFoldUpdate<cr>]z<up>$v[z<down>^
xnoremap <silent> <leader>az :<c-u>FastFoldUpdate<cr>]zV[z
let g:fastfold_savehook               = 1
let g:fastfold_fold_command_suffixes  = ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:markdown_folding                = 1
let g:rst_fold_enabled                = 1
let g:tex_fold_enabled                = 1
let g:vimsyn_folding                  = 'af'
let g:xml_syntax_folding              = 1
let g:javaScript_fold                 = 1
let g:sh_fold_enabled                 = 7
let g:zsh_fold_enable                 = 1
let g:ruby_fold                       = 1
let g:perl_fold                       = 1
let g:perl_fold_blocks                = 1
let g:r_syntax_folding                = 1
let g:rust_fold                       = 1
let g:php_folding                     = 1
let g:fortran_fold                    = 1
let g:clojure_fold                    = 1
let g:baan_fold                       = 1

" vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=\ %* |
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list            = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_check_on_wq              = 0
let g:syntastic_loc_list_height          = 2
let g:syntastic_ignore_files             = ['\.py$']
let g:syntastic_html_tidy_ignore_errors  = [" proprietary attribute \"ng-"]
let g:syntastic_enable_signs             = 1
let g:syntastic_info_symbol              = 'ϊ'                      " ࠵ ೲ
let g:syntastic_error_symbol             = '✗'                      " ஓ ௐ ྾
let g:syntastic_warning_symbol           = '⍨'                      " ᓆ ᓍ 𐘿
let g:syntastic_style_error_symbol       = '⍥'
let g:syntastic_style_warning_symbol     = 'ఠ'                      " ⍤ ൠ
highlight link SyntasticErrorSign        Error
highlight link SyntasticWarningSign      GruvboxYellow
highlight link SyntasticStyleErrorSign   GruvboxRedSign
highlight link SyntasticStyleWarningSign GruvboxPurpleSign

" pedrohdz/vim-yaml-folds                                           " brew install yamllint; pipx install yamllint
set foldlevelstart=20

" dense-analysis/ale                                                " :help g:ale_echo_msg_format
let g:ale_virtualtext_prefix              = '%comment% %type% [%code%]: '
let g:ale_echo_msg_format                 = '[%linter%] %code%: %s [%severity%] '
let g:ale_echo_msg_error_str              = 'Error'
let g:ale_echo_msg_warning_str            = 'Warning'
let g:ale_sign_error                      = '💢'                    " ✘ 👾 💣  🙅 🤦
let g:ale_sign_warning                    = 'ᑹ'                     " ⚠ ⸮ ⸘ ☹
let g:ale_sign_info                       = 'ᓆ'                     " ⸚ ϔ 𐘿 𐰦
let g:ale_sign_style_error                = '⍥'                     " ᑹ
let g:ale_sign_style_warning              = 'ᓍ'                     " ᓏ
let g:ale_lint_on_text_changed            = 'never'
let g:ale_fix_on_save                     = 0
let g:ale_popup_menu_enabled              = 1
let g:ale_lint_on_save                    = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace  = 1
let g:ale_set_balloons                    = 1
let g:ale_hover_to_preview                = 1
let g:ale_floating_preview                = 1
let g:ale_close_preview_on_insert         = 1
let g:ale_completion_enabled              = 1
let g:ale_linters_explicit                = 1
let g:ale_floating_window_border          = [ '│', '─', '╭', '╮', '╯', '╰', '│', '─' ]
let g:ale_fixers                          = {
  \   '*' : [ 'remove_trailing_lines', 'trim_whitespace' ]
  \}

" junegunn/fzf.vim
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :GFiles<CR>
nnoremap <C-s> :Ag<CR>
nnoremap <silent><leader>l  :Buffers<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>g :Commits<CR>
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }
\ }))
let g:fzf_vim                     = {}
let g:fzf_vim.preview_window      = [ 'right,50%', 'ctrl-\' ]
let g:fzf_vim.tags_command        = 'ctags -R'
let g:fzf_vim.commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat --color=always {}']}, <bang>0)
command! -bang -complete=dir -nargs=? LS
    \ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}, <bang>0))
let g:fzf_layout                  = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
let g:fzf_history_dir             = '~/.vim/cache/fzf-history'
let g:fzf_action                  = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
\ }
let g:fzf_colors                  = {
  \ 'fg':         ['fg', 'Normal'                               ] ,
  \ 'bg':         ['bg', 'Normal'                               ] ,
  \ 'preview-bg': ['bg', 'NormalFloat'                          ] ,
  \ 'hl':         ['fg', 'Comment'                              ] ,
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal' ] ,
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'           ] ,
  \ 'hl+':        ['fg', 'Statement'                            ] ,
  \ 'info':       ['fg', 'PreProc'                              ] ,
  \ 'border':     ['fg', 'Ignore'                               ] ,
  \ 'prompt':     ['fg', 'Conditional'                          ] ,
  \ 'pointer':    ['fg', 'Exception'                            ] ,
  \ 'marker':     ['fg', 'Keyword'                              ] ,
  \ 'spinner':    ['fg', 'Label'                                ] ,
  \ 'header':     ['fg', 'Comment'                              ]
\ }

" vim:tabstop=2:softtabstop=2:shiftwidth=2:expandtab:filetype=vim:foldmethod=marker:foldmarker="\ **************************************************************/,"\ /**************************************************************
