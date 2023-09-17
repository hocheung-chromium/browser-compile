#!/bin/bash

YEL='\033[1;33m' # Yellow
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

printf "\n" &&
printf "${bold}${YEL}Adding libjxl support over the Chromium tree.${c0}\n" &&
tput sgr0 &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git stash &&

cd $HOME/chromium/src/v8 &&

git stash &&

cd $HOME/chromium/src &&

git stash &&

git fetch https://chromium.googlesource.com/chromium/src refs/changes/56/4257656/123 && git cherry-pick FETCH_HEAD &&

gclient sync &&

gclient runhooks &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git stash pop &&

cd $HOME/chromium/src/v8 &&

git stash pop &&

cd $HOME/chromium/src &&

git stash pop &&

cd $HOME/chromium/src/third_party/devtools-frontend/src &&

git fetch https://chromium.googlesource.com/devtools/devtools-frontend refs/changes/82/4257582/64 && git cherry-pick FETCH_HEAD &&

cd $HOME/chromium_compile &&

cp -r -v libjxl/src/lib/lib.gni $HOME/chromium/src/third_party/libjxl/src/lib/ &&

cp -r -v libjxl/src/lib/jxl_lists.bzl $HOME/chromium/src/third_party/libjxl/src/lib/ &&

printf "${bold}${GRE}Done!${c0}\n" &&
printf "\n" &&
tput sgr0

exit 0
