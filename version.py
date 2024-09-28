# Copyright (c) 2024 yfqhhk.
#
# This file is used to switch to a specific commit.

import os
import shutil
import subprocess
import sys


def fail(msg):
    """Print error message and exit."""
    print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
    sys.exit(111)


def try_run(command):
    """Execute a command and die on failure."""
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError:
        fail(f"Failed {command}")


def display_help():
    """Display help message."""
    help_text = (
        "\nScript to check out Chromium tag of specific commit.\n"
        "\nNOTE: You may need to run trunk.py before using this script\n"
    )
    print(help_text)


if '--help' in sys.argv:
    display_help()
    sys.exit(0)

# Set chromium/src dir from Windows environment variable.
cr_src_dir = os.getenv('CR_DIR', r'C:\src\chromium\src')

# Set bc_commit_id.
bc_commit_id = "68cad7a38228ce5bcc353e96bcd7292948470426"


print(f"\nCurrent Chromium version is: {bc_commit_id}\n")
print(f"\nNOTE: Checking out {bc_commit_id} in {cr_src_dir}\n")

# Change directory to cr_src_dir and run commands.
os.chdir(cr_src_dir)

try_run(f'git checkout -f {bc_commit_id}')

# Commands to run.
commands = [
    "git clean -ffd",
    "gclient sync --with_branch_heads --with_tags -f -R -D",
    "gclient runhooks",
    "git fetch https://chromium.googlesource.com/chromium/src refs/changes/52/5896652/2 && git cherry-pick FETCH_HEAD",
]

# Run each command with error handling.
for cmd in commands:
    try_run(cmd)

print(f"\nChromium tree is checked out at tag: {bc_commit_id}\n")

print("\nDownloading PGO Profiles for Windows\n")
try_run(
    'python3 tools/update_pgo_profiles.py --target=win64 '
    'update --gs-url-base=chromium-optimization-profiles/pgo_profiles'
)

print("\nDownloading PGO Profile for V8\n")
try_run(
    'python3 v8/tools/builtins-pgo/download_profiles.py '
    '--depot-tools=third_party/depot_tools --force download'
)

print("\nDone! You can now run setup.py\n")
