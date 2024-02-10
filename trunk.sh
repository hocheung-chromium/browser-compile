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
printf "${bold}${GRE}Rebase/Sync Chromium repo.${c0}\n" &&
tput sgr0 &&

cd $HOME/chromium/src/v8/ &&

git checkout -f origin/main &&

cd $HOME/chromium/src/third_party/ffmpeg &&

git checkout -f origin/master &&

cd $HOME/chromium/src &&

rm -r -f -v $HOME/chromium/src/chrome/build/pgo_profiles/*.profdata &&

rm -r -f -v $HOME/chromium/src/out/chromium &&

git clean -ffd &&

git checkout -f origin/main &&

git clean -ffd &&

git rebase-update &&

git fetch --tags &&

cd $HOME/chromium/src &&

gclient sync --with_branch_heads --with_tags -f -R -D &&

gclient runhooks &&

printf "${bold}${GRE}Done!${c0}" &&
printf "${bold}${YEL}You can now run ./version.sh.${c0}\n" &&
tput sgr0 &&

exit 0
