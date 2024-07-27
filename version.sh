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

# HOME dir env variable
if [ -z "${HOME_DIR}" ]; then 
    HOME_SRC_DIR="$HOME/browser-compile"
    export HOME_SRC_DIR
else 
    HOME_SRC_DIR="${HOME_DIR}"
    export HOME_SRC_DIR
fi

# DEPOT_TOOLS dir env variable
if [ -z "${TOOLS_DIR}" ]; then 
    TOOLS_SRC_DIR="$HOME/depot_tools"
    export TOOLS_SRC_DIR
else 
    TOOLS_SRC_DIR="${TOOLS_DIR}"
    export TOOLS_SRC_DIR
fi

# chromium/src dir env variable
if [ -z "${CR_DIR}" ]; then 
    CR_SRC_DIR="$HOME/chromium/src"
    export CR_SRC_DIR
else 
    CR_SRC_DIR="${CR_DIR}"
    export CR_SRC_DIR
fi

BRANCH_TAGS="128.0.6613.27"

export BRANCH_TAGS &&

printf "\n"
printf "${bold}${RED}NOTE: ${bold}${YEL}Checking out${bold}${CYA} $BRANCH_TAGS ${bold}${YEL}in $HOME/chromium/src...${c0}\n"

cd ${CR_SRC_DIR} &&

git checkout -f tags/$BRANCH_TAGS &&

git clean -ffd &&

# TODO: Investigate and fix errors on Msys2
gclient sync --with_branch_heads --with_tags -f -R -D &&

gclient runhooks &&

printf "\n"
printf "${bold}${GRE}Chromium tree is checked out at: $BRANCH_TAGS${c0}\n"

printf "${YEL}Downloading PGO Profiles for Chromium.\n" &&
tput sgr0 &&

python3 tools/update_pgo_profiles.py --target=win64 update --gs-url-base=chromium-optimization-profiles/pgo_profiles &&

python3 v8/tools/builtins-pgo/download_profiles.py --depot-tools=${TOOLS_SRC_DIR} download --force &&

printf "\n" &&

cd ${HOME_SRC_DIR} &&

printf "${bold}${GRE}Done!${c0}" &&
printf "${bold}${YEL}You can now run ./setup.sh.${c0}\n" &&
tput sgr0 &&

exit 0
