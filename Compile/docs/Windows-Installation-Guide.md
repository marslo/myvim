this doc got from [valloric/youcomplateme wiki](https://github.com/Valloric/YouCompleteMe.wiki.git). Backup the article. Please get the latest update from: https://github.com/Valloric/YouCompleteMe/wiki/Windows-Installation-Guide

----------------------------

### Update - October 14, 2015
Windows is now officially supported by YouCompleteMe. Please follow the instructions in the [README.md](https://github.com/Valloric/YouCompleteMe#windows-installation).

---

Before starting this installation procedure, it's _critically_ important that you understand that the architecture (`x86` vs `x86-64`) that you build `ycm_core.pyd` for has to match the architecture of the `python27.dll` on your system _and_ the architecture of the Vim binary you will be running. All three need to match, otherwise things won't work.

# Vim YouCompleteMe for Windows
## Building from YCM Source on Windows
### This was last updated September 15, 2015
Things you will need:
* Visual Studio - Community works just fine, has not been tested on Express
* Python 2.* x86 - The Python 2.7.10 binaries for Windows have been tested to work; 2.7.11 does not work, probably due to https://bugs.python.org/issue25824
* CMake
* Vundle
* Vim
* LLVM Snapshot Binary - [LLVM Snapshot Builds](http://llvm.org/builds/)

If someone manages to build Vim on Windows as a 64-bit program, it'd be nice to have the option of running on x86 or x64, but the default binaries distributed through the Vim installer are x86 so we have no choice.

This has been tested on Windows 10 and 8.1

After installing Vundle, include YCM in the list of plugins:

    Plugin 'Valloric/YouCompleteMe'

Run `:PluginInstall` on vim and it should download the YCM plugin dependencies and source. It takes a while, don't panic if it does. Afterwards, navigate to the folder where Vundle downloaded it. Inside the YCM root directory, make a directory called `ycmd_build`. Run a command prompt inside that folder (shift-right click in file explorer or file open command prompt in file explorer or navigate manually) and run the CMake like so:
    
    cmake -G "Visual Studio 14" -DPATH_TO_LLVM_ROOT="C:\My\Path\To\LLVM" . ..\third_party\ycmd\cpp

Or, if you don't want C family completion:

    cmake -G "Visual Studio 14" . ..\third_party\ycmd\cpp 

If you're not using VS 2015, replace `"Visual Studio 14"` with the appropriate version, and make sure to replace the LLVM path to wherever you installed LLVM. CMake should do its job and build the solution inside the ycmd_build directory. Open the solution, change to `Release` and build `ycm_core` and `ycm_client_support`. If set up properly, this should build the `ycm_core.pyd`, `ycm_client_support.pyd` and `libclang.dll` into `YouCompleteMe\third_party\ycmd`. If it didn't, copy them from the build folder (usually `ycmd_build\Release`, if not, search for them using file explorer inside the `ycmd_build` folder) into `YouCompleteMe\third_party\ycmd`. Run Vim or gVim. If you get a pop-up message about the application loading an incorrect version of the C runtime (not the exact message) you're in for a fun time. CMake and other applications are distributed with old versions of the C runtime dlls that Microsoft calls redistributables. By including the directory where these live in your PATH environment variable, programs decide to load it instead of the newer versions. 

### Fixing your PATH

If you didn't get the horrible message about the C runtime being incorrect, hurray! You've successfully compiled YCM, happy Viming! If you did get the message, it's time to fix it. You will have to look for two offending files:

    msvcr90.dll, msvcp90.dll

You can use a Windows tool named `where`. It takes executable/dll name and searches all directories mentioned in PATH environment variable. Found locations are printed as a result. Open a command prompt and type in:

    where msvcr90.dll msvcp90.dll

So, essentially, these dlls are old versions of Microsoft's runtime. One offending app that has these is CMake. What I've done is copy the newer dlls into the folder, renaming them as the old ones. I don't know if this is something you shouldn't do, but CMake still works for me and I can run Vim with YCM on Windows. 
Another solution that has worked for a peer is renaming the file such as `msvcr90x.dll` so that it doesn't load it but you keep the file in case it's a bad idea to delete.

There are other potentially offending directories; Intel directories are one of the most common. 

This part of the guide was written by user IkerGimenez, please let me know if any of this doesn't work or changes.
Happy Viming!

***

# Pre-Built Binaries

If you are not a masochist, then it's probably better to download pre-built and ready-to-use distributions of YCM for Windows. One reliable option is [Vim YouCompleteMe for Windows](https://bitbucket.org/Alexander-Shukaev/vim-youcompleteme-for-windows). Both x86 and x64 architectures are supported. The installation guide and coverage of common pitfalls are included.

**C# semantic completion using this method:**

C:\Users\Dave\
For c# semantic completion cd into `~\vimfiles\third_party\ycmd\third_party\OmniSharpServer` (or e.g. `~\vimfiles\bundle\third_party\ycmd\third_party\OmniSharpServer`) then build it with `msbuild` or VC Express 2012/2013 if it isn't already built. In VC Express 2013 you simply Right Click on the solution, click Build, then confirm the output states `9 Succeeded`.

After this, head into vim, load a C# file, then run `:YcmCompleter StartServer`. If there are no errors, you've been successful. Good job!

# Instructions for 64-bit using Visual Studio 2012 Express

Here's a sequence of steps that worked on Windows 7 x64. These instructions build YCM **without** semantic support for C-family languages.

1. Install [Visual Studio 2012 Express for Windows Desktop][vse].
2. [Download Python 2.7 x86-64 for Windows][python-dl].
3. **IMPORTANT:** You need to have a 64-bit build of Vim for YCM to work. [Haroogan][x64vim] has 64-bit builds that are confirmed working.
4. [Install CMake][cmake].
5. [Install Vundle][vundle-win].
6. Install YCM with Vundle.
7. Create a build directory and `cd` into it.
8. Run `cmake -G "Visual Studio 11 Win64" . <USERFOLDER>\vimfiles\bundle\YouCompleteme\third_party\ycmd\cpp`
    * If it fails by saying that Python could not be found, then do the following:
        1. Delete _everything_ in your build directory first.
        2. Make sure you installed Python 2.7 x64, not x86.
9. Open the SLN file in VS2012, change to Release mode (`Build -> Config Manager -> Active Solution Config -> Release` in VS2012) and build **just** the `ycm_core` project by right clicking on it in the Solution Explorer and choosing `Project Only -> Build Only ycm_core`. You'll probably see tons of warnings during the build; ignore them. If you get the error about `..\BoostParts\Release\BoostParts.lib` missing, build `BoostParts` first using the same right click menu, then build `ycm_core` again. The build product will be a `ycm_core.pyd` in your `YouCompleteMe\python` folder. 
    * You can also build it from the command line with `msbuild` (Normally located in `C:\Windows\Microsoft.NET\Framework64\v4.0.xxxxx`):
    `msbuild /t:ycm_core /property:configuration=Release YouCompleteMe.sln`
10. Copy `ycm_core.pyd` from `ycm\Release` to `<USERFOLDER>\vimfiles\bundle\YouCompleteMe\python` if it's not there already.


If you want semantic support for C-family languages, look for instructions below.

Note that Clang's support for Windows is still very experimental; if you try to
enable C-family semantic support in YCM using a libclang you compiled yourself
(or got somewhere else, doesn't matter), it's possible you'll have Vim locking
up and/or crashing on some C/C++/Objective-C files. If this happens, try to
compile your file with the raw `clang` binary, using the same flags that YCM is
giving libclang (you can see those by calling `:YcmDebugInfo` with your file as
the active buffer). If clang fails to compile the file, you've encountered a
clang issue, not a YCM one.

# Instructions for 64-bit using MinGW64

Here's a sequence of steps that worked on Windows 8 x64. These instructions build YCM **without** semantic support for C-family languages.  
**IMPORTANT:** If you use version 4.8.1 or greater it is very likely that error ``undefined reference to `InterlockedCompareExchange'`` will occur. In that case use earlier version of compiler or after step 6. replace file `cpp\BoostParts\boost\detail\interlocked.hpp` with [that file][interlocked].

1. Download the -win64 version of [MinGW64][mingw64]. Extract the archive to `C:\MinGW64` and add `C:\MinGW64\bin` to your PATH
2. Install [Python 2.7 x86-64 for Windows][python-dl].
3. **IMPORTANT:** You need to have a 64-bit build of Vim for YCM to work. [Haroogan][x64vim] has 64-bit builds that are confirmed working.
4. Install [CMake][cmake].
5. Install [Vundle][vundle-win].
6. Install YouCompleteMe using Vundle.
8. Edit `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\CMakeLists.txt` and add the following lines:  
    `set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -include cmath")`  
    `add_definitions(-DBOOST_PYTHON_SOURCE)`  
    `add_definitions(-DBOOST_THREAD_BUILD_DLL)`  
    `add_definitions(-DMS_WIN64)`  
9. Edit `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\ycm\ycm_core.cpp` and comment out the last three lines so they look like this:  
    `// namespace boost {`  
    `// void tss_cleanup_implemented() {}`  
    `// };`
7. Create a `build` directory and `cd` into it.
10. Run `cmake -G "MinGW Makefiles" . %USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp`. If you have ever renamed the MinGW's make program (originally `mingw32-make.exe`), then you should probably add the following argument to let cmake know where to find it:
    `-D"CMAKE_MAKE_PROGRAM:PATH=C:/MinGW64/bin/NAME-OF-YOUR-MAKE.exe"` 
11. Run `mingw32-make ycm_core` (Don't worry about the `32` in that command)
12. Copy `ycm_core.pyd` from `ycm\` to `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\python`

# Instructions for 64-bit using MinGW64 (clang)

Here's a sequence of steps that worked on Windows 7 x64. These instructions build YCM **with** semantic support for C-family languages.

1. Download the -win64 mingw-builds version of [MinGW-w64][mingw-builds]. Extract the archive to `C:\MinGW64` and add `C:\MinGW64\bin` to your PATH
2. Install [Python 2.7 x86-64 for Windows][python-dl] to `C:\Python27`.
3. You can try to [make libpython27.a][libpython-stack] or download from [here][libpython-dl] (tip: you can unpack installer with 7-Zip). Make sure that you put libpython27.a in `C:\Python27\libs` directory.
4. Compile LLVM with clang or [download][clang-haroogan] again from Haroogan. Click on [proper number][clang-haroogan-dl] in download section to download LLVM. Unpack it to `C:\LLVM`
5. You need to have a 64-bit build of Vim for YCM to work. [Haroogan][x64vim] has 64-bit builds that are confirmed working.
6. Install [CMake][cmake].
7. Install:
    * [Vundle][vundle-win] and install YouCompleteMe using Vundle
    * **OR** [Pathogen], make dir in `vimfiles\bundle\YouCompleteMe`, `cd` in `Git Bash` into it and run:  
    `git clone https://github.com/Valloric/YouCompleteMe .`  
    `git submodule update --init --recursive`
8. Replace file `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\BoostParts\boost\detail\interlocked.hpp` with [that file][interlocked].
9. Edit `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp\CMakeLists.txt` and add the following lines:  
    `set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -include cmath")`  
    `add_definitions(-DBOOST_PYTHON_SOURCE)`  
    `add_definitions(-DBOOST_THREAD_BUILD_DLL)`  
    `add_definitions(-DMS_WIN64)`  
10. Create a `build` directory and `cd` into it.
11. Run `cmake -G "MinGW Makefiles" -DPATH_TO_LLVM_ROOT=C:\LLVM . %USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp`. If you have ever renamed the MinGW's make program (originally `mingw32-make.exe`), then you should probably add the following argument to let cmake know where to find it:
    `-D"CMAKE_MAKE_PROGRAM:PATH=C:/MinGW64/bin/NAME-OF-YOUR-MAKE.exe"` 
12. Run `mingw32-make ycm_support_libs` (Don't worry about the `32` in that command)
13. (Obsolete) Copy `ycm_core.pyd`, `ycm_client_support.pyd`, and `libclang.dll` from `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\third_party\ycmd` to `%USERPROFILE%\vimfiles\bundle\YouCompleteMe\python`

**Possible errors:**
* "cmake exit with error and linking to wrong compilers/libraries"  
    - Check if you have YouCompleteMe and build directory on the same drive (in this guide `C:\`) as MinGW, Python and LLVM.
* if Vim :version  indicates +python/dyn  then Vim was compiled with Python2 support - that's good.
  but if Vim :echo has('python') returns 0 then you have the wrong memory model of Python2 installed - bad.
* Could NOT find PythonLibs (missing: PYTHON_LIBRARIES PYTHON_INCLUDE_DIRS) - caused by %PATH% problems - and not necessarily with Python! 
* step 12. make (90%) - Linking CXX shared library C:\Users\P\vimfiles\bundle\YouCompleteMe\third_party\
ycmd\ycm_core.pyd - C:/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.8.2/../../../../x86_64-w64-mingw3
2/bin/ld.exe: i386 architecture of input file `C:\Python27\libs\libpython27.a(du
ks00143.o)' is incompatible with i386:x86-64 output... This is caused by forgetting to reinstall libpython27.a in step 3. after reinstalling Python 2.7 in step 2.
* "during linking stage occurs ``undefined reference to `Interlocked...'`` error"  
    - If you are sure that you made step 8. correctly, then probably is error in boost libraries. Wait for update of YouCompleteMe's Boost library or use Google to resolve that issue and then update wiki, please.
* "during compiling stage occurs ``undefined reference to `__imp__Py_...'``"  
    - delete all files from build directory, check if `libpython27.a` is in `C:\Python27\libs` directory and repeat from step 11. Check if cmake found `libpython27.a`.
* during linking stage "..\BoostParts\libBoostParts.a(tss_dll.cpp.obj):tss_dll.cpp:(.text+0x70): multiple definition of `boost::tss_cleanup_implemented()'"
    - comment out  `namespace boost { void tss_cleanup_implemented() {} };` in `ycm_client_supprt.cpp and ycm_core.cpp`
* if you compiled LLVM on windows with mingw following the instructions at http://stackoverflow.com/questions/9427356/how-to-compile-clang-on-windows note that PATH_TO_LLVM_ROOT will actually need to point to the location of the clang folder under tools, not the top level LLVM folder

# Instructions for Cygwin64 (w/o clang)

References: 

\[1\] http://stackoverflow.com/a/21820642

\[2\] https://sourceforge.net/projects/cygwin-ports/

\[3\] https://github.com/Valloric/YouCompleteMe/issues/684

### Prerequisites
1. `gcc --version == 4.9.X`
  * You can find this in the cygwin setup installer. Just downgrade gcc.
  * If your cygwin only has `gcc >= 5.0`, this guide *might* work, but if it fails, try and compile `clang > 3.7`, using an equivalent version of `cygwin-clang.patch`, listed in the next step.
2. Download or copy the cygwin64 boost.python patch from this [gist](https://gist.github.com/bittwiddler1/6fd883de4067d6a1d56a). Place this in `~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/` and name it `cygwin64.BoostParts.patch`

### Instructions
1. Compile YCM as follows:
```
$ cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/
$ rm *.dll *.dll.a 
$ mkdir -pv cpp/build && cd cpp/
$ patch -p2 < cygwin64.BoostParts.patch #fix boost for cygwin64. Might not be necessary in future YCM released
$ cd build/
$ cmake -DCMAKE_BUILD_TYPE=Release  ..
$ make # replace with make -j <num-of-cores> for speed.
```
2. To test that the ycm_core.dll does not cause any segfaults in python attempt the following:
```
$ cd ../../ 
$ python.exe # Load python prompt
Python 2.7.10 (default, Jun  1 2015, 18:05:38)
[GCC 4.9.2] on cygwin
Type "help", "copyright", "credits" or "license" for more information.
>> import ycm_core
```
3. If there are no errors, exit python by typing `quit()` and hitting enter or hit Ctrl-D.
4. YCM should work fine in cygwin now! Make sure you've set up your global and per-project .ycm_extra_conf files!

Enjoy!

# Instructions for Cygwin64 (w/ clang)
___Disclaimer: This is what worked for me___

Recent versions of cygclang.dll (>3.5) have made some runtime changes that result in python suffering a STATUS_ACCESS_VIOLATION when loading ycm_core.dll (in both 32-bit cygwin and 64-bit cygwin) when using the cygwin-provided development packages (as mentioned below). 

Since there are no prepackaged builds of clang or llvm for cygwin that do not have this issue, and simply compiling clang leads to #include file search failures, I've written a guide on patching clang using the cygport project's llvm patches.

References:

\[1\] http://stackoverflow.com/a/21820642

\[2\] https://sourceforge.net/projects/cygwin-ports/

\[3\] https://github.com/Valloric/YouCompleteMe/issues/684


### Prerequisites
1. `gcc --version == 4.9.X`
  * You can find this in the cygwin setup installer. Just downgrade gcc.
  * If your cygwin only has `gcc >= 5.0`, this guide *might* work, but if it fails, try and compile `clang > 3.7`, using an equivalent version of `cygwin-clang.patch`, listed in the next step.
2. Download or copy the cygwin64 boost.python patch from this [gist](https://gist.github.com/bittwiddler1/6fd883de4067d6a1d56a). Place this in `~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/` and name it `cygwin64.BoostParts.patch`
3. Download [3.5.1-cygwin-clang.patch](https://sourceforge.net/p/cygwin-ports/cygwin64-clang/ci/5e3186c8de06b171cd9d5a3e1da58805c15bbf73/tree/3.5.1-cygwin-clang.patch)
  * If your cygwin installation only provides `gcc >= 5`, get the patch for clang > 3.7 [here](https://sourceforge.net/p/cygwin-ports/cygwin64-clang/ci/master/tree/)
4. Grab the `llvm-x.y.z` and `clang-x.y.z` sources from the [llvm website](http://llvm.org/releases/download.html)

### Instructions
1. Untar these sources as follows:
```
$ LLVM_VERSION="x.y.z" # replace x.y.z with your version, such as 3.5.1
$ mkdir -pv ~/downloads/src/ && cd ~/downloads/src
$ mv <path-to-llvm-tarfile> . && mv <path-to-clang-tarfile> . 
$ tar xvf llvm-${LLVM_VERSION}.src.tar.xz  
$ cd llvm-${LLVM_VERSION}.src/tools/ && mkdir -pv clang &&  tar xvf ../../cfe-${LLVM_VERSION}.src.tar.xv -C clang --strip-components=1
$ cd ..
$ patch -p2 < ../${LLVM_VERSION}-cygwin-clang.patch #Patch clang for cygwin
$ unset LLVM_VERSION
```
2. Compile    
```
$ ./configure --enable-optimizations --disable-assertions --enable-shared # If the configure command complains about libffi, install libffi-devel ether through setup-x86_64.exe or apt-cyg and re-run it.
$  make && make install # you can also use make -j <number> && make -j <number> install, where <number> is the number of CPU cores you wish to use to compile.
```
3. Check that `/usr/local/bin/cygclang.dll` exists.
4. Compile YCM as follows:
```
$ cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd/
$ rm *.dll *.dll.a 
$ mkdir -pv cpp/build && cd cpp/
$ patch -p2 < cygwin64.BoostParts.patch #fix boost for cygwin64. Might not be necessary in future YCM released
$ cd build/
$ cmake -DCMAKE_BUILD_TYPE=Release -DUSE_SYSTEM_BOOST=OFF -DEXTERNAL_LIBCLANG_PATH=/usr/local/bin/cygclang.dll ..
$ make # replace with make -j <num-of-cores> for speed.
```
6. To test that the ycm_core.dll does not cause any segfaults in python attempt the following:    
```    
$ cd ../../ 
$ python.exe # Load python prompt
Python 2.7.10 (default, Jun  1 2015, 18:05:38)
[GCC 4.9.2] on cygwin
Type "help", "copyright", "credits" or "license" for more information.
>> import ycm_core
```
7. If there are no errors, exit python by typing `quit()` and hitting enter or hit Ctrl-D.
8. YCM should work fine in cygwin now! Make sure you've set up your global and per-project .ycm_extra_conf files!

Enjoy!

# The cygwin instructions below are out of date and no longer work
## Instructions for Cygwin (non-clang)

Make sure to use the Cygwin packages of python, gcc4, and cmake--not the downloadable windows binaries of CMake and Python. 

If you use Cygwin 64bit you may see an error regarding LONG BIT improperly defined, to fix see [issue 684] for instructions on patching boost.

0. Compile VIM (might not be necessary if the cygwin Vim version is greater than 7.3.538): https://gist.github.com/saamalik/5808448
1. Install the following packages through Cygwin setup.exe: *python*, *gcc4*, *CMake*, and *make*. Versions I used: `python-2.7.3-1`, `gcc-4.5.3-3`, and `cmake-2.8.9-2`, 
2. `cd ~/.vim/bundle/YouCompleteMe`
3. `mkdir build_cygwin && cd build_cygwin`
4. `cmake -G "Unix Makefiles" . ../cpp` # ignore the legacy cygwin error bla bla bla
5. `make ycm_core`
6. `make ycm_client_support`
7. `cd ~/.vim/bundle/YouCompleteMe/python/`
8. `cp ~/.vim/bundle/YouCompleteMe/build_cygwin/ycm/ycm_core.pyd ycm_core.dll` # notice the extension rename--cygwin python imports dll, pyc, and py extensions (NOT pyd)
9. `cp ~/.vim/bundle/YouCompleteMe/build_cygwin/ycm/ycm_client_support.pyd ycm_client_support.dll`

I've uploaded my compiled version to (2013-08-31): https://github.com/saamalik/dotvim/tree/master/windows/windows_binaries

## Instructions for Cygwin (clang)
Note: This is very naive manual, somebody should be able to do it better. I am writing it from my memory.

If you use Cygwin 64bit you may see an error regarding LONG BIT improperly defined, to fix see [issue 684] for instructions on patching boost.

Make sure to use the Cygwin packages of python, gcc4, and cmake--not the downloadable windows binaries of CMake and Python. Be sure that you are NOT using cygwin clang packages. You cannot use cygwin clang, because there is an old version of it. (you need at least version 3.2). Following note has been taken with clang 3.4.  

1. Download and compile LLVM and clang and follow their manual http://clang.llvm.org/get_started.html. Use the config options: `--enable-optimized` and `--disable-assertions` for configure.  
2. I was not able to finish `make` with LLVM/CLANG under the cygwin (with cmake generated Makefiles), but if you are, you should have clang installed in /usr/local/ directory.  
If `make` fails for you too in the test phase (after message "Linking CXX executable ../../../../bin/c-index-test.exe" message), follow 3 else follow 6.  
3. Copy llvm/include into the /usr/local/include  
4. Copy llvm/tools/clang/ /usr/local/include  
5. Copy directories {bin, include, lib, share} from your clang build directory into the /usr/local  
6. Compile YCM:  
   `cd ~/.vim/bundle/YouCompleteMe`  
   `mkdir build_cygwin && cd build_cygwin`  
   `cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/usr/local -DTEMP=/usr/local/bin/cygclang.dll . ../cpp`  
   `make ycm_core`  
7. `cp ~/.vim/bundle/YouCompleteMe/build_cygwin/ycm/ycm_core.pyd ycm_core.dll` # notice the extension rename--cygwin python imports dll, pyc, and py extensions (NOT pyd)
   
***
## Not Supported:
__Hi, all! I had found a better way to compile YCM under Cygwin with clang was installed__

* There is no need to build clang by yourself, you just need to install clang binary in Cygwin setup.exe  
First, modify these lines like below in ~/.vim/bundle/YouCompleteMe/third_party/ycmd/build.sh  
* Before modify:  
`cmake_args=""  `  
`omnisharp_completer=false  `  
`for flag in $@; do  `  
`  case "$flag" in  `  
`    --clang-completer)  `  
`      cmake_args="-DUSE_CLANG_COMPLETER=ON"  `  
`      ;;  `  
`    --system-libclang)  `  
`      cmake_args="$cmake_args -DUSE_SYSTEM_LIBCLANG=ON"  `  
`      ;;  `  
`    --omnisharp-completer)  `  
`      omnisharp_completer=true  `  
`      ;;  `  
`    *)  `  
`      usage  `  
`      ;;  `  
`  esac  `  
`done  `  

* After modify:  
`cmake_args="-DEXTERNAL_LIBCLANG_PATH=/usr/lib/libclang.dll.a"  `  
`omnisharp_completer=false  `  
`#for flag in $@; do  `  
`#  case "$flag" in  `  
`#    --clang-completer)  `  
`#      cmake_args="-DUSE_CLANG_COMPLETER=ON"  `  
`#      ;;  `  
`#    --system-libclang)  `  
`#      cmake_args="$cmake_args -DUSE_SYSTEM_LIBCLANG=ON"  `  
`#      ;;  `  
`#    --omnisharp-completer)  `  
`#      omnisharp_completer=true  `  
`#      ;;  `  
`#    *)  `  
`#      usage  `  
`#      ;;  `  
`#  esac  `  
`#done  `  

* Then, run these command:  
`cd ~/.vim/bundle/YouCompleteMe`  
`./install.sh`  

# Build instructions with Visual Studio Express  

You will need [Visual Studio Express][vse] installed, or you can also install the [Windows SDK][winsdk], which are the command-line only tools.  These instructions are mostly minor modifications to the more detailed 64-bit instructions above, but for brevity here they are as follows:

1. Install the latest version of [Cream][cream].  This distribution contains 32-bit installers of Vim with the latest patches and is updated regularly.  YCM requires at least 7.3.584 installed.
2. You will need 32-bit versions of Python and CMake.  If you have [Chocolatey][chocolatey], you can `cinst python.x86` and `cinst cmake`, otherwise you will need to install these manually.
3. Install YCM with Pathogen/Vundle/etc.
4. Open a command prompt with the SDK utilities included in the PATH (e.g. msbuild.exe is in the %PATH%).
5. `cd path\to\YouCompleteMe\third_party\ycmd`
6. `cmake -G "Visual Studio 11" cpp`
7. `msbuild /t:ycm_core;ycm_client_support /property:configuration=Release YouCompleteMe.sln`

# Instructions for compiling YCM with Clang support
 Now prebuilt Clang snapshots are available on the [LLVM snapshot builds](http://llvm.org/builds/) site. you don't need to compile it yourself, get latest Windows snapshot build from that page.

1. Install all requirements from the instructions above. Dont compile anything yet.
2. Create a build directory and `cd` into it.
3. Suppose you've successfully installed Clang from installer in a `C:\LLVM` dir. Now, run `cmake -G "Visual Studio 11" -DPATH_TO_LLVM_ROOT=C:\LLVM . <USERFOLDER>\vimfiles\bundle\YouCompleteMe\third_party\ycmd\cpp`. Dont forget to change a VS version and a path to Clang build dir if you are using different VS version or build path.
4. Now build `ycm_core` solution. If you are getting errors like:
    * `'boost::bind' : ambiguous call to overloaded function`. This issue was fixed, try updating to the latest version of YCM.
    * `unresolved external symbol __imp__clang_createIndex` - that means that linker cant find Clang libraries. Check your path specified in `Configuration Properties -> Linker -> Input -> Additional Dependencies` field.
5. If building successfully finished, `ycm_core.pyd` and **and** `libclang.dll` should have been copied to  ``<USERFOLDER>\vimfiles\bundle\YouCompleteMe\third_party\ycmd``.

[Vim YouCompleteMe for Windows]: https://bitbucket.org/Haroogan/vim-youcompleteme-for-windows/
[vse]: http://www.microsoft.com/visualstudio/eng/downloads#d-express-windows-desktop
[vim-msvc]: https://code.google.com/p/vim/source/browse/src/INSTALLpc.txt
[python-dl]: http://www.python.org/getit/
[libpython-stack]: http://stackoverflow.com/questions/11182765/how-can-i-build-my-c-extensions-with-mingw-w64-in-python
[libpython-dl]: http://www.lfd.uci.edu/~gohlke/pythonlibs/#libpython
[vundle-win]: https://github.com/gmarik/vundle/wiki/Vundle-for-Windows
[pathogen]: https://github.com/tpope/vim-pathogen
[cmake]: http://www.cmake.org/cmake/resources/software.html
[x64vim]: https://bitbucket.org/Haroogan/vim-for-windows/src
[cream]: http://sourceforge.net/projects/cream/files/Vim/
[chocolatey]: http://chocolatey.org
[winsdk]: http://msdn.microsoft.com/en-US/windows/desktop/hh852363.aspx
[clang]: http://clang.llvm.org/get_started.html
[clang-haroogan]: https://bitbucket.org/Haroogan/llvm-for-windows/src
[clang-haroogan-dl]: https://bitbucket.org/Haroogan/llvm-for-windows/downloads/llvm-3.4-mingw-w64-4.8.1-x64-posix-sjlj.zip
[mingw64]: http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/rubenvb/gcc-4.8-release/
[mingw-builds]: http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/4.8.2/threads-posix/sjlj/
[interlocked]: https://github.com/Reikion/YouCompleteMe/blob/master/cpp/BoostParts/boost/detail/interlocked.hpp
[issue 684]: https://github.com/Valloric/YouCompleteMe/issues/684
