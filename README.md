MyVimConfig
===========
Author: Marslo    
Email: marslo.vida@gmail.com    
Version: 0.0.4    
LastChange: 2013-10-29 09:48:48   

-----------------------------
## ScreenShots:
### Ubuntu(Ubuntu):
![Screenshot_Ubuntu](https://github.com/Marslo/VimConfig/blob/master/Screenshots/screenshot_gvim.png?raw=true)
### Windows
![Screenshot_Windows](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenshots_Ubuntu.png?raw=true)


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

# Configuration
### Usage
- Windows User:
    - Copy **_vimrc** from into `C:\Program Files\Vim`.
    - Get [Vundle](https://github.com/gmarik/vundle.git)
        - <del>>> git clone https://github.com/gmarik/vundle.git "C:\Program Files (x86)\vim\vimfiles"</del>
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
    - Get [Vundle](https://github.com/gmarik/vundle.git)
        <pre><code>$ cat .vimrc | grep "set rtp"
            set rtp+=$VIM/vimfiles/bundle/vundle
            set rtp+=~/.vim/bunle/vundle
        </code></pre>
        <del>$ git clone https://github.com/gmarik/vundle.git ~/.vim</del>
        - Open Vim and Run (Ignore warnings and errors):
            <pre><code>:call GetVundle()
            </code></pre>
    - Get the other plugins
        <pre><code>:BundleInstall!
        </code></pre>
    - Transfer the file type from Dos to Unix
        <pre><code>$ sudo apt-get install dos2unix
        $ dos2unix ~/.vim/bundle/css.vim/syntax/css.vim
        </code></pre>

-----------------------------

### Open is Maximize
- Default maximze for Win32 user
- lwmctr must be installed for linux User. Download from: http://download.csdn.net/detail/jiaoxiaogu/4317843

### Shortcuts
- `F5`: Run Python, Ruby and Perl by one key! (The result could be shown in the Quickfix window)
- `F3`: Open the tagbar
- `F4`: Add the personal information

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
    - `tv`:     Open bash in the vim/gvim against Liunxu and open command line against Windows (Yes! That's true)
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

###Plugins:
- [AuthorInfo](https://github.com/dantezhu/authorinfo)
- [Conque Term](http://code.google.com/p/conque/)
- [EnhancedCommentify](https://github.com/woainvzu/EnhCommentify.vim), [EnhancedByMarslo](https://github.com/woainvzu/EnhCommentify.vim)
- [MiniBufExpl](http://www.vim.org/scripts/script.php?script_id=159)
- [mru](https://github.com/vim-scripts/mru.vim)
- [ctrlp](https://github.com/kien/ctrlp.vim)
- [python_fold.vim](https://github.com/vim-scripts/python_fold)
- [TagBar](http://majutsushi.github.io/tagbar/)
- [TagList](http://vim-taglist.sourceforge.net/)
- [TeTrIs](https://github.com/vim-scripts/TeTrIs.vim)
- [WinManager](https://github.com/vim-scripts/winmanager)
- [IndentLine](https://github.com/Yggdroot/indentLine)
- [Vim Bunlde](https://github.com/gmarik/vundle)
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540), [Github](https://github.com/garbas/vim-snipmate), [EnhancedByMarslo](https://github.com/woainvzu/snipmate.vim)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)
- [vim-rails](https://github.com/tpope/vim-rails)
- [Marslo.vim](https://github.com/woainvzu/Marslo.vim)
- [MatchTag](https://github.com/gregsexton/MatchTag)
- [ruby-matchit](https://github.com/vim-scripts/ruby-matchit)
- [vim-colorsque](https://github.com/gorodinskiy/vim-coloresque)

#### Not be used
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)          # Cannot work for vim74, using **vim-colorsque** instead
- [emmet.vim](https://github.com/mattn/emmet-vim)

+++++++++++++++++++++++++++++++++++++++++++

The default Font named: Monaco, download form: http://download.csdn.net/detail/jiaoxiaogu/4317959

-----------------------------

###ʹ�÷���
- Windows�û�
    - ���� **Configurations\Win\Vim74_Vundle\_vimrc** �� `C:\Program Files (x86)\Vim`
    - ��ȡ [Vundle](https://github.com/gmarik/vundle.git) [��¡���뵽 `$VIMHOME\vimfiles` Ŀ¼��]
        - <del>>> git clone https://github.com/gmarik/vundle.git "C:\Program Files (x86)\Vim\vimfile\"</del>
        - ��vim(���Դ���򾯸�)
        <pre><code>:call GetVundle()
        </code></pre>
    - ��ȡ�������
        <pre><code>:BundleInstall!
        </code></pre>

- Linux �û�:
    - ���� **Configurations\Linux\Vim74_vundle\.vimrc** �� `$HOME`
    <pre><code>$ cp Linux/Vim74_vundle/.vimrc ~/
    </code></pre>
    - ��ȡ [Vundle](https://github.com/gmarik/vundle.git) ����¡���뵽 `$HOME\.vim`��
        <del>$ git clone https://github.com/gmarik/vundle.git ~/.vim</del>
        - ��Gvim������ (���Դ���򾯸棩��
            <pre><code>:call GetVundle()
            </code></pre>
    - ��ȡ�������
        <pre><code>:BundleInstall!
        </code></pre>
    - ��Windows�µ��ļ���ʽ��ΪUnix��ʽ
        <pre><code>$ sudo apt-get install dos2unix
        $ dos2unix ~/.vim/bundle/css.vim/syntax/css.vim
        </code></pre>

-----------------------------

### ��vim/gvimĬ�����
- Windows�û�, ��Ĭ�Ͽ������
- Linux�û�����Ҫ��װ`lwmctr`�����ص�ַ��http://download.csdn.net/detail/jiaoxiaogu/4317843

### ��ݼ�
- `F5`: һ������Python, Ruby �� Perl��(���н������ʾ��Quickfix������)
- `F3`: ��tagbar
- `F4`: �Զ������û���Ϣ

+++++++++++++++++++++++++++++++++++++++++++

### �����뿴Screenshot
- �Զ����
- �Զ�������Ϣ��
    - `<leader>fn`: ���ӵ�ǰ�ļ���(�޺�׺������Java��������)
    - `<leader>fe`: ���ӵ�ǰ�ļ���(�к�׺����������ע��)
    - `<leader>tt`: ���ӵ�ǰʱ��
- �Զ�����ͼ����۵���Ϣ

+++++++++++++++++++++++++++++++++++++++++++

- �Զ��庯����ݼ�
    - `<F12>`: ��������tags�ļ�
    - `gf`: �򿪹���µĵ���Ϊ�ļ��� ������python�ļ������Զ�����.pyΪ��׺��
    - `Alt + -`: ��С����
    - `Alt + +`: ��������
    - `cmd`: �������У����Զ�cd����ǰ�ļ�Ŀ¼��Linux�򿪵�ΪTerminal��Windows�򿪵�Ϊcommand line��
    - `Alt + o`: ���ļ�������� ���Զ����뵱ǰ�ĵ���Ŀ¼ ��Linux��ΪNautilus, Windows��ΪExplorer��

+++++++++++++++++++++++++++++++++++++++++++

- �����ݼ�
    - `tl`: ��ʾtaglist
    - `wm`: ��ʾwinmanager(����taglist��Ϣ)
    - `<leader>v`: �������ļ�(_vimrc/.vimrc)
    - `<leader>te`: �򿪶���˹������Ϸ(��ϰhjkl��ݼ�)
    - `tv`: ��vim/gvim������bash(�ǵģ���û������)
    - `pyli`: Python��̬�������(�淶���룬Զ�뿳�ֿ���)
    - `ctrl + g`: ������ļ��б���10����
    - `<leader>v`: ע��/��ע��

+++++++++++++++++++++++++++++++++++++++++++

- Emacs ����ݼ�
    - `Ctrl + a`: ����ƶ������� [Normalģʽ && ����ģʽ]
    - `Ctrl + e`: ����ƶ�����β [Normalģʽ && ����ģʽ]
    - `Alt + b`: �����ǰ����һ������ [����ģʽ]
    - `Alt + f`: �����ǰ����һ������ [����ģʽ]
    - `Alt + d`: ��ǰɾ��һ������ [����ģʽ]
    - `Ctrl + w`: ���ɾ��һ������ [����ģʽ]

+++++++++++++++++++++++++++++++++++++++++++

- �������ʽ��ݼ�
    - `zdb`: ɾ����β�ո�
    - `zmm`: �����ĵ��к�

### ����б���
- [AuthorInfo](https://github.com/dantezhu/authorinfo)
- [Conque Term](http://code.google.com/p/conque/)
- [EnhancedCommentify](https://github.com/woainvzu/EnhCommentify.vim), [EnhancedByMarslo](https://github.com/woainvzu/EnhCommentify.vim)
- [MiniBufExpl](http://www.vim.org/scripts/script.php?script_id=159)
- [mru](https://github.com/vim-scripts/mru.vim)
- [ctrlp](https://github.com/kien/ctrlp.vim)
- [python_fold.vim](https://github.com/vim-scripts/python_fold)
- [TagBar](http://majutsushi.github.io/tagbar/)
- [TagList](http://vim-taglist.sourceforge.net/)
- [TeTrIs](https://github.com/vim-scripts/TeTrIs.vim)
- [WinManager](https://github.com/vim-scripts/winmanager)
- [IndentLine](https://github.com/Yggdroot/indentLine)
- [Vim Bunlde](https://github.com/gmarik/vundle)
- [snipMate](http://www.vim.org/scripts/script.php?script_id=2540), [Github](https://github.com/garbas/vim-snipmate), [EnhancedByMarslo](https://github.com/woainvzu/snipmate.vim)
- [Rainbow Parentheses](https://github.com/kien/rainbow_parentheses.vim)
- [vim-rails](https://github.com/tpope/vim-rails)
- [Marslo.vim](https://github.com/woainvzu/Marslo.vim)
- [MatchTag](https://github.com/gregsexton/MatchTag)
- [ruby-matchit](https://github.com/vim-scripts/ruby-matchit)
- [vim-colorsque](https://github.com/gorodinskiy/vim-coloresque)

#### δ��ʹ�õģ�����ʹ�ã�
- perl-support.vim
- [tlib](https://github.com/tomtom/tlib_vim)
- [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils)
- [vim-css-color](https://github.com/ap/vim-css-color)                      # ��֧��Vim74�� ʹ��**vim-colorsque**���
- [emmet.vim](https://github.com/mattn/emmet-vim)

+++++++++++++++++++++++++++++++++++++++++++

Ĭ������Ϊ�� Monaco, ���ص�ַ: http://download.csdn.net/detail/jiaoxiaogu/4317959
