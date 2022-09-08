#!/bin/bash -x

# =============================================================================
#   FileName: updatevim.sh
#       Desc: update gvim.exe and vim.exe by cygwin. Visual Studio way: https://tuxproject.de/projects/vim/_compile.bat.php
#     Author: marslo.jiao@gmail.com
#    Created: 2015-09-17 18:20:27
# LastChange: 2017-02-09 17:28:32
# =============================================================================

sour=$HOME/../../marslo/Tools/Git/vim/src
# dsk=$HOME/Desktop/vim
dsk=/cygdrive/d/marslo/vim
# dsk=/d/marslo/im
UPLOAD_FLAG=true
PY_PATH=/cygdrive/c/marslo/myprogramfile/Python27
PY3_PATH=/cygdrive/c/marslo/myprogramfile/Python38
RB_PATH=/cygdrive/c/marslo/myprogramfile/Ruby27-x64
PY_VER=27
PY3_VER=38
RB_VER=27
RB_LONG_VER=2.7.0
VIM_VER=8.2

if [ ! -d "${sour}" ]; then
  echo 'Cannot found vim source. Exit.'
  exit 1
fi

pushd ${sour}
git clean -dfx *
make clean
git checkout -- *


echo '-----------------------------------'
git tag --sort=v:refname | grep v${VIM_VER}'\.' | tail -30
latestver=$(echo "$(git tag --sort=v:refname | grep -v -E '^v8.2.0$' | grep -i v${VIM_VER}'\.' | tail -1 | awk -F${VIM_VER}. '{print $2}') + 0" | bc)

git status | grep "On branch master"
if [ 0 -eq $? ]; then
  curver=${latestver}
else
  curver=$(git status | grep v${VIM_VER} | awk -F"${VIM_VER}." '{print $2}')
fi

if [ 0 -eq ${curver} ]; then
  curver=${latestver}
fi
nextver=$(echo "${curver} + 1" | bc)

git checkout master
git pull

echo '-----------------------------------'
latestver=$(echo "$(git tag --sort=v:refname | grep -v -E '^v8.2.0$' | grep -i v${VIM_VER}'\.' | tail -1 | awk -F${VIM_VER}. '{print $2}') + 0" | bc)

if [ ${curver} -eq ${latestver} ]
then
  echo 'No new update. Exit'
  exit 0
fi

echo "current version: ${curver}"
echo "next version: ${nextver}"
echo "latest version: ${latestver}"

for i in `seq -w ${nextver} ${latestver}`
do
  ver=${VIM_VER}.`printf "%04d" ${i}`
  targ=${dsk}/${ver}
  echo "----------------------------------- ${ver} --------------------------------------"

  git checkout tags/v${ver}

  for _gui in yes no; do
    make -j 3 -B -f Make_cyg.mak \
        CROSS_COMPILE=x86_64-w64-mingw32- \
        ARCH=x86-64 \
        FEATURES=huge \
        IME=yes \
        GIME=yes \
        MBYTE=yes \
        CSCOPE=yes \
        CHANNEL=yes \
        TERMINAL=yes \
        USERNAME=marslo.Jiao \
        USERDOMAIN=China \
        PYTHON=$PY_PATH \
        DYNAMIC_PYTHON=yes \
        PYTHON_VER=$PY_VER \
        PYTHON3=$PY3_PATH \
        DYNAMIC_PYTHON3=yes \
        PYTHON3_VER=$PY3_VER \
        RUBY=$RB_PATH \
        DYNAMIC_RUBY=yes \
        RUBY_VER=$RB_VER \
        RUBY_VER_LONG=$RB_LONG_VER \
        GUI="${_gui}" > vim_gui_${_gui}_${ver}.log 2>&1
      done

  mkdir -p ${targ}
  if [ -f ${sour}/vim.exe ]; then
    cp ${sour}/vim.exe ${targ}
  else
    UPLOAD_FLAG=false
    mv ${sour}/vim.exe_${ver}.log ${targ}/vim.exe_${ver}_failed.log
  fi

  if [ -f ${sour}/gvim.exe ]; then
    cp ${sour}/gvim.exe ${targ}
  else
    UPLOAD_FLAG=false
    mv ${sour}/gvim.exe_${ver}.log ${targ}/gvim.exe_${ver}_failed.log
  fi

 UPLOAD_FLAG=false
 if ${UPLOAD_FLAG}; then
   scp -i ~/../../marslo/Tools/Software/System/RemoteConnection/AuthorizedKeys/marslo\@devops/marslo\@devops -o ProxyCommand='corkscrew 42.99.164.34 10015 %h %p' -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r ${targ} marslojiao@frs.sourceforge.net:/home/frs/project/marslos-vim-64/
 fi
done

popd

# COMMAND:
# make -j 3 -B -f Make_cyg.mak CROSS_COMPILE=x86_64-w64-mingw32- ARCH=x86-64 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=marslo.Jiao USERDOMAIN=China CHANNEL=yes TERMINAL=yes PYTHON=/cygdrive/c/marslo/myprogramfiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/marslo/myprogramfiles/Python38 DYNAMIC_PYTHON3=yes PYTHON3_VER=38 RUBY=/cygdrive/c/marslo/myprogramfiles/Ruby27-x64 DYNAMIC_RUBY=yes RUBY_VER=27 RUBY_VER_LONG=2.7.0 GUI=yes
# make -j 3 -B -f Make_cyg.mak CROSS_COMPILE=x86_64-w64-mingw32- ARCH=x86-64 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=marslo.Jiao USERDOMAIN=China CHANNEL=yes TERMINAL=yes PYTHON=/cygdrive/c/marslo/myprogramfiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/marslo/myprogramfiles/Python38 DYNAMIC_PYTHON3=yes PYTHON3_VER=38 RUBY=/cygdrive/c/marslo/myprogramfiles/Ruby27-x64 DYNAMIC_RUBY=yes RUBY_VER=27 RUBY_VER_LONG=2.7.0 GUI=no

# scp -i ~/../../marslo/Tools/Software/System/RemoteConnection/AuthorizedKeys/openssh/marslo\@philips -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r ${targ} marslojiao@frs.sourceforge.net:/home/frs/project/marslos-vim-64/
