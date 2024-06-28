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

# HOME dir env variable
if [ -z "${HOME_DIR}" ]; then 
    HOME_SRC_DIR="$HOME/browser-compile"
    export HOME_SRC_DIR
else 
    HOME_SRC_DIR="${HOME_DIR}"
    export HOME_SRC_DIR
fi

# chromium/src dir env variable
if [ -z "${CR_DIR}" ]; then 
    CR_SRC_DIR="$HOME/chromium/src"
    export CR_SRC_DIR
else 
    CR_SRC_DIR="${CR_DIR}"
    export CR_SRC_DIR
fi

printf "\n" &&
printf "${bold}${YEL}Copying files over the Chromium source tree.${c0}\n" &&
tput sgr0 &&

# Copy files
cp -r -v src/. ${CR_SRC_DIR} &&

printf "\n" &&

cd ${HOME_SRC_DIR} &&

printf "${bold}${GRE}Done!${c0}\n" &&
tput sgr0

exit 0
