" Vim autoload script
" File: colorsel.vim
" Summary: A simple interactive RGB/HSV color selector.
" Authors: David Necas (Yeti) <yeti@physics.muni.cz>
"          Ingo Karkat <swdev@ingo-karkat.de>
" License: This Vim script is in the public domain.
" Version: 2011-01-07

let s:swatchSize = exists('colorsel_swatch_size') ? colorsel_swatch_size : 10
let s:swatchSize = s:swatchSize < 6 ? 6 : s:swatchSize
let s:sliderSize = exists('colorsel_slider_size') ? colorsel_slider_size : 16
let s:q = 255*s:sliderSize/(s:sliderSize - 1)
let s:q6 = 359*s:sliderSize/(s:sliderSize - 1)
let s:showPalette = exists('colorsel_show_palette') ? colorsel_show_palette : 1
let s:showSwatchDifference = exists('colorsel_show_swatch_difference') ? colorsel_show_swatch_difference : 1
let s:bufname = '==[ Color Selector ]=='
let s:dashes = '----------'
let s:dashes = s:dashes . s:dashes
let s:dashes = s:dashes . s:dashes
let s:dashes = s:dashes . s:dashes
let s:active = 'r'
let s:guifg = 'ffffff'
let s:isForegroundSwapped = 0
let s:isTextVisible = 1
function! s:hasForegroundText()
  return s:isTextVisible && g:colorsel_swatch_text !~# '^\%(\_s\|\r\)*$'
endfun

function! s:size2width(h)
  return 8*a:h/5
endfun

function! s:swatchTop()
  let width = s:size2width(s:swatchSize)
  let curColor = s:currentcolor() . (! s:isTextVisible || exists('b:didDefineAltSwatchOverlay') || width < 13 ? '' : ' (' . (s:isForegroundSwapped ? 'fg' : 'bg') . ')')
  return strpart(' -- ' . curColor . ' ' . strpart(s:dashes, 0, width - strlen(curColor) - 4) . ' ', 0, width + 2)
endfun

function! s:swatchBottom()
  let width = s:size2width(s:swatchSize)
  if s:altColor == ''
    return ' ' . strpart(s:dashes, 0, width - 7) . ' Yeti - '
  else
    let secondColor = s:altColor . (! s:isTextVisible || exists('b:didDefineAltSwatchOverlay') || width < 13 ? '' : ' (' . (s:isForegroundSwapped ? 'bg' : 'fg') . ')')
    return strpart(' -- ' . secondColor . ' ' . strpart(s:dashes, 0, width - strlen(secondColor) - 4) . ' ', 0, width + 2)
  else
  endif
endfun

function! s:drawSwatch()
  let width = s:size2width(s:swatchSize)
  %delete _ " Clean the entire window first.

  " First render the swatch text, then draw the swatch border "over" it.
  if s:hasForegroundText()
    " The swatch text may consist of multiple lines. Make it vertically centered
    " in the swatch, so that one can have a "mirrored text" effect (e.g. by
    " choosing the text "Test\nTest") around the split swatch.
    let textLineNum = strlen(substitute(g:colorsel_swatch_text, "[^\n\r]", '', 'g'))
    let startLine = (s:swatchSize - textLineNum + 1) / 2
    execute 'normal!' (startLine < 1 ? 1 : startLine) . 'o'
    execute 'normal! i' . g:colorsel_swatch_text
    execute 'silent %s/\%>' . width . 'v.*$//e' | " Cut away any text protruding into the control area.
  endif

  " The text is rendered, now park the cursor in the upper left corner.
  normal! gg0

  let padding = ''
  let p = 0
  while p < width
    let padding = padding . ' '
    let p = p+1
  endwhile

  let frameTop = strpart(s:dashes, 0, width)
  call s:updateSwatch(1, ' ' . frameTop)

  " The challenge when adding the left and right swatch border is that the
  " rendered text may end in a character that is double width (e.g. a Kanji
  " character). This needs to be considered when cutting out based on virtual
  " column. Potentially, the extracted text is too short and must be aligned to
  " the proper width.
  let i = 0
  while i < s:swatchSize
    let text = matchstr(getline(i + 2) . padding, '^.*\%<' . (width + 2) . 'v')
    while text !~# '\%>' . width . 'v' " Align to swatch width in case cut position fell in the middle of a multi-column character.
      let text = text . ' '
    endwhile
    call s:updateSwatch(i + 2, '|' . text . '|')
    let i = i+1
  endwhile

  call s:updateSwatch(i + 2, s:swatchBottom())
endfun

function! s:drawLegend()
  " For size 7, push the incomplete legend out of the visible window.
  " For sizes larger than 8, add an empty line above the legend.
  let shift = s:swatchSize == 8 ? 0 : s:swatchSize == 7 ? 2 : 1

  call s:updateStatus(8 + shift, ' jk switch   0bjlw$ change values' . (s:showPalette ? '   "xp/P use palette entry x' : ''))
  call s:updateStatus(9 + shift, '  q quit  ' . (s:showSwatchDifference ? 'x swap up/dn  ' : '        ') . 'y yank #rrggbb ' . (s:showPalette ? '"xy/Y store in entry x' : ''))
  call s:updateStatus(10+ shift, '          ' . (s:hasForegroundText() ? 'X edit fg/bg  ' : '              ') . '/ enter swatch text  f format text')
endfun

function! s:redraw()
  call s:drawSwatch()
  call s:drawLegend()
  call s:update()
endfun

function! s:sliderStr(val, max)
  let slider = ''
  let pos = a:val*s:sliderSize/(a:max + 1)
  let i = 0
  while i < s:sliderSize
    let slider = slider . (i == pos ? '#' : ' ')
    let i = i+1
  endwhile
  return "[" . slider .  "]"
endfun

function! s:byte2dec(byte)
  let s = '' . a:byte
  if a:byte < 100
    let s = ' ' . s
  endif
  if a:byte < 10
    let s = ' ' . s
  endif
  return s
endfun

function! s:formatLine(val, l, max)
  let dec = s:byte2dec(a:val)
  let slider = a:l . ' ' . s:sliderStr(a:val, a:max)
  if s:active == tolower(a:l)
    let active_l = '->'
    let active_r = '<-'
  else
    let active_l = '  '
    let active_r = '  '
  endif
  return '  ' . active_l . slider . active_r . '  ' . dec
endfun

function! s:palette(register, revert)
  if !s:showPalette
    return ''
  endif

  let rgb = s:translateColor(getreg(a:register))
  if rgb != ''
    exec 'hi colorselPalette' . a:register . ' guibg=#' . rgb
  endif
  let swatch = '     '
  let entry = a:register . ':' .  strpart('      ', 0, 6 - strlen(rgb)) . rgb
  return (a:revert ? swatch . entry : entry . swatch)
endfun

function! s:updateSwatch(lnum, text)
  call setline(a:lnum, a:text . matchstr(getline(a:lnum), '\%>' . (s:size2width(s:swatchSize) + 2) . 'v.*$'))
endfun

function! s:updateStatus(lnum, text)
  call setline(a:lnum, matchstr(getline(a:lnum), '^.*\%' . (s:size2width(s:swatchSize) + 2) . 'v.') . a:text)
endfun

function! s:drawStatus()
  call s:updateStatus(2, s:formatLine(s:red, 'R', 255)        . '    ' . s:palette('a',0) . s:palette('g',1))
  call s:updateStatus(3, s:formatLine(s:green, 'G', 255)      . '    ' . s:palette('b',0) . s:palette('h',1))
  call s:updateStatus(4, s:formatLine(s:blue, 'B', 255)       . '    ' . s:palette('c',0) . s:palette('i',1))
  call s:updateStatus(5, s:formatLine(s:hue, 'H', 359)        . '    ' . s:palette('d',0) . s:palette('j',1))
  call s:updateStatus(6, s:formatLine(s:saturation, 'S', 255) . '    ' . s:palette('e',0) . s:palette('k',1))
  call s:updateStatus(7, s:formatLine(s:value, 'V', 255)      . '    ' . s:palette('f',0) . s:palette('l',1))
  setlocal nomodified
endfun

function! s:byte2hex(byte)
  let hexdigits = '0123456789abcdef'
  let low = a:byte % 16
  let hi = a:byte / 16
  return hexdigits[hi] . hexdigits[low]
endfun

function! s:rgb2color(r, g, b)
  return s:byte2hex(a:r) . s:byte2hex(a:g) . s:byte2hex(a:b)
endfun

function! s:currentcolor()
  return s:rgb2color(s:red, s:green, s:blue)
endfun

function! s:contrastcolor()
  return (3*s:green + 2*s:red + s:blue > 3*255 ? '000000' : 'ffffff')
endfun

function! s:update()
  let c = s:currentcolor()
  let s:guifg = s:contrastcolor()
  let ac = (s:altColor == '' ? s:guifg : s:altColor)
  let fg = (s:isForegroundSwapped ? 'bg' : 'fg')
  let bg = (s:isForegroundSwapped ? 'fg' : 'bg')
  exec 'hi colorselColor          gui' . bg . '=#' .  c 'gui' . fg . '=#' . ac
  exec 'hi colorselAlternateColor gui' . bg . '=#' . ac 'gui' . fg . '=#' . c
  if s:hlgroup != ''
    exec 'hi' s:hlgroup 'gui' . bg . '=#' .  c 'gui' . fg . '=#' . ac
  endif

  call s:hiRGB()
  call s:hiHue()
  call s:hiSaturation()
  call s:hiValue()
  call s:updateSwatch(1, s:swatchTop())
  call s:drawStatus()
  call s:updateSwatch(s:swatchSize + 2, s:swatchBottom())
  call s:updateStatus(1, s:hlgroup == '' ? '' : '       ' . s:hlgroup)
endfun

function! s:updateHSV()
  let max = s:red > s:green ? s:red : s:green
  let max = max > s:blue ? max : s:blue
  let min = s:red < s:green ? s:red : s:green
  let min = min < s:blue ? min : s:blue
  let s:value = max
  let d = max - min
  if d > 0
    let s:saturation = 255*d/max
    if s:red == max
      let s:hue = 60*(s:green - s:blue)/d
    elseif s:green == max
      let s:hue = 120 + 60*(s:blue - s:red)/d
    else
      let s:hue = 240 + 60*(s:red - s:green)/d
    endif
    let s:hue = (s:hue + 360) % 360
  else
    let s:saturation = 0
    let s:hue = 0
  endif
endfun

function! s:updateRGB()
  let s:red = s:hsv2r(s:hue, s:saturation, s:value)
  let s:green = s:hsv2g(s:hue, s:saturation, s:value)
  let s:blue = s:hsv2b(s:hue, s:saturation, s:value)
endfun

function! s:hsv2r(h, s, v)
  if a:s == 0
    return a:v
  endif
  let f = a:h % 60
  let i = a:h/60
  if i == 0 || i == 5
    return a:v
  elseif i == 2 || i == 3
    return a:v*(255 - a:s)/255
  elseif i == 1
    return a:v*(255*60 - (a:s*f))/60/255
  else
    return a:v*(255*60 - a:s*(60 - f))/60/255
  endif
endfun

function! s:hsv2g(h, s, v)
  if a:s == 0
    return a:v
  endif
  let f = a:h % 60
  let i = a:h/60
  if i == 1 || i == 2
    return a:v
  elseif i == 4 || i == 5
    return a:v*(255 - a:s)/255
  elseif i == 3
    return a:v*(255*60 - (a:s*f))/60/255
  else
    return a:v*(255*60 - a:s*(60 - f))/60/255
  endif
endfun

function! s:hsv2b(h, s, v)
  if a:s == 0
    return a:v
  endif
  let f = a:h % 60
  let i = a:h/60
  if i == 3 || i == 4
    return a:v
  elseif i == 0 || i == 1
    return a:v*(255 - a:s)/255
  elseif i == 5
    return a:v*(255*60 - (a:s*f))/60/255
  else
    return a:v*(255*60 - a:s*(60 - f))/60/255
  endif
endfun

function! s:paste()
  let color = s:translateColorWithCheck(getreg(v:register), "Register " . v:register . " doesn't contain a valid color")
  if color != ''
    call s:setColor(color)
    echomsg 'Pasted color #' . color
    call s:update()
  endif
endfun

function! s:pasteAlt()
  let color = s:translateColorWithCheck(getreg(v:register), "Register " . v:register . " doesn't contain a valid color")
  if color != ''
    let s:altColor = color
    echomsg 'Pasted' (exists('b:didDefineAltSwatchOverlay') ? 'alternate' : (s:isForegroundSwapped ? 'background' : 'foreground')) 'color #' . color
    call s:update()
  endif
endfun

function! s:yank()
  call setreg(v:register, '#' . s:currentcolor(), 'c')
  call s:drawStatus()
  echomsg 'Yanked color #' . s:currentcolor()
endfun

function! s:yankAlt()
  if s:altColor == ''
    echohl ErrorMsg
    echomsg 'No' (exists('b:didDefineAltSwatchOverlay') ? 'alternate' : (s:isForegroundSwapped ? 'background' : 'foreground')) 'color yet'
    echohl None
    return
  endif

  call setreg(v:register, '#' . s:altColor, 'c')
  call s:drawStatus()
  echomsg 'Yanked color #' . s:altColor
endfun

function! s:swapWithAlt()
  if s:showSwatchDifference
    let currentColor = s:currentcolor()
    if s:altColor != ''
      call s:setColor(s:altColor)
    endif
    let s:altColor = currentColor

    if !exists('b:didDefineAltSwatchOverlay')
      " Remove the foreground swap; this would only apply any color modification
      " to the bottom half of the swatch and be confusing.
      let s:isForegroundSwapped = 0

      " Split alternate color swatch off the bottom half of the swatch.
      exec 'syn match colorselAlternateColor "^\%>'.(s:swatchSize / 2 + 1).'l|.\+|"ms=s+1,me=e-1'
      let b:didDefineAltSwatchOverlay = 1
      echo 'Keeping #' . s:altColor 'as reference in lower half of swatch'
    else
      echo 'Swapped colors in split swatch'
    endif

    call s:update()
  endif
endfun

function! s:toggleForegroundEditing()
  if ! s:isTextVisible | return | endif

  let currentColor = s:currentcolor()
  call s:setColor(s:altColor == '' ? s:contrastcolor() : s:altColor)
  let s:altColor = currentColor

  let s:isForegroundSwapped = ! s:isForegroundSwapped

  if exists('b:didDefineAltSwatchOverlay')
    " Remove the swap with alternate color; the foreground swap isn't visible
    " without it.
    exec 'syn clear colorselAlternateColor'
    unlet b:didDefineAltSwatchOverlay
  endif
  echo 'Editing' (s:isForegroundSwapped ? 'foreground' : 'background') 'color'
endfun

function! s:setText()
  let newtext = input('Text: ')
  if newtext != ''
    let g:colorsel_swatch_text = newtext
    let s:isTextVisible = 1
    call s:redraw()
  endif
endfun

function! s:formatText()
  " Toggle format of the swatch text from normal -> bold -> italic -> bold &
  " italic -> no text -> normal.
  if ! s:isTextVisible
    let s:isTextVisible = 1
    call s:redraw()
    echo 'Text format changed to normal'
    return
  endif

  let synId = synIDtrans(hlID('colorselColor'))
  if ! synIDattr(synId, 'bold')
    if ! synIDattr(synId, 'italic')
      let format = 'bold'
    else
      let format = 'bold,italic'
    endif
  else
    if ! synIDattr(synId, 'italic')
      let format = 'italic'
    else
      let format = 'NONE'
      if s:isForegroundSwapped
        " Stop editing the now invisible foreground color. 
        call s:toggleForegroundEditing()
      endif
      let s:isTextVisible = 0
      call s:redraw()
    endif
  endif

  exe 'hi colorselColor gui=' . format
  exe 'hi colorselAlternateColor gui=' . format
  if s:hlgroup != ''
    exe 'hi' s:hlgroup 'gui=' . format
  endif
  echo 'Text format changed to' format
endfun

function! s:inc()
  if s:active == 'r'
    let s:red = (s:red >= 255) ? 255 : s:red+1
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = (s:green >= 255) ? 255 : s:green+1
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = (s:blue >= 255) ? 255 : s:blue+1
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = (s:hue >= 359) ? 359 : s:hue+1
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = (s:saturation >= 255) ? 255 : s:saturation+1
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = (s:value >= 255) ? 255 : s:value+1
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:dec()
  if s:active == 'r'
    let s:red = (s:red <= 0) ? 0 : s:red-1
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = (s:green <= 0) ? 0 : s:green-1
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = (s:blue <= 0) ? 0 : s:blue-1
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = (s:hue <= 0) ? 0 : s:hue-1
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = (s:saturation <= 0) ? 0 : s:saturation-1
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = (s:value <= 0) ? 0 : s:value-1
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:end()
  if s:active == 'r'
    let s:red = 255
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = 255
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = 255
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = 359
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = 255
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = 255
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:begin()
  if s:active == 'r'
    let s:red = 0
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = 0
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = 0
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = 0
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = 0
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = 0
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:pginc()
  if s:active == 'r'
    let s:red = (s:red >= 240) ? 255 : s:red+16
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = (s:green >= 240) ? 255 : s:green+16
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = (s:blue >= 240) ? 255 : s:blue+16
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = (s:hue >= 340) ? 359 : s:hue+20
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = (s:saturation >= 240) ? 255 : s:saturation+16
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = (s:value >= 240) ? 255 : s:value+16
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:pgdec()
  if s:active == 'r'
    let s:red = (s:red <= 16) ? 0 : s:red-16
    call s:updateHSV()
  elseif s:active == 'g'
    let s:green = (s:green <= 16) ? 0 : s:green-16
    call s:updateHSV()
  elseif s:active == 'b'
    let s:blue = (s:blue <= 16) ? 0 : s:blue-16
    call s:updateHSV()
  elseif s:active == 'h'
    let s:hue = (s:hue <= 20) ? 0 : s:hue-20
    call s:updateRGB()
  elseif s:active == 's'
    let s:saturation = (s:saturation <= 16) ? 0 : s:saturation-16
    call s:updateRGB()
  elseif s:active == 'v'
    let s:value = (s:value <= 16) ? 0 : s:value-16
    call s:updateRGB()
  endif
  call s:update()
endfun

function! s:hiRGB()
  let i = 0
  while i < s:sliderSize
    let byte = s:q*i/s:sliderSize
    let c = s:rgb2color(byte, s:green, s:blue)
    exec 'hi colorselRed' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let c = s:rgb2color(s:red, byte, s:blue)
    exec 'hi colorselGreen' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let c = s:rgb2color(s:red, s:green, byte)
    exec 'hi colorselBlue' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let i = i+1
  endwhile
endfun

function! s:hiHue()
  let i = 0
  while i < s:sliderSize
    let byte = s:q6*i/s:sliderSize
    let r = s:hsv2r(byte, s:saturation, s:value)
    let g = s:hsv2g(byte, s:saturation, s:value)
    let b = s:hsv2b(byte, s:saturation, s:value)
    let c = s:rgb2color(r, g, b)
    exec 'hi colorselHue' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let i = i+1
  endwhile
endfun

function! s:hiSaturation()
  let i = 0
  while i < s:sliderSize
    let byte = s:q*i/s:sliderSize
    let r = s:hsv2r(s:hue, byte, s:value)
    let g = s:hsv2g(s:hue, byte, s:value)
    let b = s:hsv2b(s:hue, byte, s:value)
    let c = s:rgb2color(r, g, b)
    exec 'hi colorselSaturation' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let i = i+1
  endwhile
endfun

function! s:hiValue()
  let i = 0
  while i < s:sliderSize
    let byte = s:q*i/s:sliderSize
    let r = s:hsv2r(s:hue, s:saturation, byte)
    let g = s:hsv2g(s:hue, s:saturation, byte)
    let b = s:hsv2b(s:hue, s:saturation, byte)
    let c = s:rgb2color(r, g, b)
    exec 'hi colorselValue' . i . ' guibg=#' . c . ' guifg=#' . s:guifg
    let i = i+1
  endwhile
endfun

function! s:active2line(a)
  return stridx('rgbhsv', tolower(a:a))
endfun

function! s:activeUp()
  let s:active = 'rgbhsv'[(stridx('rgbhsv', s:active) + 5) % 6]
  call s:drawStatus()
endfun

function! s:activeDown()
  let s:active = 'rgbhsv'[(stridx('rgbhsv', s:active) + 1) % 6]
  call s:drawStatus()
endfun

function! s:translateColor(string)
  " remove # prefix and any leading and trailing whitespace
  let color = matchstr(a:string, '^\s*#\?\zs\S\+')

  " check if value is hexadecimal
  if color !~? '^\x\+$'
    " CSS color names (http://www.w3schools.com/css/css_colornames.asp)

    if     color ==? 'AliceBlue'            | let color = 'f0f8ff'
    elseif color ==? 'AntiqueWhite'         | let color = 'faebd7'
    elseif color ==? 'Aqua'                 | let color = '00ffff'
    elseif color ==? 'Aquamarine'           | let color = '7fffd4'
    elseif color ==? 'Azure'                | let color = 'f0ffff'
    elseif color ==? 'Beige'                | let color = 'f5f5dc'
    elseif color ==? 'Bisque'               | let color = 'ffe4c4'
    elseif color ==? 'Black'                | let color = '000000'
    elseif color ==? 'BlanchedAlmond'       | let color = 'ffebcd'
    elseif color ==? 'Blue'                 | let color = '0000ff'
    elseif color ==? 'BlueViolet'           | let color = '8a2be2'
    elseif color ==? 'Brown'                | let color = 'a52a2a'
    elseif color ==? 'BurlyWood'            | let color = 'deb887'
    elseif color ==? 'CadetBlue'            | let color = '5f9ea0'
    elseif color ==? 'Chartreuse'           | let color = '7fff00'
    elseif color ==? 'Chocolate'            | let color = 'd2691e'
    elseif color ==? 'Coral'                | let color = 'ff7f50'
    elseif color ==? 'CornflowerBlue'       | let color = '6495ed'
    elseif color ==? 'Cornsilk'             | let color = 'fff8dc'
    elseif color ==? 'Crimson'              | let color = 'dc143c'
    elseif color ==? 'Cyan'                 | let color = '00ffff'
    elseif color ==? 'DarkBlue'             | let color = '00008b'
    elseif color ==? 'DarkCyan'             | let color = '008b8b'
    elseif color ==? 'DarkGoldenRod'        | let color = 'b8860b'
    elseif color ==? 'DarkGray'             | let color = 'a9a9a9'
    elseif color ==? 'DarkGreen'            | let color = '006400'
    elseif color ==? 'DarkKhaki'            | let color = 'bdb76b'
    elseif color ==? 'DarkMagenta'          | let color = '8b008b'
    elseif color ==? 'DarkOliveGreen'       | let color = '556b2f'
    elseif color ==? 'Darkorange'           | let color = 'ff8c00'
    elseif color ==? 'DarkOrchid'           | let color = '9932cc'
    elseif color ==? 'DarkRed'              | let color = '8b0000'
    elseif color ==? 'DarkSalmon'           | let color = 'e9967a'
    elseif color ==? 'DarkSeaGreen'         | let color = '8fbc8f'
    elseif color ==? 'DarkSlateBlue'        | let color = '483d8b'
    elseif color ==? 'DarkSlateGray'        | let color = '2f4f4f'
    elseif color ==? 'DarkTurquoise'        | let color = '00ced1'
    elseif color ==? 'DarkViolet'           | let color = '9400d3'
    elseif color ==? 'DeepPink'             | let color = 'ff1493'
    elseif color ==? 'DeepSkyBlue'          | let color = '00bfff'
    elseif color ==? 'DimGray'              | let color = '696969'
    elseif color ==? 'DodgerBlue'           | let color = '1e90ff'
    elseif color ==? 'FireBrick'            | let color = 'b22222'
    elseif color ==? 'FloralWhite'          | let color = 'fffaf0'
    elseif color ==? 'ForestGreen'          | let color = '228b22'
    elseif color ==? 'Fuchsia'              | let color = 'ff00ff'
    elseif color ==? 'Gainsboro'            | let color = 'dcdcdc'
    elseif color ==? 'GhostWhite'           | let color = 'f8f8ff'
    elseif color ==? 'Gold'                 | let color = 'ffd700'
    elseif color ==? 'GoldenRod'            | let color = 'daa520'
    elseif color ==? 'Gray'                 | let color = '808080'
    elseif color ==? 'Green'                | let color = '008000'
    elseif color ==? 'GreenYellow'          | let color = 'adff2f'
    elseif color ==? 'HoneyDew'             | let color = 'f0fff0'
    elseif color ==? 'HotPink'              | let color = 'ff69b4'
    elseif color ==? 'IndianRed'            | let color = 'cd5c5c'
    elseif color ==? 'Indigo'               | let color = '4b0082'
    elseif color ==? 'Ivory'                | let color = 'fffff0'
    elseif color ==? 'Khaki'                | let color = 'f0e68c'
    elseif color ==? 'Lavender'             | let color = 'e6e6fa'
    elseif color ==? 'LavenderBlush'        | let color = 'fff0f5'
    elseif color ==? 'LawnGreen'            | let color = '7cfc00'
    elseif color ==? 'LemonChiffon'         | let color = 'fffacd'
    elseif color ==? 'LightBlue'            | let color = 'add8e6'
    elseif color ==? 'LightCoral'           | let color = 'f08080'
    elseif color ==? 'LightCyan'            | let color = 'e0ffff'
    elseif color ==? 'LightGoldenRodYellow' | let color = 'fafad2'
    elseif color ==? 'LightGrey'            | let color = 'd3d3d3'
    elseif color ==? 'LightGreen'           | let color = '90ee90'
    elseif color ==? 'LightPink'            | let color = 'ffb6c1'
    elseif color ==? 'LightSalmon'          | let color = 'ffa07a'
    elseif color ==? 'LightSeaGreen'        | let color = '20b2aa'
    elseif color ==? 'LightSkyBlue'         | let color = '87cefa'
    elseif color ==? 'LightSlateGray'       | let color = '778899'
    elseif color ==? 'LightSteelBlue'       | let color = 'b0c4de'
    elseif color ==? 'LightYellow'          | let color = 'ffffe0'
    elseif color ==? 'Lime'                 | let color = '00ff00'
    elseif color ==? 'LimeGreen'            | let color = '32cd32'
    elseif color ==? 'Linen'                | let color = 'faf0e6'
    elseif color ==? 'Magenta'              | let color = 'ff00ff'
    elseif color ==? 'Maroon'               | let color = '800000'
    elseif color ==? 'MediumAquaMarine'     | let color = '66cdaa'
    elseif color ==? 'MediumBlue'           | let color = '0000cd'
    elseif color ==? 'MediumOrchid'         | let color = 'ba55d3'
    elseif color ==? 'MediumPurple'         | let color = '9370d8'
    elseif color ==? 'MediumSeaGreen'       | let color = '3cb371'
    elseif color ==? 'MediumSlateBlue'      | let color = '7b68ee'
    elseif color ==? 'MediumSpringGreen'    | let color = '00fa9a'
    elseif color ==? 'MediumTurquoise'      | let color = '48d1cc'
    elseif color ==? 'MediumVioletRed'      | let color = 'c71585'
    elseif color ==? 'MidnightBlue'         | let color = '191970'
    elseif color ==? 'MintCream'            | let color = 'f5fffa'
    elseif color ==? 'MistyRose'            | let color = 'ffe4e1'
    elseif color ==? 'Moccasin'             | let color = 'ffe4b5'
    elseif color ==? 'NavajoWhite'          | let color = 'ffdead'
    elseif color ==? 'Navy'                 | let color = '000080'
    elseif color ==? 'OldLace'              | let color = 'fdf5e6'
    elseif color ==? 'Olive'                | let color = '808000'
    elseif color ==? 'OliveDrab'            | let color = '6b8e23'
    elseif color ==? 'Orange'               | let color = 'ffa500'
    elseif color ==? 'OrangeRed'            | let color = 'ff4500'
    elseif color ==? 'Orchid'               | let color = 'da70d6'
    elseif color ==? 'PaleGoldenRod'        | let color = 'eee8aa'
    elseif color ==? 'PaleGreen'            | let color = '98fb98'
    elseif color ==? 'PaleTurquoise'        | let color = 'afeeee'
    elseif color ==? 'PaleVioletRed'        | let color = 'd87093'
    elseif color ==? 'PapayaWhip'           | let color = 'ffefd5'
    elseif color ==? 'PeachPuff'            | let color = 'ffdab9'
    elseif color ==? 'Peru'                 | let color = 'cd853f'
    elseif color ==? 'Pink'                 | let color = 'ffc0cb'
    elseif color ==? 'Plum'                 | let color = 'dda0dd'
    elseif color ==? 'PowderBlue'           | let color = 'b0e0e6'
    elseif color ==? 'Purple'               | let color = '800080'
    elseif color ==? 'Red'                  | let color = 'ff0000'
    elseif color ==? 'RosyBrown'            | let color = 'bc8f8f'
    elseif color ==? 'RoyalBlue'            | let color = '4169e1'
    elseif color ==? 'SaddleBrown'          | let color = '8b4513'
    elseif color ==? 'Salmon'               | let color = 'fa8072'
    elseif color ==? 'SandyBrown'           | let color = 'f4a460'
    elseif color ==? 'SeaGreen'             | let color = '2e8b57'
    elseif color ==? 'SeaShell'             | let color = 'fff5ee'
    elseif color ==? 'Sienna'               | let color = 'a0522d'
    elseif color ==? 'Silver'               | let color = 'c0c0c0'
    elseif color ==? 'SkyBlue'              | let color = '87ceeb'
    elseif color ==? 'SlateBlue'            | let color = '6a5acd'
    elseif color ==? 'SlateGray'            | let color = '708090'
    elseif color ==? 'Snow'                 | let color = 'fffafa'
    elseif color ==? 'SpringGreen'          | let color = '00ff7f'
    elseif color ==? 'SteelBlue'            | let color = '4682b4'
    elseif color ==? 'Tan'                  | let color = 'd2b48c'
    elseif color ==? 'Teal'                 | let color = '008080'
    elseif color ==? 'Thistle'              | let color = 'd8bfd8'
    elseif color ==? 'Tomato'               | let color = 'ff6347'
    elseif color ==? 'Turquoise'            | let color = '40e0d0'
    elseif color ==? 'Violet'               | let color = 'ee82ee'
    elseif color ==? 'Wheat'                | let color = 'f5deb3'
    elseif color ==? 'White'                | let color = 'ffffff'
    elseif color ==? 'WhiteSmoke'           | let color = 'f5f5f5'
    elseif color ==? 'Yellow'               | let color = 'ffff00'
    elseif color ==? 'YellowGreen'          | let color = '9acd32'

    else
      let color = ''
    endif
  endif

  " color value is hexadecimally and short (000)
  if strlen(color) == 3
    let color = strpart(color, 0, 1).strpart(color, 0, 1).strpart(color, 1, 1).strpart(color, 1, 1).strpart(color, 2, 1).strpart(color, 2, 1)
  elseif strlen(color) != 6
    let color = ''
  endif
  return color
endfun

function! s:translateColorWithCheck(string, failureMsg)
  let color = s:translateColor(a:string)
  if color == ''
    echohl WarningMsg
    let v:warningmsg = a:failureMsg
    echomsg v:warningmsg
    echohl None
  endif
  return color
endfun

function! s:setColor(color)
  exe 'let s:red=0x'.   strpart(a:color, 0, 2)
  exe 'let s:green=0x'. strpart(a:color, 2, 2)
  exe 'let s:blue=0x'.  strpart(a:color, 4, 2)
  call s:updateHSV()
endfun

function! colorsel#ColorSel(...)
  " Initialize persistent variables on first run.
  if !exists('s:red')
    let s:red = 127
    let s:green = 127
    let s:blue = 127
    let s:value = 127
    let s:hue = 0
    let s:saturation = 0
    let s:altColor = ''
  endif

  " set color to rrggbb argument with optional # prefix
  let isSetAltColor = 0
  let isSetHlGroup = 0
  if a:0
    if a:0 == 1 && hlexists(a:1)
      " Edit the passed highlight group.
      let s:hlgroup = a:1
      let synId = synIDtrans(hlID(s:hlgroup))
      let fgcolor = strpart(synIDattr(synId, 'fg#'), 1)
      let bgcolor = strpart(synIDattr(synId, 'bg#'), 1)

      " Note: We cannot query for the actual default Vim foreground / background
      " colors (they *may* have been set on the "Normal" hlgroup), so we fall
      " back to black/white based on the 'background' setting.
      call s:setColor(  bgcolor == '' ? (&background ==? 'light' ? 'ffffff' : '000000') : bgcolor)
      let s:altColor = (fgcolor == '' ? (&background ==? 'light' ? '000000' : 'ffffff') : fgcolor)

      let s:isForegroundSwapped = 0
      if bgcolor == ''
        " The hlgroup has no background color; edit the foreground color.
        call s:toggleForegroundEditing()
      endif

      let format=''
      if synIDattr(synId, 'bold'  ) | let format = format . (format == '' ? '' : ',') . 'bold'   | endif
      if synIDattr(synId, 'italic') | let format = format . (format == '' ? '' : ',') . 'italic' | endif
      exe 'hi colorselColor gui=' . (format == '' ? 'NONE' : format)
      exe 'hi colorselAlternateColor gui=' . (format == '' ? 'NONE' : format)

      let isSetHlGroup = 1
      let isSetAltColor = 1
    elseif a:1 =~ '^[-.*]$'
      " Background color should be kept as-is.
    elseif a:1 =~ '^guifg='
      let guicolor=strpart(a:1, 6)
      let fgcolor = s:translateColorWithCheck(guicolor, "Invalid color value '".guicolor."'.")
      if fgcolor != ''
        let s:isForegroundSwapped = 0 " Stop swapping, this definitely is the foreground color. 

        " Set background to default Vim background; this may be overridden if
        " the bgcolor is specified as the second argument. 
        call s:setColor(&background ==? 'light' ? 'ffffff' : '000000')

        let s:altColor = fgcolor
        let isSetAltColor = 1

        if a:0 == 1
          " No "guibg=..." is passed; edit the foreground color.
          call s:toggleForegroundEditing()
        endif
      endif
    elseif a:1 =~ '^guibg='
      let guicolor=strpart(a:1, 6)
      let bgcolor = s:translateColorWithCheck(guicolor, "Invalid color value '".guicolor."'.")
      if bgcolor != ''
        let s:isForegroundSwapped = 0 " Stop swapping, this definitely is the background color. 
        call s:setColor(bgcolor)
      endif
    else
      let bgcolor = s:translateColorWithCheck(a:1, "Invalid color value '".a:1."'.")
      if bgcolor != ''
        call s:setColor(bgcolor)
      endif
    endif

    if a:0 > 1
      if a:2 =~ '^[-.*]$'
        " Foreground color should be kept as-is.
      elseif a:2 =~ '^guifg='
        let guicolor=strpart(a:2, 6)
        let fgcolor = s:translateColorWithCheck(guicolor, "Invalid color value '".guicolor."'.")
        if fgcolor != ''
          let s:isForegroundSwapped = 0 " Stop swapping, this definitely is the foreground color. 
          let s:altColor = fgcolor
        endif
      elseif a:2 =~ '^guibg='
        let guicolor=strpart(a:2, 6)
        let bgcolor = s:translateColorWithCheck(guicolor, "Invalid color value '".guicolor."'.")
        if bgcolor != ''
          let s:isForegroundSwapped = 0 " Stop swapping, this definitely is the background color. 
          call s:setColor(bgcolor)
        endif
      else
        let fgcolor = s:translateColorWithCheck(a:2, "Invalid color value '".a:2."'.")
        if fgcolor != ''
          let s:altColor = fgcolor
        endif
      endif
      let isSetAltColor = 1
    endif
  endif

  if exists('s:bufno') && bufexists(s:bufno) && bufwinnr(s:bufno) > -1
    " The colorsel window is already open, just jump to it.
    exec bufwinnr(s:bufno) . 'wincmd w'
    if a:0
      " If a color has been specified, the windows needs to be updated.
      call s:update()
    endif
    return
  endif

  " A new colorsel session is started.
  if ! isSetAltColor
    let s:altColor = '' " Reset the alternate color from a previous session, unless passed as argument.
  endif
  if ! isSetHlGroup
    let s:hlgroup = '' " Break the link to an existing highlight group, unless a hlgroup was passed as the argument.
  endif

  if exists('s:bufno') && bufexists(s:bufno)
    exec 'silent' s:bufno . 'sbuf'
  else
    exec 'silent split ' . s:bufname
  endif
  let s:bufno = bufnr('%')

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal nolist
  setlocal noswapfile
  setlocal expandtab
  if exists('+cursorline') && (&cursorline || &cursorcolumn)
    " Cursor movement is not used in the Color Selector window, so turn off the
    " cursorline/column.
    setlocal nocursorline nocursorcolumn
    " Some users use an autocmd to turn on cursorline/column only for the
    " current window; suppress that, too.
    autocmd WinEnter <buffer> setlocal nocursorline nocursorcolumn
  endif
  call s:drawSwatch()
  call s:drawLegend()
  exec 'resize ' . (s:swatchSize + 2)

  syn match colorselKey " \(jk\|0bjlw\$\|[qxyX/f]\|\"xp/P\|\"xy/Y\) "ms=s+1,me=e-1
  syn match colorselColor "^|.\+|"ms=s+1,me=e-1
  syn match colorselRedS        "R \[" transparent nextgroup=colorselRed0
  syn match colorselGreenS      "G \[" transparent nextgroup=colorselGreen0
  syn match colorselBlueS       "B \[" transparent nextgroup=colorselBlue0
  syn match colorselHueS        "H \[" transparent nextgroup=colorselHue0
  syn match colorselSaturationS "S \[" transparent nextgroup=colorselSaturation0
  syn match colorselValueS      "V \[" transparent nextgroup=colorselValue0
  syn match colorselActive "->\u \[[^]]*\]<-" contains=colorselRedS,colorselGreenS,colorselBlueS,colorselHueS,colorselSaturationS,colorselValueS
  syn match colorselPaletteA "a:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteB "b:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteC "c:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteD "d:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteE "e:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteF "f:\x\{6} \{5}"ms=s+9
  syn match colorselPaletteG " \{5}g:\x\{6}"me=e-9
  syn match colorselPaletteH " \{5}h:\x\{6}"me=e-9
  syn match colorselPaletteI " \{5}i:\x\{6}"me=e-9
  syn match colorselPaletteJ " \{5}j:\x\{6}"me=e-9
  syn match colorselPaletteK " \{5}k:\x\{6}"me=e-9
  syn match colorselPaletteL " \{5}l:\x\{6}"me=e-9
  let i = 0
  while i < s:sliderSize
    let c = 'colorselRed'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let c = 'colorselGreen'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let c = 'colorselBlue'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let c = 'colorselHue'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let c = 'colorselSaturation'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let c = 'colorselValue'
    exec 'syn match ' . c . i . ' "[ #]" nextgroup=' . c . (i+1) . ' contained'
    let i = i+1
  endwhile
  call s:hiRGB()

  hi def colorselKey gui=bold
  hi def colorselActive gui=bold

  " vi-style controls
  nnoremap <buffer><silent> k :call <SID>activeUp()<cr>
  nnoremap <buffer><silent> j :call <SID>activeDown()<cr>
  nnoremap <buffer><silent> h :call <SID>dec()<cr>
  nnoremap <buffer><silent> l :call <SID>inc()<cr>
  nnoremap <buffer><silent> 0 :call <SID>begin()<cr>
  nnoremap <buffer><silent> $ :call <SID>end()<cr>
  nnoremap <buffer><silent> w :call <SID>pginc()<cr>
  nnoremap <buffer><silent> b :call <SID>pgdec()<cr>
  " loser-style controls ;-)
  nnoremap <buffer><silent> <up> :call <SID>activeUp()<cr>
  nnoremap <buffer><silent> <down> :call <SID>activeDown()<cr>
  nnoremap <buffer><silent> <left> :call <SID>dec()<cr>
  nnoremap <buffer><silent> <right> :call <SID>inc()<cr>
  nnoremap <buffer><silent> <home> :call <SID>begin()<cr>
  nnoremap <buffer><silent> <end> :call <SID>end()<cr>
  nnoremap <buffer><silent> <pageup> :call <SID>pginc()<cr>
  nnoremap <buffer><silent> <pagedown> :call <SID>pgdec()<cr>
  " other controls
  nnoremap <buffer><silent> p :call <SID>paste()<cr>
  nnoremap <buffer><silent> P :call <SID>pasteAlt()<cr>
  nnoremap <buffer><silent> y :call <SID>yank()<cr>
  nnoremap <buffer><silent> Y :call <SID>yankAlt()<cr>
  nnoremap <buffer><silent> x :call <SID>swapWithAlt()<cr>
  nnoremap <buffer><silent> X :call <SID>toggleForegroundEditing()<Bar>call <SID>update()<cr>
  nnoremap <buffer><silent> / :call <SID>setText()<cr>
  nnoremap <buffer><silent> f :call <SID>formatText()<cr>
  nnoremap <buffer><silent> q :close!<cr>

  call s:update()
endfun

" vim: set et ts=2 :
