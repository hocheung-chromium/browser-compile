# Copyright (c) 2024 yfqhhk.

# This file is used to sync commits in Chromium's Tip-of-tree branch.


import os
import shutil
import subprocess
import sys


# Error handling function
def fail(msg):
    # Print error message and exit
    print(f"{sys.argv[0]}: {msg}", file=sys.stderr)
    sys.exit(111)


def try_run(command):
    # Execute a command and die on failure
    try:
        subprocess.run(command, shell=True, check=True)
    except subprocess.CalledProcessError:
        fail(f"Failed {command}")


def clean_files(directory):
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
    if os.path.exists(directory):
        try:
            shutil.rmtree(directory)
            print(f"Removed directory: {directory}")
            return True
        except Exception as e:
            fail(f"Failed to remove directory {directory}: {e}")
    return False


# --help
def display_help():
    print(f"\nScript to Rebase/Sync Chromium repo to Tip of Tree.\n")


if '--help' in sys.argv:
    display_help()
    sys.exit(0)


# Set chromium/src dir from Windows environment variable
cr_src_dir = os.getenv('CR_DIR', r'C:/src/chromium/src')


def main():
    profiles_dir = os.path.normpath(os.path.join(cr_src_dir, "chrome", "build", "pgo_profiles"))
    out_dir = os.path.normpath(os.path.join(cr_src_dir, "out", "chromium"))

    # Check if any files or directories need to be deleted
    will_delete_files = any(os.path.isfile(os.path.join(profiles_dir, filename)) for filename in os.listdir(profiles_dir))
    will_delete_dir = os.path.exists(out_dir)

    # If any deletions are going to happen, print the cleanup message first
    if will_delete_files or will_delete_dir:
        print("\nCleaning up unneeded artifacts\n")

        # Now proceed with the deletions
        files_deleted = clean_files(profiles_dir)
        dir_deleted = delete_directory(out_dir)

        # Print final message after deletions are done
        if files_deleted or dir_deleted:
            print("\nDone cleaning unneeded artifacts\n")

    print("\nScript to Rebase/Sync Chromium repo to Tip of Tree.\n")
    print(
        f"Rebasing/Syncing to `origin/main` and running hooks in {cr_src_dir}\n"
    )

    # Change directory to cr_src_dir and run commands
    os.chdir(cr_src_dir)

    # Commands to run
    commands = [
        'cd v8 && git checkout -f origin/main',
        'cd third_party/ffmpeg && git checkout -f origin/master',
        'git checkout -f origin/main',
        'git clean -ffd',
        'git rebase-update',
        'git fetch --tags',
        'gclient sync --with_branch_heads --with_tags -f -R -D',
        'git clean -ffd',
        'gclient runhooks'
    ]

    # Run each command with error handling
    for cmd in commands:
        try_run(cmd)

    print("\nDone!\n")


if __name__ == "__main__":
    main()
