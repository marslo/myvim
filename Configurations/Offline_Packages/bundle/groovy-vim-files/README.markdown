Usage
=====

First, backup your existing `.vim` directory:

    mv ~/.vim ~/.vim-backup

And backup your configuration files:

    mv ~/.vimrc ~/.vimrc-backup
    mv ~/.gvimrc ~/.gvimrc-backup

Now clone this repository:

    git clone git://github.com/mwaisgold/groovy-vim-files.git ~/.vim

In your `~/.vimrc` put this:

    source ~/.vim/vimrc.vim

And in your `~/.gvimrc` put this:

    source ~/.vim/gvimrc.vim

You may want to explore the `~/.vim/config` directory to see what's
included and `~/.vim/config/mappings.vim` to see how to use the
available tools.

Based on soveran's ruby plugin: http://github.com/soveran/vim-files
