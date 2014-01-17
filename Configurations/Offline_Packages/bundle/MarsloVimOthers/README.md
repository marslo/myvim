Marslo Vim Others
==========

## The pursor is for some git plugins:
- vimtweak
- conquesterm
<pre><code>:so %</code></pre>
- ctags

## About Gvim Colors:
- Inspired by http://vim.wikia.com/wiki/View_all_colors_available_to_gvim

## vimtweak.dll
### Links
- [Github](https://github.com/mattn/vimtweak)
- [VimPlugin](http://www.vim.org/scripts/script.php?script_id=687)

### Usage
- Put **vimtweak.dll** to vim runtime directory (same as vim.exe)
- Official usage
<pre><code>Alpha Window:
  200/255 alpha
  :call libcallnr("vimtweak.dll", "SetAlpha", 200)
  reset alpha
  :call libcallnr("vimtweak.dll", "SetAlpha", 255)

Maximized Window:
  Enable
  :call libcallnr("vimtweak.dll", "EnableMaximize", 1)
  Disable
  :call libcallnr("vimtweak.dll", "EnableMaximize", 0)

TopMost Window:
  Enable
  :call libcallnr("vimtweak.dll", "EnableTopMost", 1)
  Disable
  :call libcallnr("vimtweak.dll", "EnableTopMost", 0)
</code></pre>

## conqueterm_2.2.vmb
### Link
- [VimPlugin](http://www.vim.org/scripts/script.php?script_id=2771)

### Usage
- Installation:
<pre><code>:so %</code></pre>
- Official usage:
<pre><code>Type :ConqueTerm <command> to run your command in vim, for example:
:ConqueTerm bash
:ConqueTerm mysql -h localhost -u joe -p sock_collection
:ConqueTerm Powershell.exe
:ConqueTerm C:\Python27\python.exe
To open ConqueTerm in a new horizontal or vertical buffer use:
:ConqueTermSplit <command>
:ConqueTermVSplit <command>
:ConqueTermTab <command>
</code></pre>

