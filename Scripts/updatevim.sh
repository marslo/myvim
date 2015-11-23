#i =============================================================================
#   FileName: updatevim.sh
#       Desc: update gvim.exe and vim.exe
#     Author: Marslo
#      Email: marslo.jiao@gmail.com
#    Created: 2015-09-17 18:20:27
#    Version: 0.0.1
# LastChange: 2015-11-23 20:22:40
#    History:
#             0.0.1 | Marslo | init
# =============================================================================

sour=$HOME/../../Marslo/Tools/Git/vim/src

if [ ! -d "${sour}" ];
then
  echo 'Cannot found vim source. Exit.'
  exit 1
fi

pushd ${sour}
git clean -dfx *
make clean
git checkout -- *


origver=`git status | grep v7 | awk -F'7.4.' '{print $2}'`
curver=$(( ${origver}+1 ))
latestver=`git tag | grep 'v7.4\.' | tail -1 | awk -F'v7.4.' '{print $2}'`

if [ 0 -eq ${#origver} ]
then
  origver=${latestver}
fi

git checkout master
# git pull

latestver=`git tag | grep 'v7.4\.' | tail -1 | awk -F'v7.4.' '{print $2}'`

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
  targ=/cygdrive/c/Users/Marslo_Jiao/Desktop/vim/${ver}
  echo "----------------------------------- ${ver} --------------------------------------"

  git checkout tags/v${ver}
  make -B -f Make_cyg.mak PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=yes >log_gui_${ver}.log 2>&1
  make -B -f Make_cyg.mak PYTHON=/cygdrive/c/Marslo/MyProgramFiles/Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=/cygdrive/c/Marslo/MyProgramFiles/Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35 FEATURES=huge IME=yes GIME=yes MBYTE=yes CSCOPE=yes USERNAME=Marslo.Jiao USERDOMAIN=China GUI=no > log_nogui_${ver}.log 2>&1

  mkdir -p ${targ}
  mv ${sour}/vim.exe ${sour}/gvim.exe ${targ}
done

popd
