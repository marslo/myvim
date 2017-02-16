" Open scratch files for Ruby (F1) and Mo (S-F1)
map <F1> :tabnew /tmp/sample.groovy<CR>:tabm 0<CR>
imap <F1> <ESC>:tabnew /tmp/sample.groovy<CR>:tabm 0<CR>

" Source current file
map <F2> :source %<CR>

" Open tasks
map <F3> :tabnew $HOME/.taskpaper<CR>:tabm 0<CR>

" Toggle spell
map <F4> <ESC>:set spell!<CR>
imap <F4> <ESC>:set spell!<CR>

" Execute files with Ruby 1.9
map <F6> <ESC>:w!<CR>:!ruby1.9 %<CR>
map <S-F6> <ESC>:w!<CR>:!ruby1.9 -c %<CR>

" Format selection with par
vmap <F8> :!par<CR>

" Toggle search highlight
map <F10> :set hlsearch!<CR>
imap <F10> <ESC>:set hlsearch!<CR>a

" Handle trailing whitespaces and tabs.
map <C-F11> <ESC>:%s/\s*$//g<CR>:%s/\t/  /<CR>

" Start and stop the webserver
map <Leader>start <ESC>:!thin start -R config.ru -d<CR>
map <Leader>stop  <ESC>:!thin stop<CR>

" Add magic comment for encoding
nmap <Leader>enc :set paste<CR>ggi# encoding: UTF-8<CR><CR><ESC>:set nopaste<CR>

" Open file under the cursor in new tab
map gf :tabe! <cfile><CR>
map gF :w! /tmp/spec.results<CR><C-W>gF<CR>

" Go to mark at the colum where the mark was set
map ' `

" Mimic command line editing
map <C-K> <ESC>d$
map <C-U> <ESC>d0
imap <C-A> <ESC>0i
imap <C-E> <ESC>$a

" Move between tabs
map <C-H> :tabp<CR>
map <C-L> :tabn<CR>

" Deactivate middle click
map <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>

" Deactivate recording
map q <Nop>

" Deactivate keyword lookup
map K <Nop>

" After a repeat operation, go back to the first character of the previously changed or yanked text
nmap . .`[

" Movement mappings
nmap j gj
nmap k gk
nmap gm g$

" Break the undo chain on every Space
imap <Space> <Space><C-g>u

" Insert a blank line above the current line
imap <C-K> <ESC>O

" Move left and right in insert mode
imap <C-L> <ESC>la
imap <C-H> <ESC>ha

" Open file in new tab
nmap <C-O> :tabe

" Run git blame in the current file and display results in the preview window.
map <C-G> :call PreviewResults("git blame " . expand("%"))<CR>

" Add estimations from taskpaper @estimation context
vmap <silent> <Leader>add :write !awk 'BEGIN { total = 0 }; /@estimate/ { total += $NF }; END { print "Total", total }'<CR>
