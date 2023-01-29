#!/usr/bin/env bash
# shellcheck disable=SC2089

set -o errexit

HAS_GETTEXT=1
VIMCMD='src/vim'
PREFIX='/usr/local/vim'
LANGOPT="--enable-perlinterp "
LANGOPT+="--enable-python3interp --with-python3-config-dir=$(python3-config --configdir) "
LANGOPT+="--enable-rubyinterp "
LANGOPT+="--enable-luainterp --with-lua-prefix=/usr/local "
CONFOPT="--prefix=${PREFIX} --with-features=huge --with-tlib=ncurses --with-macarchs=x86_64 --enable-terminal "
CONFOPT+="--enable-autoservername --enable-multibyte -enable-libsodium --enable-nls "
CONFOPT+="--with-compiledby='marslo <marslo.jiao@gmail.com>' "
# CONFOPT+="--enable-gui=yes --with-x --enable-macos-x --enable-darwin --enable-fontset --enable-xim "
# CONFOPT+="--enable-cscope "             # will casue kill:9

dll_ruby='/usr/local/opt/ruby/lib/libruby.dylib'
dll_perl='/System/Library/Perl/5.30/darwin-thread-multi-2level/CORE/libperl.dylib'
dll_python3="$(python3-config --prefix)/Python"

macvim_excmd() {
  ${VIMCMD} -u NONE -i NONE -f -X -V1 -es "$@" -c 'echo ""' -c 'qall!' 2>&1
}

echo -e "\n\\033[33;1m... Configuring MacVim ...\\033[0m\n"

NPROC=$(getconf _NPROCESSORS_ONLN)
make distclean

echo -e "\n\\033[33;1m.... Configuring via ....\\033[0m\n"
echo -e "\t\\033[32;1m ${CONFOPT} ${LANGOPT} --enable-fail-if-missing \\033[0m\n"
# shellcheck disable=SC2090,SC2086
./configure ${CONFOPT} ${LANGOPT} --enable-fail-if-missing
sed -i.bak \
    -f "$HOME"/iMarslo/tools/git/utils/vim/vim/ci/config.mk.sed \
    -f "$HOME"/iMarslo/tools/git/utils/vim/vim/ci/config.mk.clang.sed \
    src/auto/config.mk

perl -p -i -e "s#(?<=-DDYNAMIC_RUBY_DLL=\\\\\").*?(?=\\\\\")#${dll_ruby}#" src/auto/config.mk

if [[ -n "${LANGOPT}" ]]; then
  grep -q -- "-DDYNAMIC_PERL_DLL=\\\\\"${dll_perl}\\\\\"" src/auto/config.mk
  grep -q -- "-DDYNAMIC_PYTHON3_DLL=\\\\\"${dll_python3}\\\\\"" src/auto/config.mk
  grep -q -- "-DDYNAMIC_RUBY_DLL=\\\\\"${dll_ruby}\\\\\"" src/auto/config.mk
fi

echo -e "\n\\033[33;1m... Building MacVim ...\\033[0m\n"
# shellcheck disable=SC2086
make -j${NPROC}
echo -e ".. \\033[33;1mEnd Build\\033[0m .. OK\n"
${VIMCMD} --version

set +o errexit

echo -e "\n\\033[33;1m... Smoketest ...\\033[0m\n"
if [[ -n "${LANGOPT}" ]]; then macvim_excmd -c 'lua print("Test")'; fi
if [[ -n "${LANGOPT}" ]]; then macvim_excmd -c 'perl VIM::Msg("Test")'; fi
if [[ -n "${LANGOPT}" ]]; then macvim_excmd -c 'py3 import sys; print("Test")'; fi
if [[ -n "${LANGOPT}" ]]; then macvim_excmd -c 'ruby puts("Test")'; fi
if [[ -n "${HAS_GETTEXT}" ]]; then macvim_excmd -c 'lang es_ES' -c 'version' | grep Enlazado; fi
otool -L "${VIMCMD}" |  grep '\.dylib\s' | grep -v '^\s*/usr/lib/'
lipo -archs ${VIMCMD} | grep '^x86_64$'
echo -e ".. \\033[33;1mEnd Smoketest\\033[0m .. OK\n"

echo -e "\n\\033[33;1m... Testing MacVim ...\\033[0m\n"
# make test
# make -C runtime/doc vimtags VIMEXE=../../${VIMCMD}
make indenttest
echo -e ".. \\033[33;1mEnd Test\\033[0m .. OK\n"

sudo make uninstall
sudo make install
sudo cp -f ${VIMCMD} ${PREFIX}/bin
md5sum "${VIMCMD}"
md5sum "${PREFIX}/bin/vim"

# vim: ft=sh ts=2 sts=2 sw=2 et
