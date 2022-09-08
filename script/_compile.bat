@echo off

REM this code is get from https://tuxproject.de/projects/vim/_compile.bat.php
REM
REM ---------------[ PREFACE ]---------------------------------------------
REM This script will build both the 32- and 64-bit version of both Vim
REM and GVim in their latest upstream versions (if possible). It can and
REM probably will break sometimes. Just wait for repository updates - they
REM will fix it. Also, remember to keep track of your local changes (e.g.
REM by using "svn diff" and "svn status".)
REM ----------------------------------------------------------------------


REM ---------------[ PREREQUISITES ]--------------------------------------
REM * 7-zip (for packing the archives and SFXs).
REM * gettext (for the src/po folder).
REM * A local clone of the Vim repository (here: /vim). I take mine from
REM   GitHub: https://github.com/vim/vim
REM * A Subversion client.
REM * Visual Studio 2017 or higher (Community Edition would work) with
REM   the Windows Kit 8.1.
REM * Strawberry (or Active) Perl, IronTcl (both x86 and x64), Lua for Windows,
REM   Python2 and Python3.
REM * Racket, compiled with the same MSVC version.
REM * Depending on your Perl distribution, you might have to fix Perl's
REM   config file (CORE/config.h) by commenting out symbols you don't have
REM   (like STDBOOL).
REM * Also you'll need to grab Ruby 2.x from the RubyInstaller:
REM   http://rubyinstaller.org/. You will have to generate your own
REM   config.h file for it to work though. Please refer to Vim's docs in
REM   src\INSTALLpc.txt (paragraph 12).
REM * TERMINAL support is compiled in with winpty. You'll need winpty-agent
REM   and winpty.dll in the appropriate binary directories. winpty can be
REM   obtained from https://github.com/rprichard/winpty/releases (use the
REM   MSVC version, just in case).
REM * diff.exe and patch.exe from the official Vim releases. (Can be left
REM   out if you wish.)
REM ----------------------------------------------------------------------


REM update the sources ...
REM ------------------------------------

cd vim
svn up trunk
cd trunk


REM set vars ...
REM ------------------------------------

REM LIBPYTHON2 = short (2-digit) version of Python 2.x
REM LIBPYTHON3 = short (2-digit) version of Python 3.x
REM LIBTCLSHRT = short (2-digit) version of Tcl
REM LIBTCLLONG = long (x.y) version of Tcl
REM LIBRBYSHRT = short (2-digit) version of Ruby
REM LIBRBYLONG = long (x.y.z) version of Ruby
REM LIBRBYLIB  = Ruby version (x.y.z) in the library folder name
REM LIBLUASHRT = short (2-digit) version of Lua
REM LIBLUALONG = long (x.y) version of Lua
REM LIBPERLVER = 3-digit version of Perl
REM LIBRACKET  = current version of your libracket.lib (part of its file name)

REM LUA_DIR     = Lua installation directory
REM PERL_DIR    = Perl installation directory
REM PYTHON2_DIR = Python 2 installation directory
REM PYTHON3_DIR = Python 3 installation directory
REM RACKET_DIR  = Racket installation directory
REM RUBY_DIR    = Ruby installation directory
REM TCL32DIR    = Tcl installation directory (x86)
REM TCL64DIR    = Tcl installation directory (x64)

REM PATCHDIFF = the directory where patch.exe and diff.exe reside
REM MSVCDIR   = the directory where Visual Studio resides, containing the vcvarsall.bat file
REM WINPTYDIR = the root directory of your winpty folder (see the intro for details)

set LIBPYTHON2=27
set LIBPYTHON3=37
set LIBTCLSHRT=86
set LIBTCLLONG=8.6
set LIBRBYSHRT=26
set LIBRBYLONG=2.6.0
set LIBRBYLIB=2.6.0
set LIBLUASHRT=53
set LIBLUALONG=5.3
set LIBPERLVER=530
set LIBRACKET=xxxxxxx

set LUA_DIR=..\..\..\libs\lua
set PERL_DIR=C:\strawberry\perl
set PYTHON2_DIR=C:\Python%LIBPYTHON2%
set PYTHON3_DIR=C:\Python%LIBPYTHON3%
set RACKET_DIR=..\..\..\libs\racket-7.3
set RUBY_DIR=C:\Ruby26-x64
set TCL32DIR=..\..\..\libs\IronTcl\x86
set TCL64DIR=..\..\..\libs\IronTcl\x64

set PATCHDIFF=..\..\..
set MSVCDIR=%PROGRAMFILES(X86)%\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build
set WINPTYDIR=..\..\..\libs\winpty-0.4.3-msvc2015


REM -----------------------------------------------------
REM you probably won't have to edit anything below this.
REM -----------------------------------------------------


REM create output directory ...
REM ------------------------------------

if not exist src\tempoutput mkdir src\tempoutput
if not exist src\tempoutput mkdir src\tempoutput\x86
if not exist src\tempoutput mkdir src\tempoutput\x64


REM make clean (manually)
REM -------------------------------------

cd src
if exist del /Q ObjCULYHTRZVAMD64\*.*
if exist del /Q ObjCULYHTRZVi386\*.*
if exist del /Q ObjDXOULYHTRZVAMD64\*.*
if exist del /Q ObjDXOULYHTRZVi386\*.*
if exist del /Q ObjDXULYHTRZVAMD64\*.*
if exist del /Q ObjDXULYHTRZVi386\*.*
if exist del /Q ObjGXULYHTRZVAMD64\*.*
if exist del /Q ObjGXULYHTRZVi386\*.*


REM delete archive files
REM -------------------------------------

if exist tempoutput\complete*.7z del tempoutput\complete*.7z
if exist tempoutput\complete*.exe del tempoutput\complete*.exe


REM prepare the environment ...
REM ------------------------------------

if exist gvim_noOLE.exe del gvim_noOLE.exe
call "%MSVCDIR%\vcvarsall.bat" x86 8.1


REM Build GVim without OLE (x86).
REM -------------------------------------

nmake /C /S /f Make_mvc.mak VIMDLL=no DEBUG=no GUI=yes OLE=no DIRECTX=yes USE_MSVCRT=yes PERL="%PERL_DIR%" LUA="%LUA_DIR%" TCL="%TCL32DIR%" RUBY=%RUBY_DIR% PYTHON=%PYTHON2_DIR% PYTHON3=%PYTHON3_DIR% MZSCHEME="%RACKET_DIR%" clean
nmake /C /S /f Make_mvc.mak CPU=i386  DEBUG=no USE_MSVCRT=yes FEATURES=HUGE CHANNEL=yes MBYTE=yes CSCOPE=yes TERMINAL=yes IME=yes GIME=yes GUI=yes VIMDLL=no OLE=no  XPM=.\xpm\x86 DIRECTX=yes PERL=%PERL_DIR% DYNAMIC_PERL=yes PERL_VER=%LIBPERLVER% LUA="%LUA_DIR%" DYNAMIC_LUA=yes LUA_VER=%LIBLUASHRT% TCL=%TCL32DIR% TCL_VER=%LIBTCLSHRT% TCL_VER_LONG=%LIBTCLLONG% DYNAMIC_TCL=yes RUBY=%RUBY_DIR% DYNAMIC_RUBY=yes RUBY_VER=%LIBRBYSHRT% RUBY_VER_LONG=%LIBRBYLIB% RUBY_MSVCRT_NAME=msvcrt PYTHON=%PYTHON2_DIR% DYNAMIC_PYTHON=yes PYTHON_VER=%LIBPYTHON2% PYTHON3=%PYTHON3_DIR% DYNAMIC_PYTHON3=yes PYTHON3_VER=%LIBPYTHON3% MZSCHEME="%RACKET_DIR%" DYNAMIC_MZSCHEME=yes MZSCHEME_MAIN_LIB=racket MZSCHEME_VER=%LIBRACKET%

REM Keep it for the release:
REM -------------------------------------

ren gvim.exe gvim_noOLE.exe

REM Build GVim and Vim with OLE (x86).
REM -------------------------------------
REM Vim 8.1.1230 and higher automatically
REM build both versions with "VIMDLL=yes"
REM by using a shared library.
REM -------------------------------------

nmake /C /S /f Make_mvc.mak VIMDLL=yes DEBUG=no GUI=yes OLE=yes DIRECTX=yes USE_MSVCRT=yes PERL="%PERL_DIR%" LUA="%LUA_DIR%" TCL="%TCL32DIR%" RUBY=%RUBY_DIR% PYTHON=%PYTHON2_DIR% PYTHON3=%PYTHON3_DIR% MZSCHEME="%RACKET_DIR%" clean
nmake /C /S /f Make_mvc.mak CPU=i386  DEBUG=no USE_MSVCRT=yes FEATURES=HUGE CHANNEL=yes MBYTE=yes CSCOPE=yes TERMINAL=yes IME=yes GIME=yes GUI=yes VIMDLL=yes OLE=yes XPM=.\xpm\x86 DIRECTX=yes PERL=%PERL_DIR% DYNAMIC_PERL=yes PERL_VER=%LIBPERLVER% LUA="%LUA_DIR%" DYNAMIC_LUA=yes LUA_VER=%LIBLUASHRT% TCL=%TCL32DIR% TCL_VER=%LIBTCLSHRT% TCL_VER_LONG=%LIBTCLLONG% DYNAMIC_TCL=yes RUBY=%RUBY_DIR% DYNAMIC_RUBY=yes RUBY_VER=%LIBRBYSHRT% RUBY_VER_LONG=%LIBRBYLIB% RUBY_MSVCRT_NAME=msvcrt PYTHON=%PYTHON2_DIR% DYNAMIC_PYTHON=yes PYTHON_VER=%LIBPYTHON2% PYTHON3=%PYTHON3_DIR% DYNAMIC_PYTHON3=yes PYTHON3_VER=%LIBPYTHON3% MZSCHEME="%RACKET_DIR%" DYNAMIC_MZSCHEME=yes MZSCHEME_MAIN_LIB=racket MZSCHEME_VER=%LIBRACKET%


REM keep up the right directory structure
REM -------------------------------------

cd po
nmake -f Make_mvc.mak install-all
cd ..

robocopy ..\runtime\ tempoutput\x86\ /MIR /NP /NJH /NJS /NFL /NDL
copy ..\vimtutor.* tempoutput\x86\
xcopy xxd\xxd.exe tempoutput\x86\ /K
xcopy tee\tee.exe tempoutput\x86\ /K
xcopy *.exe tempoutput\x86\ /K
copy vim32.dll tempoutput\x86\

if exist gvim_noOLE.exe del gvim_noOLE.exe

if not exist tempoutput\x86\GVimExt32 mkdir tempoutput\x86\GVimExt32
if not exist tempoutput\x86\VisVim mkdir tempoutput\x86\VisVim

copy gvimext\*.dll tempoutput\x86\gvimext32\
copy gvimext\*.inf tempoutput\x86\gvimext32\
copy gvimext\*.reg tempoutput\x86\gvimext32\
copy gvimext\README.txt tempoutput\x86\gvimext32\

copy VisVim\*.txt tempoutput\x86\VisVim\
copy VisVim\*.dll tempoutput\x86\VisVim\
copy VisVim\*.bat tempoutput\x86\VisVim\

copy %WINPTYDIR%\ia32\bin\winpty.dll tempoutput\x86\
copy %WINPTYDIR%\ia32\bin\winpty-agent.exe tempoutput\x86\

if exist %PATCHDIFF%\patch.exe copy %PATCHDIFF%\patch.exe tempoutput\x86\
if exist %PATCHDIFF%\diff.exe copy %PATCHDIFF%\diff.exe tempoutput\x86\


REM cleanup
REM ------------------------------------

del tempoutput\x86\vimlogo.*
del tempoutput\x86\*.png
del tempoutput\x86\vim??x??.*


REM pack it!
REM ------------------------------------

cd tempoutput\x86
7z a -mx=9 -r -bd ..\complete-x86.7z *
7z a -mx=9 -r -bd -sfx7z.sfx ..\complete-x86.exe *

cd ..\..


REM prepare the environment ...
REM ------------------------------------

if exist gvim_noOLE.exe del gvim_noOLE.exe
call "%MSVCDIR%\vcvarsall.bat" x64 8.1


REM Build GVim without OLE (x64).
REM -------------------------------------

nmake /C /S /f Make_mvc.mak VIMDLL=no DEBUG=no GUI=yes OLE=yes DIRECTX=yes USE_MSVCRT=yes PERL="%PERL_DIR%" LUA="%LUA_DIR%" TCL="%TCL64DIR%" RUBY=%RUBY_DIR% PYTHON=%PYTHON2_DIR% PYTHON3=%PYTHON3_DIR% MZSCHEME="%RACKET_DIR%" clean
nmake /C /S /f Make_mvc.mak CPU=AMD64 DEBUG=no USE_MSVCRT=yes FEATURES=HUGE CHANNEL=yes MBYTE=yes CSCOPE=yes TERMINAL=yes IME=yes GIME=yes GUI=yes VIMDLL=no OLE=no  XPM=.\xpm\x64 DIRECTX=yes PERL=%PERL_DIR% DYNAMIC_PERL=yes PERL_VER=%LIBPERLVER% LUA="%LUA_DIR%" DYNAMIC_LUA=yes LUA_VER=%LIBLUASHRT% TCL=%TCL64DIR% TCL_VER=%LIBTCLSHRT% TCL_VER_LONG=%LIBTCLLONG% DYNAMIC_TCL=yes RUBY=%RUBY_DIR% DYNAMIC_RUBY=yes RUBY_VER=%LIBRBYSHRT% RUBY_VER_LONG=%LIBRBYLIB% RUBY_MSVCRT_NAME=msvcrt PYTHON=%PYTHON2_DIR% DYNAMIC_PYTHON=yes PYTHON_VER=%LIBPYTHON2% PYTHON3=%PYTHON3_DIR% DYNAMIC_PYTHON3=yes PYTHON3_VER=%LIBPYTHON3% MZSCHEME="%RACKET_DIR%" DYNAMIC_MZSCHEME=yes MZSCHEME_MAIN_LIB=racket MZSCHEME_VER=%LIBRACKET%

REM Keep it for the release:
REM -------------------------------------

ren gvim.exe gvim_noOLE.exe

REM Build GVim and Vim with OLE (x64).
REM -------------------------------------
REM Vim 8.1.1230 and higher automatically
REM build both versions with "VIMDLL=yes"
REM by using a shared library.
REM -------------------------------------

nmake /C /S /f Make_mvc.mak VIMDLL=yes DEBUG=no GUI=yes OLE=yes DIRECTX=yes USE_MSVCRT=yes PERL="%PERL_DIR%" LUA="%LUA_DIR%" TCL="%TCL64DIR%" RUBY=%RUBY_DIR% PYTHON=%PYTHON2_DIR% PYTHON3=%PYTHON3_DIR% MZSCHEME="%RACKET_DIR%" clean
nmake /C /S /f Make_mvc.mak CPU=AMD64 DEBUG=no USE_MSVCRT=yes FEATURES=HUGE CHANNEL=yes MBYTE=yes CSCOPE=yes TERMINAL=yes IME=yes GIME=yes GUI=yes VIMDLL=yes OLE=yes XPM=.\xpm\x64 DIRECTX=yes PERL=%PERL_DIR% DYNAMIC_PERL=yes PERL_VER=%LIBPERLVER% LUA="%LUA_DIR%" DYNAMIC_LUA=yes LUA_VER=%LIBLUASHRT% TCL=%TCL64DIR% TCL_VER=%LIBTCLSHRT% TCL_VER_LONG=%LIBTCLLONG% DYNAMIC_TCL=yes RUBY=%RUBY_DIR% DYNAMIC_RUBY=yes RUBY_VER=%LIBRBYSHRT% RUBY_VER_LONG=%LIBRBYLIB% RUBY_MSVCRT_NAME=msvcrt PYTHON=%PYTHON2_DIR% DYNAMIC_PYTHON=yes PYTHON_VER=%LIBPYTHON2% PYTHON3=%PYTHON3_DIR% DYNAMIC_PYTHON3=yes PYTHON3_VER=%LIBPYTHON3% MZSCHEME="%RACKET_DIR%" DYNAMIC_MZSCHEME=yes MZSCHEME_MAIN_LIB=racket MZSCHEME_VER=%LIBRACKET%


REM keep up the right directory structure
REM -------------------------------------

cd po
nmake -f Make_mvc.mak install-all
cd ..

robocopy ..\runtime\ tempoutput\x64\ /MIR /NP /NJH /NJS /NFL /NDL
copy ..\vimtutor.* tempoutput\x64\
copy xxd\xxd.exe tempoutput\x64\
copy tee\tee.exe tempoutput\x64\
copy *.exe tempoutput\x64\
copy vim64.dll tempoutput\x64\

if not exist tempoutput\x64\GVimExt64 mkdir tempoutput\x64\GVimExt64
if not exist tempoutput\x64\VisVim mkdir tempoutput\x64\VisVim

copy gvimext\*.dll tempoutput\x64\gvimext64\
copy gvimext\*.inf tempoutput\x64\gvimext64\
copy gvimext\*.reg tempoutput\x64\gvimext64\
copy gvimext\README.txt tempoutput\x64\gvimext64\

copy VisVim\*.txt tempoutput\x64\VisVim\
copy VisVim\*.dll tempoutput\x64\VisVim\
copy VisVim\*.bat tempoutput\x64\VisVim\

copy %WINPTYDIR%\x64\bin\winpty.dll tempoutput\x64\
copy %WINPTYDIR%\x64\bin\winpty-agent.exe tempoutput\x64\

if exist %PATCHDIFF%\patch.exe copy %PATCHDIFF%\patch.exe tempoutput\x64\
if exist %PATCHDIFF%\diff.exe copy %PATCHDIFF%\diff.exe tempoutput\x64\


REM cleanup
REM ------------------------------------

del tempoutput\x64\vimlogo.*
del tempoutput\x64\*.png
del tempoutput\x64\vim??x??.*


REM pack it!
REM ------------------------------------

cd tempoutput\x64
7z a -mx=9 -r -bd ..\complete-x64.7z *
7z a -mx=9 -r -bd -sfx7z.sfx ..\complete-x64.exe *


REM ------------------------------------------------ DONE!


cd ..
cd ..
cd ..
cd ..
cd ..


REM copy today's files into /upload
REM ------------------------------------

rd /S /Q upload
mkdir upload
robocopy vim\trunk\src\tempoutput\ upload\ /MAXAGE:1 /NP /NJH /NJS /NFL /NDL /SL /S
