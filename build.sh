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
	printf "${bold}${GRE}Script to build Chromium for Windows on Linux.${c0}\n" &&
	printf "${underline}${YEL}Usage: ${c0}build.sh # (where # is number of jobs)${c0}\n" &&
	printf "\n"
}
case $1 in
	--help) displayHelp; exit 0;;
esac

printf "\n" &&
printf "${YEL}Building Chromium for Windows...\n" &&
printf "${GRE}\n" &&

# Build Chromium and mini_installer

cd $HOME/chromium/src &&

export NINJA_SUMMARIZE_BUILD=1 &&

autoninja -C ~/chromium/src/out/chromium chrome setup mini_installer -j$@ &&

printf "${GRE}${bold}Build Completed!\n" &&
tput sgr0 &&

exit 0
