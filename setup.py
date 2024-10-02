# Copyright (c) 2024 yfqhhk.
#
# This file is used to copy modified files.

import os
import shutil
import subprocess
import sys

def fail(msg):
    """Print error message and exit."""
    print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
    sys.exit(111)

def try_run(command):
    """Execute a command and exit on failure."""
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError:
        fail(f"Failed {command}")

def copy_directory(source_dir, destination_dir):
    """Copy a directory from source to destination."""
    if not os.path.exists(destination_dir):
        os.makedirs(destination_dir)
        print(f"Created directory {destination_dir}")

    for item in os.listdir(source_dir):
        source_path = os.path.join(source_dir, item)
        dest_path = os.path.join(destination_dir, item)

        if os.path.isdir(source_path):
            print(f"Copying directory {source_path} to {dest_path}")
            shutil.copytree(source_path, dest_path, dirs_exist_ok=True)
        else:
            shutil.copy(source_path, dest_path)

def display_help():
    """Display help information."""
    print("\nScript to copy modified files over the Chromium source tree\n")
    print("\nThis should be done AFTER running this setup.py")

if '--help' in sys.argv:
    display_help()
    sys.exit(0)

# Set chromium/src dir from Windows environment variable.
cr_src_dir = os.getenv('CR_DIR', r'C:/src/chromium/src')
# Set browser-compile dir from Windows environment variable.
bc_src_dir = os.path.expandvars(os.getenv('BC_DIR', '%USERPROFILE%/browser-compile'))

print("\nCopying modified files over the Chromium tree\n")

copy_directory(
    os.path.normpath(os.path.join(bc_src_dir, 'src/')),
    os.path.normpath(cr_src_dir)
)

print("\nDone!\n")
