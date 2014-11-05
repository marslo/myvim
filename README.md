My Vim Config
===========
- Author: Marslo
- Email: marslo.jiao@gmail.com
- Version: 0.0.6
- LastChange: 2014-07-11 17:28:38

-----------------------------

## Content
- [Configuration](https://github.com/Marslo/VimConfig#compile-vimgvim-by-source-code-on-linuxubuntu)
    - English Version
        - [Usage](https://github.com/Marslo/VimConfig#usage)
        - [Shortcuts](https://github.com/Marslo/VimConfig#shortcuts)
        - [Plugins](https://github.com/Marslo/VimConfig#plugins)
    - 中文版本
        - [使用方法](https://github.com/Marslo/VimConfig#使用方法)
        - [快捷键](https://github.com/Marslo/VimConfig#快捷键)
        - [插件列表](https://github.com/Marslo/VimConfig#插件列表)
- [Compile or Build Vim/Gvim by source](https://github.com/Marslo/VimConfig#compile-vimgvim-by-source-code)
    - [In Linux(Ubuntu)](https://github.com/Marslo/VimConfig#in-linuxubuntu)
        - [Precondiction](https://github.com/Marslo/VimConfig#1-prepare-environment)
        - [Compile and Install](https://github.com/Marslo/VimConfig#2-compile-and-install)
        - [Make compiled vim as default text editor](https://github.com/Marslo/VimConfig#3-make-the-compiled-gvim-as-the-default-text-editor-in-ubunut)
        - [Q&A](https://github.com/Marslo/VimConfig#4-qa)
    - [In Windows (By Cygwin)](https://github.com/Marslo/VimConfig#in-linuxubuntu)
        - [Options in Cygwin](https://github.com/Marslo/VimConfig#mandatory-cygwin-options)
        - [Compile Command](https://github.com/Marslo/VimConfig#command)

## ScreenShots:
#### Linux Terminal (html) :
![Screenshot_Terminal](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenhost_Linux_Terminal.png?raw=true)
#### Linux Gvim (css):
![Screenshot_Gvim](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenhost_Linux_Gvim.png?raw=true)
#### Windows Gvim (python)
![Screenshot_Windows](https://github.com/Marslo/VimConfig/blob/master/Screenshots/screenshot_gvim.png?raw=true)
#### PuTTy (vimrc)
![Screenshot_PuTTy](https://github.com/Marslo/VimConfig/blob/master/Screenshots/screenshot_PuTTy.png?raw=true)

# Configuration
### Usage
- Windows User:
    - Copy **vimrc** from `VimConfig\Configurations\vimrc` into `C:\Program Files\Vim`, and rename **vimrc** to **_vimrc**
    - Get [Vundle](https://github.com/gmarik/vundle.git) automatically
        - Open Vim and execute (Ignore warning and errors)

                :GetVundle
    - Get the other plugins

            :BundleInstall!

- Linux User:
    - Copy **vimrc** from `VimConfig/Configurations/vimrc` into `$HOME`, and rename to **.vimrc**

        $ cp vimrc ~/.vimrc

    - Get [Vundle](https://github.com/gmarik/vundle.git) automatically

        $ cat .vimrc | grep "set rtp"
            set rtp+=$VIM/vimfiles/bundle/vundle
            set rtp+=~/.vim/bunle/vundle

        - Open Vim and Run (Ignore warnings and errors):

                :GetVundle

    - Get the other plugins

            :BundleInstall!

- Offline User:
    - For **vimrc** file
        - Windows User:
            - Copy **vimrc** from `VimConfig\configureations\vimrc` to `C:\Program Files (x86)\Vim` (64bit) or `C:\Program Files\Vim` (32bit), and rename to `_vimrc`
        - Linux User:
            - Copy **vimrc** from `VimConfig/Configuations/vimrc` into `$HOME`, and rename to `.vimrc`:

                    $ cp VimConfig/Configurations/vimrc ~/.vimrc

            - OR: Create Link file to `$HOME/.vimrc`:

                    $ ln -s <PATH_OF_VimConfig>/Configrations/vimrc ~/.vimrc
    - For **bundle** folder
        - Windows User: Copy **bundle** folder from `VimConfig/Configurations/Offline_Packages/bundle` to `C:\Program Files (x86)\Vim` (64bit) or `C:\Program Files\Vim` (Windows 32bit User)
        - Linux User: Copy **bundle** folder from `VimConfig/Configureations/Offline_Packages/bundle` to `$HOME/.vim` OR create link file

                $ cp -r VimConfig/Configureations/Offline_Package/bundle ~/.vim/
                OR
                $ ln -s <PATH_OF_VimConfig>/Configrations/Offline_Package/bundle ~/.vim/bundle

-----------------------------

### Open is Maximize
- Default maximze for Win32 user
- lwmctr must be installed for linux User. Download from: http://download.csdn.net/detail/jiaoxiaogu/4317843

### Shortcuts
- <kbd>F5</kbd>: Run Python, Ruby and Perl by one key! (The result could be shown in the Quickfix window)
- <kbd>\<leader\>aid</kbd>: Add the personal information

+++++++++++++++++++++++++++++++++++++++++++

- Auto Pair
- Auto compare code
    -  <kbd>\<leader\>fn</kbd>: insert current file name
    -  <kbd>\<leader\>fe</kbd>: insert current file name by suffix
    -  <kbd>\<leader\>tt</kbd>:  insert the current time
- Save and load the fold information automatic

+++++++++++++++++++++++++++++++++++++++++++

- Specified function shortcuts:
    - <kbd>F12</kbd>: Re-build tags file
    - <kbd>gf</kbd>: Open file which under the cursor (Add the .py suffix while the filetype == python)
    - <kbd>Alt</kbd> + <kbd>-</kbd>: Reduce the font
    - <kbd>Alt</kbd> + <kbd>+</kbd>: Enlarge the font
    - <kbd>cmd</kbd>: Open command line and cd into the current file path
    - <kbd>Alt</kbd> + <kbd>o</kbd>: Open the current file browser

+++++++++++++++++++++++++++++++++++++++++++

- Plugin shortcuts:
    - <kbd>\<leader\>tl</kbd>: Show the taglist
    - <kbd>\<leader\>mm</kbd>: Show winmanager
    - <kbd>\<leader\>ta</kbd>: Show Tagbar
    - <kbd>\<leader\>v</kbd>:  Open the configure file (_vimrc in windows and .vimrc in Linux)
    - <kbd>\<leader\>te</kbd>: Open the Tetris
    - <kbd>\<leader\>tv</kbd>: Open bash in the vim/gvim against Liunxu and open command line against Windows (Yes! That's true)
    - <kbd>\<leader\>u</kbd>: Open Gundo window
    - <kbd>pyli</kbd>: Static Code Analysis for python
    - <kbd>\<leader\>re</kbd>: Open the most recently used files
    - <kbd>\<leader\>x</kbd>: Comments/Uncomments

+++++++++++++++++++++++++++++++++++++++++++

- Emacs-style shortcuts:
    - <kbd>Ctrl</kbd> + <kbd>a</kbd>: Go to begin of the line  [Normal Mode && Insert Mode]
    - <kbd>Ctrl</kbd> + <kbd>e</kbd>: Go to end of the line [Normal Mode && Insert Mode]
    - <kbd>Alt</kbd> + <kbd>b</kbd>: Backward a word [Insert Mode]
    - <kbd>Alt</kbd> + <kbd>f</kbd>: Forward a word  [Insert Mode]
    - <kbd>Alt</kbd> + <kbd>d</kbd>: Delete a word (backward) [Insert Mode]
    - <kbd>Ctrl</kbd> + <kbd>w</kbd>: Delete a word (foreward) [Insert Mode]
    - <kbd>Ctrl</kbd> + <kbd>d</kbd>: Delete a char (backward) [Insert Mode] == [Delete]

+++++++++++++++++++++++++++++++++++++++++++

- Patten shortcuts:
    - <kbd>zdb</kbd>: Delete the backspace at the each of each line
    - <kbd>zmm</kbd>: Insert the line number
    - <kbd>zws</kbd>: Delete the blank line
    - <kbd>zdm</kbd>: Delete `^M` (<C-v><CR>)
    - <kbd>zng</kbd>: Show the number of searched words in last time
    - <kbd>zhh</kbd>: Delete all white space in the font of the line

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
- [python-mode](https://github.com/klen/python-mode)

#### For Ruby and RoR
- [vim-rails](https://github.com/tpope/vim-rails)
- [vim-ruby](https://github.com/vim-ruby/vim-ruby)

#### Theme and colors
- [Rainbow Parentheses Improved](https://github.com/luochen1990/rainbow)  | [Vim](http://www.vim.org/scripts/script.php?script_id=4176) | [Another Version](https://github.com/oblitum/rainbow)
- [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) | [Bug-Cannot work](https://github.com/hail2u/vim-css3-syntax/issues/20)
- [css.vim](https://github.com/JulesWang/css.vim)
- [scss-syntax.vim](https://github.com/cakebaker/scss-syntax.vim)

#### Not be used
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)          # Cannot work for vim74, using **vim-colorsque** instead
- [emmet.vim](https://github.com/mattn/emmet-vim)
- [ruby-matchit](https://github.com/vim-scripts/ruby-matchit)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)  # Replaced by [Rainbow Parentheses Improved](https://github.com/luochen1990/rainbow)
- [gui2term.py](http://www.vim.org/scripts/script.php?script_id=2778)
- [colorsel.vim](https://github.com/vim-scripts/colorsel.vim)

+++++++++++++++++++++++++++++++++++++++++++

The default Font named: Monaco, download form: http://download.csdn.net/detail/jiaoxiaogu/4317959

-----------------------------

###使用方法
- Windows用户
    - 复制 **Configurations\vimrc** 到 `C:\Program Files (x86)\Vim`, 且重命名为`_vimrc`
    - 自动获取 [Vundle](https://github.com/gmarik/vundle.git)
        - 打开vim(忽略错误或警告)

            :GetVundle

    - 获取其他插件

        :BundleInstall!

- Linux 用户:
    - 复制 **Configurations/vimrc** 到 `$HOME`, 且重命名为`.vimrc`

        $ cp Configurateions/vimrc ~/.vimrc

    - 自动获取 [Vundle](https://github.com/gmarik/vundle.git)
        - 打开Gvim且运行 (忽略错误或警告）

                :GetVundle

    - 获取其他插件

            :BundleInstall!

- 离线用户 (无法使用git用户)：
    - 对于**vimrc** 而言：
        - Windows用户： 复制 **VimConig\Configurations\vimrc** 到 `C:\Program Files (x86)\Vim` (64位) 或 `C:\Program Files\Vim` (32位), 且重命名为`_vimrc`
        - Linux用户:
            - 复制 **VimConfig/Configurations/vimrc** 到 `$HOME`, 且重命名为`.vimrc`

                    $ cp VimConfig/Configurations/vimrc ~/.vimrc

            - 或创建link文件`$HOME/.vimrc`

                    $ ln -s <PATH_OF_VimConfig>/Configrations/vimrc ~/.vimrc

    - 对于 **bundle** 目录
        - Windows用户： 复制 `VimConfig/Configurations/Offline_Packages/bundle` 目录到 `C:\Program Files (x86)\Vim` (64位) 或 `C:\Program Files\Vim` (32位)
        - Linux用户: 复制 `VimConfig/Configureations/Offline_Packages/bundle` 到 `$HOME/.vim` 或创建链接文件

                $ cp -r VimConfig/Configureations/Offline_Package/bundle ~/.vim/
                OR
                $ ln -s <PATH_OF_VimConfig>/Configrations/Offline_Package/bundle ~/.vim/bundle

-----------------------------

### 打开vim/gvim默认最大化
- Windows用户, 已默认开启最大化
- Linux用户，需要安装`lwmctr`。下载地址：http://download.csdn.net/detail/jiaoxiaogu/4317843

### 快捷键
- `F5`: 一键运行Python, Ruby 和 Perl。(运行结果将显示在Quickfix窗口中)

+++++++++++++++++++++++++++++++++++++++++++

### 主题请看Screenshot
- 自动配对
- 自动添加信息：
    - <kbd><leader>fn</kbd>: 添加当前文件名(无后缀，方便Java添加类名)
    - <kbd><leader>fe</kbd>: 添加当前文件名(有后缀，方便添加注释)
    - <kbd><leader>tt</kbd>: 添加当前时间
- 自动保存和加载折叠信息

+++++++++++++++++++++++++++++++++++++++++++

- 自定义函数快捷键
    - <kbd>F12</kbd>: 重新生成tags文件
    - <kbd>gf</kbd>: 打开光标下的单词为文件名 （若是python文件，则自动添加.py为后缀）
    - <kbd>Alt</kbd> + <kbd>-</kbd>: 缩小字体
    - <kbd>Alt</kbd> + <kbd>+</kbd>: 增大字体
    - <kbd>cmd</kbd>: 打开命令行，且自动cd到当前文件目录（Linux打开的为Terminal，Windows打开的为command line）
    - <kbd>Alt</kbd> + <kbd>o</kbd>: 打开文件浏览器， 且自动进入当前文档的目录 （Linux打开为Nautilus, Windows打开为Explorer）

+++++++++++++++++++++++++++++++++++++++++++

- 插件快捷键
    - <kbd>\<leader\>aid</kbd>: 自动添加用户信息
    - <kbd>\<leader\>tl</kbd>: 显示taglist
    - <kbd>\<leader\>mm</kbd>: 显示winmanager(附带taglist信息)
    - <kbd>\<leader\>ta</kbd>: 显示Tagbar
    - <kbd>\<leader\>v</kbd>: 打开配置文件(_vimrc/.vimrc)
    - <kbd>\<leader\>te</kbd>: 打开俄罗斯方块游戏(练习hjkl快捷键)
    - <kbd>\<leader\>tv</kbd>: 在vim/gvim中运行bash(是的，你没看错！)
    - <kbd>\<leader\>u</kbd>: 打开Gundo窗口
    - <kbd>pyli</kbd>: Python静态代码分析(规范代码，远离砍手砍脚)
    - <kbd>\<leader>re</kbd>: 打开最近文件列表（10个）
    - <kbd>\<leader\>x</kbd>: 注释/反注释

+++++++++++++++++++++++++++++++++++++++++++

- Emacs 风格快捷键
    - <kbd>Ctrl</kbd> + <kbd>a</kbd>: 光标移动到行首 [Normal模式 && 插入模式]
    - <kbd>Ctrl</kbd> + <kbd>e</kbd>: 光标移动到行尾 [Normal模式 && 插入模式]
    - <kbd>Alt</kbd> + <kbd>b</kbd>: 光标向前跳动一个单词 [插入模式]
    - <kbd>Alt</kbd> + <kbd>f</kbd>: 光标向前跳动一个单词 [插入模式]
    - <kbd>Alt</kbd> + <kbd>d</kbd>: 向前删除一个单词 [插入模式]
    - <kbd>Ctrl</kbd> + <kbd>w</kbd>: 向后删除一个单词 [插入模式]
    - <kbd>Ctrl</kbd> + <kbd>d</kbd>: 向后删除一个字符 [插入模式]

+++++++++++++++++++++++++++++++++++++++++++

- 正则表达式快捷键
    - <kbd>zdb</kbd>: 删除行尾空格
    - <kbd>zmm</kbd>: 插入文档行号
    - <kbd>zws</kbd>: 删除空行
    - <kbd>zdm</kbd>: 删除`^M`
    - <kbd>zng</kbd>: 显示最后一次搜索内容的个数
    - <kbd>zhh</kbd>: 删除行前的空白（缩进，空格，等）


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
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540) | [原Github地址](https://github.com/garbas/vim-snipmate) | [Marslo](https://github.com/Marslo/snipmate.vim)
- [python-syntax](https://github.com/hdima/python-syntax) | [Marslo增强版](https://github.com/Marslo/python-syntax)
- [vim-coloresque](https://github.com/gorodinskiy/vim-coloresque) | [Marslo增强版](https://github.com/Marslo/vim-coloresque)

#### Python插件
- [pyflakes.vim](https://github.com/vim-scripts/pyflakes.vim)
- [python_fold.vim](https://github.com/vim-scripts/python_fold)
- [python-mode](https://github.com/klen/python-mode)

#### Ruby和RoR插件
- [vim-rails](https://github.com/tpope/vim-rails)
- [vim-ruby](https://github.com/vim-ruby/vim-ruby)

#### 主题以及颜色
- [Rainbow Parentheses Improved](https://github.com/oblitum/rainbow) | [Another Version](https://github.com/luochen1990/rainbow)
- [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax)
- [css.vim](https://github.com/JulesWang/css.vim)
- [scss-syntax.vim](https://github.com/cakebaker/scss-syntax.vim)

#### 未被使用的（曾被使用）
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)                      # 不支持Vim74， 使用[vim-colorsque](https://github.com/Marslo/vim-coloresque) 替代
- [emmet.vim](https://github.com/mattn/emmet-vim)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)    # 已经替换成 [Rainbow Parentheses Improved](http://www.vim.org/scripts/script.php?script_id=4176) | [Github repo](https://github.com/luochen1990/rainbow)
- [colorsel.vim](https://github.com/vim-scripts/colorsel.vim)
- [gui2term.py](http://www.vim.org/scripts/script.php?script_id=2778)

+++++++++++++++++++++++++++++++++++++++++++

默认字体为： Monaco, 下载地址: http://download.csdn.net/detail/jiaoxiaogu/4317959

# Compile VIM/GVIM by source code
## In Linux(Ubuntu)
### 1. Prepare environment:
#### 1.1. Downaload vim source code:
Download source from:
- [b4winckler](https://github.com/b4winckler/vim.git):

        $ git clone git@github.com:b4winckler/vim.git
        $ git clone https://github.com/b4winckler/vim.git

- [vim-jp](https://github.com/vim-jp/vim)

        $ git clone git@github.com:vim-jp/vim.git
        $ git clone https://github.com/vim-jp/vim.git

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

    $ sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev

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

    $ cd vim
    $ ./configure --with-x --enable-gui=gnome2 --enable-cscope --enable-multibyte --enable-xim --enable-fontset --with-features=huge --enable-pythoninterp=yes --enable-rubyinterp=yes --enable-python3interp=yes --prefix=/home/marslo/Tools/Software/vim74/ --with-compiledby=Marslo --enable-gnome-check
    $ make
    $ sudo make install

#### 2.3. Set the PATH

    $ cat >> ~/.bashrc << EOF
    > export PATH=/home/marslo/Tools/Software/vim74/:$PATH
    > EOF
    $ vim --version
    VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Sep 25 2013 15:31:13)
    Included patches: 1-35
    Compiled by Marslo
    Huge version with GTK2-GNOME GUI.  Features included (+) or not (-):
    ....

### 3. Make the compiled Gvim as the default text editor in Ubunut:
- Copy `applications/gvim.desktop` and `application/defaults.list` to `/usr/share/applications/`
$ cp /usr/share/applications/defaults.list /usr/share/applications/defaults_bak.list`
$ cp applications/gvim.desktop /usr/share/applications/
$ cp -f applications/defaults.list /usr/share/applications/

- Make gvim.desktop can find the gvim icon (it will be shown as bellow):
$ cat gvim.desktop
...
Icon=/home/marslo/Tools/Software/Vim/applications/gvim.png
...

- An fully [gvim.desktop](http://mirrors2.kernel.org/slackware/slackware-14.0/source/ap/vim/gvim.desktop)


### 4. Q&A
4.1 ncurses:
- Problem:

        no terminal library found
        You need to install a terminal library; for example ncurses.
        Or specify the name of the library with --with-tlib.

- Soluction:
    - For Ubuntu/Debain:

            $ sudo apt-get install libncurses5-dev

    - For RHEL/CentOS:


            $ sudo yum install ncurses-devel


4.2 C compiler
- Problem:

        no acceptable C compiler found in $PATH

- Soluction:
    - For Ubuntu/Debain:

            $ sudo apt-get update && sudo apt-get install build-essential

4.3 [Git clone https problem](http://stackoverflow.com/questions/10928215/git-push-error-fatal-unable-to-find-remote-helper-for-https/12012504#12012504)
- Problem:

        "fatal: Unable to find remote helper for 'http'"
- Soluction:
    - Fur Ubuntu/Debain:

            $ sudo apt-get install libcurl4-openssl-dev

## In Windws (By Cygwin)
### Mandatory Cygwin options
- Dev stuff:
    - Mandatory
        - gcc / gcc-g++
        - make
        - [ncurses](https://stackoverflow.com/questions/9959243/building-vim-from-source-in-cygwin)
    - Optional
        - Flex
        - bison
        - gettext / gettext-devel
        - textinfo

### Command:
- For GVIM:

        $ make -B -f Make_cyg.mak PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python34 DYNAMIC_PYTHON3=yes PYTHON3_VER=34 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=yes
- For VIM:

        $ make -B -f Make_cyg.mak PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python34 DYNAMIC_PYTHON3=yes PYTHON3_VER=34 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=no
