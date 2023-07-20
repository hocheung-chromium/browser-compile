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
printf "${bold}${YEL}Copying files over the Chromium tree.${c0}\n" &&
tput sgr0 &&

# Copy files
cp -r -v build/linux/. $HOME/chromium/src/build &&
cp -r -v src/. $HOME/chromium/src/ &&
printf "\n" &&

printf "${bold}${GRE}Done!${c0}\n" &&
tput sgr0

exit 0
