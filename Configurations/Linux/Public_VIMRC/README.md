Public VIM Settings
=================
- Author: Marslo
- Email: marslo.vida@gmail.com
- Created: 2013-10-16 15:03:22
- Version: 0.0.1
- LastChange: 2013-10-16 15:03:22
- History:
    - 0.0.1 | Marslo | init

# Description:
Public VIM Settings is for those user, they using a public server with other guys. It's not advisabled to changeing the default configuration.
However, using the Public vim setting will using the userself configure without changing default one.

# Usage:

## For example:
- Custom folder located at: $HOME/Marslo

## The bundle one
- Copy **.vimrc** file to **$HOME/Marslo**
- Copy **.vim_bundle** folder to **$HOME/Marslo** (The **colors** folder will be used)
<pre><code>$ cp -r .vim_bundle $HOME/Marslo/.vim
</code></pre>
- Git Clone the Bundle to local:
<pre><code>$ git clone https://github.com/gmarik/vundle.git $HOME/Marslo/.vim/bunle/vundle
</code></pre>
    - The local path got from the setting in .vimrc:
    <pre><code>set rtp+=$HOME/Marslo/.vim/bunle/vundle
    </code></pre>
- And Run `:BundleInstall` in vim

## Using the latest vim
- The version in **.vim_bundle\tools** is **7.4.52**
- Download vim source for compiled the latest one
<pre><code>$ git clone git@github.com:b4winckler/vim.git .vim/src/vim
</code></pre>
- Run **.upgrade_gvim** (https://github.com/woainvzu/MarsloLinuxStuff/blob/master/Scripts/.upgrade_gvim)
<pre><code>$ ./.upgrade_gvim
</code></pre>
