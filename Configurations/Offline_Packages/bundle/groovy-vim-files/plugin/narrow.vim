" ****************************************************************************
" File:             narrow.vim
" Author:           Jonas Kramer
" Version:          0.1
" Last Modified:    2008-11-17
" Copyright:        Copyright (C) 2008 by Jonas Kramer. Published under the
"                   terms of the Artistic License 2.0.
" ****************************************************************************
" Installation: Copy this script into your plugin folder.
" Usage: Call the command :Narrow with a range to zoom into the range area.
" Call :Widen to zoom out again.
" WARNING! Be careful when doing undo operations in a narrowed buffer. If you
" undo the :Narrow action, :Widen will fail miserable and you'll probably have
" the hidden parts doubled in your buffer. The 'u' key is remapped to a save
" undo function, but you can still mess this plugin up with :earlier, g- etc.
" Also make sure that you don't mess with the buffers autocmd BufWriteCmd
" hook, as it is set to a function that allows saving of the whole buffer
" instead of only the narrowed region in narrowed mode. Otherwise, when saving
" in a narrowed buffer, only the region you zoomed into would be saved.
" ****************************************************************************

if exists('g:loadedNarrow')
	finish
endif

let s:savedOptions = &cpoptions
set cpoptions&vim


fu! narrow#Narrow(rb, re)
	if exists('b:narrowData')
		echo "Buffer is already narrowed. Widen first, then select a new region."
	else
		" Save modified state.
		let modified = &l:modified

		let b:narrowData = { "pre": [], "post": [] }


		" Store buffer contents and remove everything outside the range.
		if a:re < line("$")
			let b:narrowData["post"] = getline(a:re + 1, "$")
			exe "silent " . (a:re + 1) . ",$d _"
		end

		if a:rb > 1
			let b:narrowData["pre"] = getline(1, a:rb - 1)
			exe "silent 1," . (a:rb - 1) . "d _"
		end


		let b:narrowData["change"] = changenr()

		augroup plugin-narrow
			au BufWriteCmd <buffer> call narrow#Save()
		augroup END

		" If buffer wasn't modified, unset modified flag.
		if !modified
			setlocal nomodified
		en

		echo "Narrowed. Be careful with undo/time travelling."
	endi
endf


fu! narrow#Widen()
	if exists('b:narrowData')
		" Save modified state.
		let modified = &l:modified

		" Save position.
		let pos = getpos(".")

		" Calculate cursor position based of the length of the inserted
		" content, so the cursor doesn't move when widening.
		let pos[1] = pos[1] + len(b:narrowData["pre"])

		call append(0, b:narrowData["pre"])
		call append(line('$'), b:narrowData["post"])

		" Restore save command.
		augroup plugin-narrow
			au! BufWriteCmd <buffer>
		augroup END

		" If buffer wasn't modified, unset modified flag.
		if !modified
			setlocal nomodified
		en

		" Restore cursor position.
		call setpos('.', pos)
		unlet b:narrowData

		echo "Buffer restored."
	else
		echo "No buffer to widen."
	endi
endf


" Function to use instead of Vims builting save command, so we can save the
" whole buffer instead of only the narrowed region in it as Vim would do.
fu! narrow#Save()
	let name = bufname("%")

	if exists('b:narrowData')

		" Prepare full buffer content to save.
		let content = copy(b:narrowData.pre)
		let content = extend(content, copy(getline(1, "$")))
		let content = extend(content, copy(b:narrowData.post))

		" Write file and hope for the best.
		call writefile(content, name)
		setlocal nomodified

		echo "Whee! I really hope that file is saved now!"
	endi
endf


" Wrapper around :undo to make sure the user doesn't undo the :Narrow command,
" which would break :Widen.
fu! s:safeUndo()
        if exists('b:narrowData')
		let pos = getpos(".")

		silent undo

		if changenr() < b:narrowData["change"]
			silent redo
			echo "I told you to be careful with undo! Widen first."
			call setpos(".", pos)
		en
	else
		undo
	en
endf


command! -bar -range Narrow call narrow#Narrow(<line1>, <line2>)
command! -bar Widen call narrow#Widen()

silent! nnoremap <silent> u  :<C-u>call <SID>safeUndo()<CR>


let &cpoptions = s:savedOptions
unlet s:savedOptions

let g:loadedNarrow = 1
