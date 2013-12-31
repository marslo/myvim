MyVimConfig
===========
- Author: Marslo
- Email: marslo.jiao@gmail.com
- Version: 0.0.5
- LastChange: 2013-11-21 18:59:56

-----------------------------

## Content
- [Compile vim/gvim by source code](https://github.com/Marslo/VimConfig#compile-vimgvim-by-source-code-on-linuxubuntu)
    - [Precondiction](https://github.com/Marslo/VimConfig#1-prepare-environment)
    - [Compile and Install](https://github.com/Marslo/VimConfig#2-compile-and-install)
    - [Make compiled vim as default text editor](https://github.com/Marslo/VimConfig#3-make-the-compiled-gvim-as-the-default-text-editor-in-ubunut)
    - [Q&A](https://github.com/Marslo/VimConfig#4-qa)
- [Configuration](https://github.com/Marslo/VimConfig#compile-vimgvim-by-source-code-on-linuxubuntu)
    - English Version
        - [Usage](https://github.com/Marslo/VimConfig#usage)
        - [Shortcuts](https://github.com/Marslo/VimConfig#shortcuts)
        - [Plugins](https://github.com/Marslo/VimConfig#plugins)
    - 中文版本
        - [使用方法](https://github.com/Marslo/VimConfig#使用方法)
        - [快捷键](https://github.com/Marslo/VimConfig#快捷键)
        - [插件列表](https://github.com/Marslo/VimConfig#插件列表)

## ScreenShots:
### Ubuntu(Ubuntu):
![Screenshot_Ubuntu](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenshots_Ubuntu.png?raw=true)
### Windows
![Screenshot_Windows](https://github.com/Marslo/VimConfig/blob/master/Screenshots/screenshot_gvim.png?raw=true)

## Compile VIM/GVIM by source code on Linux(Ubuntu)
### 1. Prepare environment:
#### 1.1. Downaload vim source code:
Download source from [git](https://github.com/b4winckler/vim.git):
<pre><code>$ git clone https://github.com/b4winckler/vim.git
</code></pre>
#### 1.2. Install Necessary libs for GUI:
- libatk1.0-dev
- libbonoboui2-dev
- libcairo2-dev
- libgnome2-dev
- libgnomeui-dev
- libgtk2.0-dev
- libncurses5-dev
- libxpm-dev
- libx11-dev
- libxt-dev

##### Install necessary libs by the command as below:
<pre><code>$ sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
</code></pre>

### 2. Compile and Install:
#### 2.1 Arugs:
- Installation directories:
    - `--prefix=PREFIX`:        install architecture-independent files in PREFIX
                                Default directory: [/usr/local]
- Optional Features:
    - `--enable-gui=OPTS`:     X11 GUI default=auto OPTS=auto/no/gtk2/gnome2/motif/athena/neXtaw/photon/carbon
    - `--enable-gnome-check`:  If GTK GUI, check for GNOME default=no
    - `--enable-fontset`:      Include X fontset output support
    - `--enable-xim`:          Include XIM input support
    - `--enable-cscope`:       Include cscope interface
    - `--enable-pythoninterp=OPTS`:  Include Python interpreter. default=no OPTS=no/yes/dynamic
    - `--enable-python3interp=OPTS`: Include Python3 interpreter. default=no OPTS=no/yes/dynamic
    - `--enable-rubyinterp=OPTS`:    Include Ruby interpreter.  default=no OPTS=no/yes/dynamic
    - `--enable-multibyte`:          Include multibyte editing support
- Optional Packages:
    - `--with-x`:                use the X Window System
    - `--with-compiledby=NAME`:  name to show in :version message
    - `--with-features=TYPE`:    tiny, small, normal, big or huge (default: normal)

#### 2.2. Commands
<pre><code>$ cd vim
$ ./configure --with-x --enable-gui=gnome2 --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-features=huge --enable-pythoninterp=yes --enable-rubyinterp=yes --enable-python3interp=yes --prefix=/home/marslo/Tools/Software/vim74/ --with-compiledby=Marslo --enable-gnome-check
$ make
$ sudo make install
</code></pre>

#### 2.3. Set the PATH
<pre><code>$ cat >> ~/.bashrc << EOF
> export PATH=/home/marslo/Tools/Software/vim74/:$PATH
> EOF
$ vim --version
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Sep 25 2013 15:31:13)
Included patches: 1-35
Compiled by Marslo
Huge version with GTK2-GNOME GUI.  Features included (+) or not (-):
....
</code></pre>

### 3. Make the compiled Gvim as the default text editor in Ubunut:
- Copy `applications/gvim.desktop` and `application/defaults.list` to `/usr/share/applications/`
<pre><code>$ cp /usr/share/applications/defaults.list /usr/share/applications/defaults_bak.list`
$ cp applications/gvim.desktop /usr/share/applications/
$ cp -f applications/defaults.list /usr/share/applications/
</code></pre>
- Make gvim.desktop can find the gvim icon (it will be shown as bellow):
<pre><code>$ cat gvim.desktop
...
Icon=/home/marslo/Tools/Software/Vim/applications/gvim.png
...
</code></pre>
- An fully [gvim.desktop](http://mirrors2.kernel.org/slackware/slackware-14.0/source/ap/vim/gvim.desktop)


### 4. Q&A
4.1 ncurses:
- Problem:
    <pre><code>You need to install a terminal library; for example ncurses.
    Or specify the name of the library with --with-tlib.
    </code></pre>
- Soluction:
    <pre></code>$ sudo apt-get install libncurses5-dev
    </code></pre>

4.2 C compiler
- Problem:
    <pre><code>no acceptable C compiler found in $PATH</code></pre>
- Soluction:
    <pre><code>$ sudo apt-get update && sudo apt-get install build-essential</code></pre>


# Configuration
### Usage
- Windows User:
    - Copy **_vimrc** from into `C:\Program Files\Vim`.
    - Get [Vundle](https://github.com/gmarik/vundle.git) automatically
        - Open Vim and execute (Ignore warning and errors)
            <pre><code>:call GetVundle()
            </code></pre>
    - Get the other plugins
        <pre><code>:BundleInstall!
        </code></pre>

- Linux User:
    - Copy **.vimrc** into `$HOME`
    <pre><code>$ cp .vimrc ~/
    </code></pre>
    - Get [Vundle](https://github.com/gmarik/vundle.git) automatically
        <pre><code>$ cat .vimrc | grep "set rtp"
            set rtp+=$VIM/vimfiles/bundle/vundle
            set rtp+=~/.vim/bunle/vundle
        </code></pre>
        - Open Vim and Run (Ignore warnings and errors):
            <pre><code>:call GetVundle()
            </code></pre>
    - Get the other plugins
        <pre><code>:BundleInstall!
        </code></pre>


-----------------------------

### Open is Maximize
- Default maximze for Win32 user
- lwmctr must be installed for linux User. Download from: http://download.csdn.net/detail/jiaoxiaogu/4317843

### Shortcuts
- `F5`: Run Python, Ruby and Perl by one key! (The result could be shown in the Quickfix window)
- `F3`: Open the tagbar
- `<leader>aid`: Add the personal information

+++++++++++++++++++++++++++++++++++++++++++

- Auto Pair
- Auto compare code
    -  `<leader>fn`: insert current file name
    -  `<leader>fe`: insert current file name by suffix
    -  `<leader>tt`:  insert the current time
- Save and load the fold information automatic

+++++++++++++++++++++++++++++++++++++++++++

- Specified function shortcuts:
    - `<F12>`: Re-build tags file
    - `gf`: Open file which under the cursor (Add the .py suffix while the filetype == python)
    - `Alt + -`: Reduce the font
    - `Alt + +`: Enlarge the font
    - `cmd`: Open command line and cd into the current file path
    - `Alt + o`: Open the current file browser

+++++++++++++++++++++++++++++++++++++++++++

- Plugin shortcuts:
    - `tl`:     Show the taglist
    - `wm`:     Show winmanager
    - `<leader>v`:     Open the configure file (_vimrc in windows and .vimrc in Linux)
    - `<leader>te`:    Open the Tetris
    - `<leader>tv`:     Open bash in the vim/gvim against Liunxu and open command line against Windows (Yes! That's true)
    - `pyli`:   Static Code Analysis for python
    - `ctrl + g`:     Open the most recently used files
    - `<leader>v`: Comments/Uncomments
    - `gl`: Enter

+++++++++++++++++++++++++++++++++++++++++++

- Emacs-style shortcuts:
    - `Ctrl + a`: Go to begin of the line  [Normal Mode && Insert Mode]
    - `Ctrl + e`: Go to end of the line [Normal Mode && Insert Mode]
    - `Alt + b`: Backward a word [Insert Mode]
    - `Alt + f`: Forward a word  [Insert Mode]
    - `Alt + d`: Delete a word (backward) [Insert Mode]
    - `Ctrl + w`: Delete a word (foreward) [Insert Mode]

+++++++++++++++++++++++++++++++++++++++++++

- Partten shortcuts:
    - `zdb`: Delete the backspace at the each of each line
    - `zmm`: Insert the line number

### Plugins:
- [AuthorInfo](https://github.com/dantezhu/authorinfo)
- [Conque Term](https://github.com/vim-scripts/Conque-Shell)
- [MiniBufExpl](http://www.vim.org/scripts/script.php?script_id=159)
- [mru](https://github.com/vim-scripts/mru.vim)
- [ctrlp](https://github.com/kien/ctrlp.vim)
- [TagBar](http://majutsushi.github.io/tagbar/)
- [TagList](http://vim-taglist.sourceforge.net/)
- [TeTrIs](https://github.com/vim-scripts/TeTrIs.vim)
- [WinManager](https://github.com/vim-scripts/winmanager)
- [IndentLine](https://github.com/Yggdroot/indentLine)
- [Vim Bunlde](https://github.com/gmarik/vundle)
- [vim-pathogen](https://github.com/tpope/vim-pathogen)
- [supertab](https://github.com/ervandew/supertab)
- [MatchTag](https://github.com/gregsexton/MatchTag)
- [txt.vim](https://github.com/vim-scripts/txt.vim)

#### Enhanced by Myself
- [marslo.vim](https://github.com/Marslo/marslo.vim)
- [EnhancedCommentify](https://github.com/hrp/EnhancedCommentify) | [EnhancedByMarslo](https://github.com/Marslo/EnhCommentify.vim)
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540) | [Github](https://github.com/garbas/vim-snipmate) | [EnhancedByMarslo](https://github.com/Marslo/snipmate.vim)
- [python-syntax](https://github.com/hdima/python-syntax) | [EnhancedByMarslo](https://github.com/Marslo/python-syntax)
- [vim-coloresque](https://github.com/gorodinskiy/vim-coloresque) | [EnhancedByMarslo](https://github.com/Marslo/vim-coloresque)

#### For Python
- [pyflakes.vim](https://github.com/vim-scripts/pyflakes.vim)
- [python_fold.vim](https://github.com/vim-scripts/python_fold)

#### For Ruby and RoR
- [vim-rails](https://github.com/tpope/vim-rails)
- [vim-ruby](https://github.com/vim-ruby/vim-ruby)

#### Theme and colors
- [Rainbow Parentheses Improved](http://www.vim.org/scripts/script.php?script_id=4176) | [Github Repo](https://github.com/luochen1990/rainbow)
- [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax)
- [colorsel.vim](https://github.com/vim-scripts/colorsel.vim)
- [css.vim](https://github.com/JulesWang/css.vim)
- [vim-colorsque](https://github.com/gorodinskiy/vim-coloresque)
- [gui2term.py](http://www.vim.org/scripts/script.php?script_id=2778)

#### Not be used
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)          # Cannot work for vim74, using **vim-colorsque** instead
- [emmet.vim](https://github.com/mattn/emmet-vim)
- [ruby-matchit](https://github.com/vim-scripts/ruby-matchit)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)  # Replaced by [Rainbow Parentheses Improved](http://www.vim.org/scripts/script.php?script_id=4176)

+++++++++++++++++++++++++++++++++++++++++++

The default Font named: Monaco, download form: http://download.csdn.net/detail/jiaoxiaogu/4317959

-----------------------------

###使用方法
- Windows用户
    - 复制 **Configurations\Win\Vim74_Vundle\_vimrc** 到 `C:\Program Files (x86)\Vim`
    - 自动获取 [Vundle](https://github.com/gmarik/vundle.git)
        - 打开vim(忽略错误或警告)
            <pre><code>:call GetVundle()
            </code></pre>
    - 获取其他插件
        <pre><code>:BundleInstall!
        </code></pre>

- Linux 用户:
    - 复制 **Configurations\Linux\Vim74_vundle\.vimrc** 到 `$HOME`
        <pre><code>$ cp Linux/Vim74_vundle/.vimrc ~/
        </code></pre>
    - 自动获取 [Vundle](https://github.com/gmarik/vundle.git)
        - 打开Gvim且运行 (忽略错误或警告）：
            <pre><code>:call GetVundle()
            </code></pre>
    - 获取其他插件
        <pre><code>:BundleInstall!
        </code></pre>

-----------------------------

### 打开vim/gvim默认最大化
- Windows用户, 已默认开启最大化
- Linux用户，需要安装`lwmctr`。下载地址：http://download.csdn.net/detail/jiaoxiaogu/4317843

### 快捷键
- `F5`: 一键运行Python, Ruby 和 Perl。(运行结果将显示在Quickfix窗口中)
- `F3`: 打开tagbar
- `<leader>aid`: 自动添加用户信息

+++++++++++++++++++++++++++++++++++++++++++

### 主题请看Screenshot
- 自动配对
- 自动添加信息：
    - `<leader>fn`: 添加当前文件名(无后缀，方便Java添加类名)
    - `<leader>fe`: 添加当前文件名(有后缀，方便添加注释)
    - `<leader>tt`: 添加当前时间
- 自动保存和加载折叠信息

+++++++++++++++++++++++++++++++++++++++++++

- 自定义函数快捷键
    - `<F12>`: 重新生成tags文件
    - `gf`: 打开光标下的单词为文件名 （若是python文件，则自动添加.py为后缀）
    - `Alt + -`: 缩小字体
    - `Alt + +`: 增大字体
    - `cmd`: 打开命令行，且自动cd到当前文件目录（Linux打开的为Terminal，Windows打开的为command line）
    - `Alt + o`: 打开文件浏览器， 且自动进入当前文档的目录 （Linux打开为Nautilus, Windows打开为Explorer）

+++++++++++++++++++++++++++++++++++++++++++

- 插件快捷键
    - `tl`: 显示taglist
    - `mm`: 显示winmanager(附带taglist信息)
    - `<leader>v`: 打开配置文件(_vimrc/.vimrc)
    - `<leader>te`: 打开俄罗斯方块游戏(练习hjkl快捷键)
    - `<leader>tv`: 在vim/gvim中运行bash(是的，你没看错！)
    - `pyli`: Python静态代码分析(规范代码，远离砍手砍脚)
    - `ctrl + g`: 打开最近文件列表（10个）
    - `<leader>v`: 注释/反注释

+++++++++++++++++++++++++++++++++++++++++++

- Emacs 风格快捷键
    - `Ctrl + a`: 光标移动到行首 [Normal模式 && 插入模式]
    - `Ctrl + e`: 光标移动到行尾 [Normal模式 && 插入模式]
    - `Alt + b`: 光标向前跳动一个单词 [插入模式]
    - `Alt + f`: 光标向前跳动一个单词 [插入模式]
    - `Alt + d`: 向前删除一个单词 [插入模式]
    - `Ctrl + w`: 向后删除一个单词 [插入模式]

+++++++++++++++++++++++++++++++++++++++++++

- 正则表达式快捷键
    - `zdb`: 删除行尾空格
    - `zmm`: 插入文档行号

### 插件列表：
- [AuthorInfo](https://github.com/dantezhu/authorinfo)
- [Conque Term](https://github.com/vim-scripts/Conque-Shell)
- [MiniBufExpl](http://www.vim.org/scripts/script.php?script_id=159)
- [mru](https://github.com/vim-scripts/mru.vim)
- [ctrlp](https://github.com/kien/ctrlp.vim)
- [TagBar](http://majutsushi.github.io/tagbar/)
- [TagList](http://vim-taglist.sourceforge.net/)
- [TeTrIs](https://github.com/vim-scripts/TeTrIs.vim)
- [WinManager](https://github.com/vim-scripts/winmanager)
- [IndentLine](https://github.com/Yggdroot/indentLine)
- [vim-pathogen](https://github.com/tpope/vim-pathogen)
- [supertab](https://github.com/ervandew/supertab)
- [MatchTag](https://github.com/gregsexton/MatchTag)
- [txt.vim](https://github.com/vim-scripts/txt.vim)

#### 我修改后的增强版
- [marslo.vim](https://github.com/Marslo/marslo.vim)
- [EnhancedCommentify](https://github.com/hrp/EnhancedCommentify) | [Marslo增强版](https://github.com/Marslo/EnhCommentify.vim)
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540) | [Github](https://github.com/garbas/vim-snipmate) | [Marslo](https://github.com/Marslo/snipmate.vim)
- [python-syntax](https://github.com/hdima/python-syntax) | [Marslo增强版](https://github.com/Marslo/python-syntax)
- [vim-coloresque](https://github.com/gorodinskiy/vim-coloresque) | [Marslo增强版](https://github.com/Marslo/vim-coloresque)

#### Python插件
- [pyflakes.vim](https://github.com/vim-scripts/pyflakes.vim)
- [python_fold.vim](https://github.com/vim-scripts/python_fold)

#### Ruby和RoR插件
- [vim-rails](https://github.com/tpope/vim-rails)
- [vim-ruby](https://github.com/vim-ruby/vim-ruby)

#### 主题以及颜色
- [Rainbow Parentheses Improved](http://www.vim.org/scripts/script.php?script_id=4176) | [Github Repo](https://github.com/luochen1990/rainbow)
- [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax)
- [colorsel.vim](https://github.com/vim-scripts/colorsel.vim)
- [css.vim](https://github.com/JulesWang/css.vim)
- [vim-colorsque](https://github.com/gorodinskiy/vim-coloresque)
- [gui2term.py](http://www.vim.org/scripts/script.php?script_id=2778)

#### 未被使用的（曾被使用）
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)                      # 不支持Vim74， 使用**vim-colorsque**替代
- [emmet.vim](https://github.com/mattn/emmet-vim)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)    # 已经替换成 [Rainbow Parentheses Improved](http://www.vim.org/scripts/script.php?script_id=4176)

+++++++++++++++++++++++++++++++++++++++++++

默认字体为： Monaco, 下载地址: http://download.csdn.net/detail/jiaoxiaogu/4317959