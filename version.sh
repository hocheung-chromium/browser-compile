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

COMMIT_ID="48c9e8592a8f1712065a51e0f913ecc22594224f"

export COMMIT_ID &&

printf "\n"
printf "${bold}${RED}NOTE: ${bold}${YEL}Checking out${bold}${CYA} $COMMIT_ID ${bold}${YEL}in $HOME/chromium/src...${c0}\n"

cd $HOME/chromium/src &&

git checkout -f $COMMIT_ID &&

git clean -ffd &&

gclient sync --with_branch_heads --with_tags -f -R -D &&

gclient runhooks &&

printf "\n"
printf "${bold}${GRE}Chromium tree is checked out at: $COMMIT_ID${c0}\n"

printf "${YEL}Downloading PGO Profiles for Chromium.\n" &&
tput sgr0 &&

vpython3 tools/update_pgo_profiles.py --target=win64 update --gs-url-base=chromium-optimization-profiles/pgo_profiles &&

vpython3 v8/tools/builtins-pgo/download_profiles.py --depot-tools=$HOME/depot_tools download &&

printf "\n" &&

cd $HOME/chromium_compile &&

printf "${bold}${GRE}Done!${c0}" &&
printf "${bold}${YEL}You can now run ./setup.sh.${c0}\n" &&
tput sgr0 &&

exit 0
