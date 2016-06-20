# =============================================================================
#   FileName: updatevim.sh
#       Desc: update gvim.exe and vim.exe
#     Author: Marslo
#      Email: marslo.jiao@gmail.com
#    Created: 2015-09-17 18:20:27
#    Version: 0.0.3
# LastChange: 2016-04-19 10:41:58
#    History:
#             0.0.1 | Marslo | init
#             0.0.2 | Marslo | Build vim win64
#             0.0.3 | Marslo | Add ruby in
#             0.0.4 | Marslo | Add scp way to upload binary
# =============================================================================

sour=$HOME/../../Marslo/Tools/Git/vim/src
dsk=$HOME/Desktop/vim
UPLOAD_FLAG=true

if [ ! -d "${sour}" ];
then
  echo 'Cannot found vim source. Exit.'
  exit 1
fi

pushd ${sour}
git clean -dfx *
make clean
git checkout -- *


echo '-----------------------------------'
git tag --sort=v:refname | grep 'v7.4\.' | tail -30
latestver=`git tag --sort=v:refname | grep 'v7.4\.' | tail -1 | awk -F'v7.4.' '{print $2}'`

git status | grep "On branch master"
if [ 0 -eq $? ]; then
  origver=${latestver}
else
  origver=`git status | grep v7 | awk -F'7.4.' '{print $2}'`
fi

if [ 0 -eq ${#origver} ]; then
  origver=${latestver}
fi
curver=$(( ${origver}+1 ))

git checkout master
git pull

echo '-----------------------------------'
latestver=`git tag --sort=v:refname | grep 'v7.4\.' | tail -1 | awk -F'v7.4.' '{print $2}'`

if [ ${origver} -eq ${latestver} ]
then
  echo 'No new update. Exit'
  exit 0
fi

echo ${origver}
echo ${curver}
echo ${latestver}

for i in `seq -w ${curver} ${latestver}`
do
  ver=7.4.${i}
  targ=${dsk}/${ver}
  echo "----------------------------------- ${ver} --------------------------------------"

  git checkout tags/v${ver}

  make -j 12 -B -f Make_cyg.mak CROSS_COMPILE=x86_64-w64-mingw32- ARCH=x86-64 PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35 RUBY=/cygdrive/c/Marslo/MyProgramFiles/Ruby23-x64 DYNAMIC_RUBY=yes RUBY_VER=23 RUBY_VER_LONG=2.3.0 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=yes > log_gui_${ver}.log 2>&1
  make -j 12 -B -f Make_cyg.mak CROSS_COMPILE=x86_64-w64-mingw32- ARCH=x86-64 PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35 RUBY=/cygdrive/c/Marslo/MyProgramFiles/Ruby23-x64 DYNAMIC_RUBY=yes RUBY_VER=23 RUBY_VER_LONG=2.3.0 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=no > log_nogui_${ver}.log 2>&1

  mkdir -p ${targ}
  if [ -f ${sour}/vim.exe ]; then
    cp ${sour}/vim.exe ${targ}
  else
    UPLOAD_FLAG=false
    mv ${sour}/log_nogui_${ver}.log ${targ}
  fi

  if [ -f ${sour}/gvim.exe ]; then
    cp ${sour}/gvim.exe ${targ}
  else
    UPLOAD_FLAG=false
    mv ${sour}/log_gui_${ver}.log ${targ}
  fi

  if ${UPLOAD_FLAG}; then
    scp -i ~/../../Marslo/Tools/Software/System/RemoteConnection/AuthorizedKeys/Marslo\@Appliance -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -r ${targ} marslojiao@frs.sourceforge.net:/home/frs/project/marslos-vim-64/${ver}
  fi
done

popd
