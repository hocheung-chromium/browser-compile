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
	printf "${bold}${YEL}Script to check out Chromium tag of current Chromium version.${c0}\n" &&
	printf "\n"
	printf "${RED}NOTE: You may need to run ${c0}${bold}./trunk.sh ${RED}before using this script!${c0}\n" &&
	printf "\n"
}

case $1 in
	--help) displayHelp; exit 0;;
esac

COMMIT_ID="957b0a6fd69f875dcae42acf34a6b43eec682095"

export COMMIT_ID &&

printf "\n"
printf "${GRE}Current Chromium version is:${c0} ${underline}$COMMIT_ID${c0}\n"
printf "\n"
printf "${RED}NOTE: ${YEL}Checking out${CYA} $COMMIT_ID ${YEL}in $HOME/chromium/src...${c0}\n"
printf "\n"

cd $HOME/chromium/src &&

git checkout -f $COMMIT_ID &&

git clean -ffd &&

gclient sync --with_branch_heads --with_tags -f -R -D &&

gclient runhooks &&

# Install all sysroots (i.e. for ARM64)
build/linux/sysroot_scripts/install-sysroot.py --all &&

printf "\n"
printf "${GRE}Chromium tree is checked out at: ${c0}$COMMIT_ID\n"
printf "\n"

printf "${YEL}Downloading PGO Profiles for Windows ...\n" &&
printf "\n" &&
tput sgr0 &&

python3 tools/update_pgo_profiles.py --target=win64 update --gs-url-base=chromium-optimization-profiles/pgo_profiles &&

python3 v8/tools/builtins-pgo/download_profiles.py download &&

printf "\n" &&

cd $HOME/chromium-compile &&

printf "${GRE}Done! ${YEL}You can now run ./setup.sh\n"
tput sgr0 &&

exit 0
