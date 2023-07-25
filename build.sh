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
printf "${bold}${YEL}Building Chromium for Windows on Linux.${c0}\n" &&

# Build Chromium and installer

cd $HOME/chromium/src &&

export NINJA_SUMMARIZE_BUILD=1 &&

autoninja -C ~/chromium/src/out/chromium chrome chromedriver clear_key_cdm content_shell setup mini_installer -j$@ &&

printf "${bold}${GRE}Build Completed!${c0}\n" &&
tput sgr0 &&

exit 0
