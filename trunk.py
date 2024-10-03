# Copyright (c) 2024 hocheung-chromium.
#
# This file is used to sync commits in Chromium's Tip-of-tree branch.

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


def clean_files(directory):
    """Delete all files in the given directory."""
    deleted = False
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        if os.path.isfile(file_path):
            try:
                os.remove(file_path)
                deleted = True
                print(f"Removed: {file_path}")
            except Exception as e:
                fail(f"Failed to remove {file_path}: {e}")
    return deleted


def delete_directory(directory):
    """Delete the directory if it exists."""
    if os.path.exists(directory):
        try:
            shutil.rmtree(directory)
            print(f"Removed directory: {directory}")
            return True
        except Exception as e:
            fail(f"Failed to remove directory {directory}: {e}")
    return False


def display_help():
    """Display help message."""
    print("\nScript to Rebase/Sync Chromium repo to Tip of Tree.\n")


def main():
    cr_src_dir = os.getenv("CR_DIR", r"C:\src\chromium\src")
    profiles_dir = os.path.normpath(os.path.join(cr_src_dir, "chrome", "build", "pgo_profiles"))
    out_dir = os.path.normpath(os.path.join(cr_src_dir, "out", "chromium"))

    cleanup_needed = any([
        (os.path.isdir(profiles_dir) and
         any(os.path.isfile(os.path.join(profiles_dir, filename))
             for filename in os.listdir(profiles_dir))),
        os.path.exists(out_dir)
    ])

    if cleanup_needed:
        print("\nCleaning up unneeded artifacts\n")

        files_deleted = clean_files(profiles_dir) if os.path.isdir(profiles_dir) else False
        dir_deleted = delete_directory(out_dir) if os.path.exists(out_dir) else False

        if files_deleted or dir_deleted:
            print("\nDone cleaning unneeded artifacts\n")

    print("\nScript to Rebase/Sync Chromium repo to Tip of Tree.\n")
    print(f"Rebasing/Syncing to `origin/main` and running hooks in {cr_src_dir}\n")

    os.chdir(cr_src_dir)

    commands = [
        "cd v8 && git checkout -f origin/main",
        "cd third_party/ffmpeg && git checkout -f origin/master",
        "git checkout -f origin/main",
        "git clean -ffd",
        "git rebase-update",
        "git fetch --tags",
        "gclient sync --with_branch_heads --with_tags -f -R -D",
        "gclient runhooks"
    ]

    for cmd in commands:
        try_run(cmd)

    print("\nDone!\n")


if "--help" in sys.argv:
    display_help()
    sys.exit(0)

if __name__ == "__main__":
    main()
