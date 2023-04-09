#!/bin/bash

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
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
	printf "${bold}${GRE}Script to Rebase/Sync Chromium repo on Linux.${c0}\n" &&
	printf "\n"
}

case $1 in
	--help) displayHelp; exit 0;;
esac

printf "\n" &&
printf "${bold}${GRE}Script to Rebase/Sync Chromium repo on Linux.${c0}\n" &&
printf "\n" &&
printf "${YEL}Rebasing/Syncing and running hooks...\n" &&
tput sgr0 &&

cd $HOME/chromium/src/v8/ &&

git checkout -f origin/main &&

cd $HOME/chromium/src/third_party/devtools-frontend/src &&

git checkout -f origin/main &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git checkout -f origin/master &&

cd $HOME/chromium/src &&

git clean -ffd &&

rm -r -f -v $HOME/chromium/src/chrome/build/pgo_profiles/*.profdata &&

rm -r -f -v $HOME/chromium/src/out/chromium &&

git checkout -f origin/main &&

git clean -ffd &&

git rebase-update &&

git fetch --tags &&

# Install all sysroots (i.e. for ARM64)
build/linux/sysroot_scripts/install-sysroot.py --all &&

cd $HOME/chromium/src &&

gclient sync --with_branch_heads --with_tags -f -R -D &&

gclient runhooks &&

printf "${GRE}Done! ${YEL}You can now run ./setup.sh or ./VERSION.sh\n" &&
tput sgr0 &&

exit 0
