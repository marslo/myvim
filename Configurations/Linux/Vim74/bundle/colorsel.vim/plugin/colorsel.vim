" Vim plugin script
" File: colorsel.vim
" Summary: A simple interactive RGB/HSV color selector.
" Authors: David Necas (Yeti) <yeti@physics.muni.cz>
"          Ingo Karkat <swdev@ingo-karkat.de>
" License: This Vim script is in the public domain.
" Version: 2010-04-01

if v:version < 700
  finish
endif
if !has('gui_running')
  finish
endif

if !exists('g:colorsel_swatch_text')
  let g:colorsel_swatch_text = 'The quick brown fox jumps over the lazy dog.'
  let g:colorsel_swatch_text = g:colorsel_swatch_text . "\n\n\n" . g:colorsel_swatch_text
endif

command! -bar -nargs=* -complete=highlight ColorSel call colorsel#ColorSel(<f-args>)
" vim: set et ts=2 :
