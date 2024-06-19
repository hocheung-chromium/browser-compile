import os
import subprocess
import shutil
import sys

# Error handling functions
def yell(msg):
    print(f"{os.path.basename(__file__)}: {msg}", file=sys.stderr)

def die(msg):
    yell(msg)
    sys.exit(111)

def try_run(command):
    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if result.returncode != 0:
        die(f"Failed {command}\n{result.stderr}")

CODE_DIR = r'C:\src\chromium\src'

# Sync and rebase the Chromium repository
try:
    print("\n")
    print("Rebase/Sync Chromium repo.")
    print()
    
    os.chdir(os.path.join(CODE_DIR, "v8"))
    try_run("git checkout -f origin/main")
    
    os.chdir(os.path.join(CODE_DIR, "third_party", "ffmpeg"))
    try_run("git checkout -f origin/master")
    
    os.chdir(CODE_DIR)
    # Delete *.profdata files under pgo_profiles directory
    profdata_path = os.path.join(CODE_DIR, "chrome", "build", "pgo_profiles")
    for file in os.listdir(profdata_path):
        if file.endswith(".profdata"):
            try_run(f"del /Q {os.path.join(profdata_path, file)}")
    
    # Clear out directory 'out'
    out_path = os.path.join(CODE_DIR, 'out')
    for item in os.listdir(out_path):
        item_path = os.path.join(out_path, item)
        if os.path.isdir(item_path):
            shutil.rmtree(item_path)
        else:
            os.remove(item_path)

    try_run("git clean -ffd")
    try_run("git checkout -f origin/main")
    try_run("git clean -ffd")
    try_run("git rebase-update")
    try_run("git fetch --tags")
    try_run("gclient sync --with_branch_heads --with_tags -f -R -D")
    try_run("gclient runhooks")
    
    print("Done!")
    print("You can now run ./version.sh.")
except subprocess.CalledProcessError as e:
    die(f"An error occurred during the Chromium repository sync/rebase process: {e}")

sys.exit(0)
