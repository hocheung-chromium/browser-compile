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
	printf "${bold}${GRE}Script to copy files over the Chromium source tree.${c0}\n" &&
	printf "${bold}${YEL}Use the --avx2 flag for AVX2 files.${c0}\n" &&
	printf "\n"
}
case $1 in
	--help) displayHelp; exit 0;;
esac

printf "\n" &&
printf "${YEL}Creating build output directory...\n" &&
tput sgr0 &&

mkdir -v -p $HOME/chromium/src/out/chromium/ &&
printf "\n" &&

printf "\n" &&
printf "${YEL}Copying files over the Chromium tree...\n" &&
tput sgr0 &&

# Copy files
cp -r -v src/. $HOME/chromium/src/ &&
cp -r -v AVX/. $HOME/chromium/src/ &&

# Copy AVX2 files
copyAVX2 () {
	printf "\n" &&
	printf "${YEL}Copying AVX2 files...${c0}\n" &&
    cp -r -v AVX2/. $HOME/chromium/src/ &&
	printf "\n"
}
case $1 in
	--avx2) copyAVX2;
esac

printf "${GRE}Done!\n" &&
printf "\n" &&
tput sgr0

exit 0
