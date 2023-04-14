#!/bin/bash

YEL='\033[1;33m' # Yellow
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

# --help
displayHelp () {
	printf "\n" &&
	printf "${bold}${GRE}Script to add libjxl support over the Chromium source tree.${c0}\n" &&
	printf "\n"
}

case $1 in
	--help) displayHelp; exit 0;;
esac

printf "\n" &&
printf "${YEL}Adding libjxl support over the Chromium tree...\n" &&
tput sgr0 &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git stash &&

cd $HOME/chromium/src &&

git stash &&

git fetch https://chromium.googlesource.com/chromium/src refs/changes/56/4257656/66 && git cherry-pick FETCH_HEAD &&

gclient sync &&

gclient runhooks &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git stash pop &&

cd $HOME/chromium/src &&

git stash pop &&

cd $HOME/chromium/src/third_party/devtools-frontend/src &&

git fetch https://chromium.googlesource.com/devtools/devtools-frontend refs/changes/82/4257582/35 && git cherry-pick FETCH_HEAD &&

cd $HOME/chromium-compile &&

cp -r -v libjxl/ $HOME/chromium/src/third_party/ &&

printf "${YEL}Done!\n" &&
printf "\n" &&
tput sgr0

exit 0
