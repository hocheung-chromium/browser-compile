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

printf "${bold}${GRE}Script to copy files over the Chromium source tree.${c0}\n" &&
printf "${YEL}Creating build output directory...\n" &&
mkdir -v -p $HOME/chromium/src/out/chromium/ &&
printf "\n" &&
tput sgr0 &&

printf "${YEL}Copying files over the Chromium tree...\n" &&
tput sgr0 &&

# Copy files
cp -r -v src/. $HOME/chromium/src/ &&
cp -r -v AVX2/. $HOME/chromium/src/ &&
printf "\n" &&

printf "${GRE}Done!\n" &&
tput sgr0

exit 0
