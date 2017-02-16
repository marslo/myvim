" Vim color scheme
"
" Name:         railscast.vim
" Maintainer:   Josh O'Rourke <jorourke23@gmail.com>
" Last Change:  17 Aug 2007
" License:      public domain
" Version:      1.1
"
" This theme is based on the Railscasts Textmate theme [1]. I used
" Jo Vermeulen's "vibrantink" theme for Vim [2] as my template for
" creating this theme.
"
" [1] http://railscasts.com/about
" [2] http://www.vim.org/scripts/script.php?script_id=1794

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "railscasts"

if has("gui_running")
  hi link htmlTag                     xmlTag
  hi link htmlTagName                 xmlTagName
  hi link htmlEndTag                  xmlEndTag

  highlight Normal                    guifg=#E6E1DC guibg=#090909
  highlight Cursor                    guifg=#000000 guibg=#FFFFFF
  highlight NonText                   guifg=#333333 guibg=#000000
  highlight CursorLine                guibg=#323300

  " highlight Comment                   guifg=#BC9458 gui=italic
  " highlight SpellBad                  guifg=#990000 guibg=#000000
  highlight Comment                   guifg=#666666 gui=italic
  highlight Constant                  guifg=#6D9CBE
  highlight Define                    guifg=#CC7833
  highlight Error                     guifg=#FFFFFF guibg=#990000
  highlight Function                  guifg=#FFC66D gui=NONE
  highlight Identifier                guifg=#6D9CBE gui=NONE
  highlight Include                   guifg=#CC7833 gui=NONE
  highlight Keyword                   guifg=#CC7833
  highlight LineNr                    guifg=#2B2B2B guibg=#000000
  highlight Number                    guifg=#A5C261
  " highlight Number                    guifg=#6D9CBE gui=NONE
  highlight PreProc                   guifg=#E6E1DC
  highlight Search                    guibg=#FFFF00
  highlight Statement                 guifg=#CC7833 gui=NONE
  highlight String                    guifg=#A5C261
  highlight Title                     guifg=#FFFFFF
  highlight Todo                      guibg=#000000 guifg=#996600 gui=italic
  highlight Type                      guifg=#DA4939 gui=NONE
  " highlight Visual                    guibg=#5A647E
  highlight Visual                    guibg=#181818
  highlight Folded                    guifg=#666666 guibg=#111111

  highlight VertSplit                 guifg=#202020 guibg=#202020 gui=NONE   ctermfg=darkgray ctermbg=darkgray cterm=NONE
  highlight StatusLine                guifg=#CCCCCC guibg=#202020 gui=italic ctermfg=white    ctermbg=darkgray cterm=NONE
  highlight StatusLineNC              guifg=#000000 guibg=#202020 gui=NONE   ctermfg=blue     ctermbg=darkgray cterm=NONE

  highlight DiffAdd                   guifg=#E6E1DC guibg=#144212
  highlight DiffDelete                guifg=#E6E1DC guibg=#660000

  highlight rubyBlockParameter        guifg=#FFFFFF
  highlight rubyClass                 guifg=#FFFFFF
  highlight rubyConstant              guifg=#DA4939
  highlight rubyInstanceVariable      guifg=#D0D0FF
  highlight rubyInterpolation         guifg=#519F50
  highlight rubyLocalVariableOrMethod guifg=#D0D0FF
  highlight rubyPredefinedConstant    guifg=#DA4939
  highlight rubyPseudoVariable        guifg=#FFC66D
  highlight rubyStringDelimiter       guifg=#A5C261
  highlight rubySymbol                guifg=#A5C261

  highlight xmlTag                    guifg=#E8BF6A
  highlight xmlTagName                guifg=#E8BF6A
  highlight xmlEndTag                 guifg=#E8BF6A
else
    set t_Co=256
    highlight Normal ctermfg=White ctermbg=Black
    highlight Number ctermfg=White ctermbg=Black
    highlight LineNr ctermfg=DarkGray ctermbg=Black
    highlight Folded ctermfg=DarkBlue ctermbg=Black
    highlight Keyword ctermfg=202
    highlight Define ctermfg=202
    highlight Comment ctermfg=DarkGray
    highlight Type ctermfg=White
    highlight rubySymbol ctermfg=66
    highlight Identifier ctermfg=White
    highlight rubyClassVariable ctermfg=66
    highlight rubyStringDelimiter ctermfg=DarkGreen
    highlight rubyInstanceVariable ctermfg=66
    highlight rubyInterpolation ctermfg=White
    highlight rubyPseudoVariable ctermfg=66
    highlight Constant ctermfg=228
    highlight Function ctermfg=DarkRed
    highlight Include ctermfg=DarkRed
    highlight Statement ctermfg=DarkRed
    highlight String ctermfg=DarkGreen
    highlight Search ctermbg=White
    highlight Todo ctermbg=Black ctermfg=Yellow
    highlight Title ctermbg=Black ctermfg=Yellow
    highlight ModeMsg ctermfg=white ctermbg=DarkGreen
    highlight NonText ctermfg=DarkGray ctermbg=Black
    highlight Visual ctermfg=DarkGray ctermbg=Black
    highlight TabLine cterm=bold ctermfg=Black ctermbg=Gray
    highlight TabLineFill cterm=bold ctermfg=Black ctermbg=DarkGray
    highlight TabLineSel cterm=NONE ctermfg=White ctermbg=DarkRed
    highlight StatusLine ctermfg=Gray ctermbg=Black
    highlight StatusLineNC ctermfg=DarkGray ctermbg=Black
    highlight CursorLine cterm=NONE  ctermbg=NONE
    highlight MatchParen ctermbg=Black ctermfg=DarkYellow
endif
