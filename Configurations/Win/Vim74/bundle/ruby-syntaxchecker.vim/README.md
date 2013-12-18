ruby-syntaxchecker.vim
======================

ruby syntax checker, toggles a quickfix window with the error list

##description##
You need to install ruby
It's a simple program that just checks if your ruby code have any syntax warning or error.

Pressing F4 will run it using the "quickfix" feature. 
This way you can "navigate" through errors using :cn and other standard commands. 


##install details##
just put the file in your ~/.vim/ftplugin/ruby directory (if that doesn't exist, create it) 

The default mapping is F4, you can change it putting 
    let g:ruby_syntaxcheck_map='whatever' 
in your vimrc

