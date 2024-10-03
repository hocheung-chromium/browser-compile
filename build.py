# Copyright (c) 2024 hocheung-chromium.
#
# This file is used to compile.

import os
import subprocess
import sys

# Error handling functions
def fail(msg):
    # Print error message and exit
    print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
    sys.exit(111)


def try_run(command):
    if subprocess.call(command, shell=True) != 0:
        fail(f"Failed {command}")


# Help function
def display_help():
    print("\nScript to build Chromium for Windows.\n")
    print("Usage: python build_win.py # (where # is number of jobs)")

if '--help' in sys.argv:
    display_help()
    sys.exit(0)


# Set chromium/src dir from Windows environment variable
cr_src_dir = os.getenv('CR_DIR', r'C:/src/chromium/src')

print("\nBuilding Chromium for Windows\n")

# Change directory and run build commands
os.chdir(cr_src_dir)
# Determine the number of threads to use
jobs = sys.argv[1] if len(sys.argv) > 1 else str(os.cpu_count())

try_run(f'autoninja -C out/chromium chrome setup mini_installer -j{jobs}')

print(f"Build Completed.")
