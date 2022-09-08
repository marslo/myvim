marslo.vim
==========
The vim color configurate by Marslo, including 256 and 16

## Screenshot:
- Windows (Gvim [Python]):
![windows](https://github.com/Marslo/marslo.vim/blob/master/Screenshots/my256colors.png?raw=true)
- Linux (Terminal [HTML])
![Linux Termianl](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenhost_Linux_Terminal.png?raw=true)
- Linux (Gvim  [CSS])
![Linux Gvim](https://github.com/Marslo/VimConfig/blob/master/Screenshots/Screenhost_Linux_Gvim.png?raw=true)
- PuTTy (vimrc)
![PuTTy](https://github.com/Marslo/VimConfig/blob/master/Screenshots/screenshot_PuTTy.png?raw=true)

## Context
- [Usage](https://github.com/Marslo/marslo.vim#usage)
  - [Installation](https://github.com/Marslo/marslo.vim#installation):
    - [By Manual](https://github.com/Marslo/marslo.vim#by-manual)
    - [By Vundle](https://github.com/Marslo/marslo.vim#by-vundle)
  - [Use marslo.vim in my vim](https://github.com/Marslo/marslo.vim#how-to-use-it):
    - [For Linux](https://github.com/Marslo/marslo.vim#for-linux)
    - [For WIndows](https://github.com/Marslo/marslo.vim#for-windows)
- [使用方法](https://github.com/Marslo/marslo.vim#使用方法)
  - [安装方法](https://github.com/Marslo/marslo.vim#如何安装)：
    - [手动添加](https://github.com/Marslo/marslo.vim#手动添加)
    - [使用Vundle管理](https://github.com/Marslo/marslo.vim#使用vundle管理)
  - [在我的vim中使用marslo.vim配色](https://github.com/Marslo/marslo.vim#如何使用)：
    - [Linux用户](https://github.com/Marslo/marslo.vim#linux-用户)
    - [Windows用户](https://github.com/Marslo/marslo.vim#windows-用户)
- [Screenshot](https://github.com/Marslo/marslo.vim#screenshot)
- [Helps and Documents about vim color](https://github.com/Marslo/marslo.vim#documents-about-vim-color)
- [Change Logs](https://github.com/Marslo/marslo.vim#changelog)
  - [256 color](https://github.com/Marslo/marslo.vim#256color)
  - [16 color](https://github.com/Marslo/marslo.vim#16colors)
- [Thanks For](https://github.com/Marslo/marslo.vim#thanks-for)


## Usage:
### Installation:
#### By manual:
- Download the **marslo16.vim** and **marslo256.vim**
- Put the file into colors folder, for example:
  - <pre><code>C:\Program Files (x86)\Vim\vim74\colors</code></pre>
  - **Recommend**: <pre><code>C:\Program Files (x86)\Vim\vimfiles\colors</code></pre>

#### By Vundle:
- Copy the setting into **_vimrc**(windows) or **.vimrc**(Linux):
  <pre><code>Bundle 'Marslo/marslo.vim'</code></pre>
- Add execute the command as below in vim/gvim:
  <pre><code>:BundleInstall</code></pre>

### How to use it
#### For Linux:
  - Add the following configure to `.bashrc` (~/.bashrc) make termianl support 256 color:
    <pre><code> if [ -e /usr/share/terminfo/x/xterm-256color ];
    then
        export TERM='xterm-256color'
    # Ubuntu
    elif [ -e /lib/terminfo/x/xterm-256color ];
    then
        export TERM='xterm-256color'
    else
        export TERM='xterm-color'
    fi
    </code></pre>
  - And, and the following configure to `.vimrc` (~/.vimrc)
    <pre><code>if has('gui_running') || 'xterm-256color' == $TERM
      colorscheme marslo256
      let psc_style='cool'
    else
      colorscheme marslo16
    endif
    </code></pre>

#### For Windows:
  - Just Add the fowlling configure to `_vimrc` (C:\Program Files (x86)\Vim\_vimrc [64bit system])
    <pre><code>if has('gui_running') || 'xterm-256color' == $TERM
      colorscheme marslo256
      let psc_style='cool'
    else
      colorscheme marslo16
    endif
    </code></pre>

## 使用方法
### 如何安装

#### 手动添加
- 下载 **marslo16.vim** 和 **marslo256.vim**
- 将两个文件都放入vim的colors目录， 例如（64位系统）:
  - <pre><code>C:\Program Files (x86)\Vim\vim74\colors</code></pre>
  - **强烈推荐**: <pre><code>C:\Program Files (x86)\Vim\vimfiles\colors</code></pre>

#### 使用[Vundle](https://github.com/gmarik/vundle)管理
- 将如下代码拷贝复制至 **_vimrc**(windows) 或 **.vimrc**(Linux)
  <pre><code>Bundle 'Marslo/marslo.vim'</code></pre>
- 在 vim/gvim 中运行如下命令即可完成自动安装:
  <pre><code>:BundleInstall</code></pre>

### 如何使用
#### Linux 用户
  - 将如下配置添加至 `.bashrc` (~/.bashrc), 使得Linux终端（terminal）支持256色:
    <pre><code> if [ -e /usr/share/terminfo/x/xterm-256color ];
    then
        export TERM='xterm-256color'
    # Ubuntu
    elif [ -e /lib/terminfo/x/xterm-256color ];
    then
        export TERM='xterm-256color'
    else
        export TERM='xterm-color'
    fi
    </code></pre>
  - 然后，将如下配置添加至 `.vimrc` (~/.vimrc)
    <pre><code>if has('gui_running') || 'xterm-256color' == $TERM
      colorscheme marslo256
      let psc_style='cool'
    else
      colorscheme marslo16
    endif
    </code></pre>

#### Windows用户
  - 只需将如下配置加入 `_vimrc` 文件即可 (C:\Program Files (x86)\Vim\_vimrc [64bit system])
    <pre><code>if has('gui_running') || 'xterm-256color' == $TERM
      colorscheme marslo256
      let psc_style='cool'
    else
      colorscheme marslo16
    endif
    </code></pre>

## Documents about vim color:
- [rgb.txt](http://fugal.net/vim/rgbtxt.html) | [Name with RGB hexadecimal number](https://github.com/Marslo/MarsloVimOthers/blob/master/AboutGvimColors/rgb/myrgb.txt)
- [vim wiki: View all colors available to gvim](http://vim.wikia.com/wiki/View_all_colors_available_to_gvim)
- [vim wiki: Xterm256 color names for console Vim](http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim)

## ChangeLog:
### 256color:
<pre><code>
v1.0: Modified at 2012.05.29
      File Name: desert_Marslo_ForLinux
v1.1: Modified at 18/10/2012 16:49:12.92
      File Name: desert_Marslo_ForLinux_2
v1.2: Modified at 08/11/2012 16:05:59.95
      File Name: desert_Marslo_ForLinux_3
      Modified: g:colors_name
                Normal        guibg
                NonText       guibg
                StatusLine    guibg
                StatusLineNC  guibg
                Folded        guibg
                FoldColumn    guibg
v1.3: Modified at 17/12/12 19:36:21
      File Name: desert_Marslo_ForLinux_v3
      Modifed:
               Pmenu        guibg ctermbg
               PmenuSel     guifg guibg ctermbg
               PmenuSbar    guifg guibg
v1.4: Modified at 31/10/13 15:47:08
      File Name: marslo.vim
      Added:
              MatchParen      guibg ctermbg gui cterm term
              LineNr          guifg guibg ctermfg ctermbg
              CursorLineNr    guifg guibg gui ctermbg ctermfg
v1.5: Modified at 07/11/13 17:52:47
      File Name: marslo.vim
      Added:
              MBEVisibleActive    guifg guibg
              MBEVisibleNormal    guifg guibg
v1.6: Modified at 12/11/13 14:08:10
      File Name: marslo265.vim
      Add:
              HTML tags
              NERDTree
      Modifiy:
              Identifier          cterm
              Visual              ctermfg
              Change name from marslo.vim to marslo256.vim
v.1.7: Modified at 12/11/13 15:58:50
      File Name: marslo256.vim
      Modified:
              Update the format
v1.8: Modified at 18/11/13  20:03:20
      File Name: marslo256.vim
      Modified:
              String              guifg
              Entity              guifg
              Support             guifg
              Type                guifg
              FoldColumn          guifg
              Directory           guifg
v1.9: Modified at 30/12/13 19:51:11
      Modified:
              spearate the change log
</code></pre>

### 16colors
<pre><code>
v1.0: Modified at 2012.05.29
      File Name: desert_Marslo_ForLinux
v1.1: Modified at 18/10/2012 16:49:12.92
      File Name: desert_Marslo_ForLinux_2
v1.2: Modified at 08/11/2012 16:05:59.95
      File Name: desert_Marslo_ForLinux_3
      Modified: g:colors_name
                Normal        guibg
                NonText       guibg
                StatusLine    guibg
                StatusLineNC  guibg
                Folded        guibg
                FoldColumn    guibg
v1.3: Modified at 17/12/12 19:36:21
      File Name: desert_Marslo_ForLinux_v3
      Modifed:
               Pmenu        guibg ctermbg
               PmenuSel     guifg guibg ctermbg
               PmenuSbar    guifg guibg
v1.4: Modified at 31/10/13 15:47:08
      File Name: marslo.vim
      Added:
              MatchParen      guibg ctermbg gui cterm term
              LineNr          guifg guibg ctermfg ctermbg
              CursorLineNr    guifg guibg gui ctermbg ctermfg
v1.5: Modified at 07/11/13 17:52:47
      File Name: marslo.vim
      Added:
              MBEVisibleActive    guifg guibg
              MBEVisibleNormal    guifg guibg
V1.6: Modified at 12/11/13 14:20:13
      File Name: marslo16.vim
      Modified:
              Change name from marslo.vim to marslo16.vim
v1.7: Modified at 13/11/13 18:20:09
      File Name: marslo16.vim
      Modified:
              Update the format
v1.8: Modified at 18/11/13  20:03:20
      File Name: marslo16.vim
      Modified:
              String              guifg
              Entity              guifg
              Support             guifg
              Type                guifg
              FoldColumn          guifg
              Directory           guifg
v1.9: Modified at 30/12/13 19:51:11
      Modified:
              spearate the change log
</code></pre>

## Thanks for
- Hans Fugal <hans@fugal.net> (http://hans.fugal.net/vim/colors/desert.vim)