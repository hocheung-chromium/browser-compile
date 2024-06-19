import os
import subprocess
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
BRANCH_NAME = "126.0.6478.61"
DEPOT_TOOLS_DIR = r'C:\src\depot_tools'

# Print note about checking out Chromium branch
print(f"NOTE: Checking out {BRANCH_NAME} in {CODE_DIR}...\n")

# Change directory to Chromium source directory
os.chdir(CODE_DIR)

# Checkout specific branch/tag, clean untracked files, sync dependencies
try_run(f"git checkout -f tags/{BRANCH_NAME}")
try_run("git clean -ffd")
try_run("gclient sync --with_branch_heads --with_tags -f -R -D")
try_run("gclient runhooks")

# Print message indicating successful checkout
print(f"Chromium tree is checked out at: {BRANCH_NAME}\n")

# Downloading PGO Profiles for Chromium
print("Downloading PGO Profiles for Chromium.\n")

# Running Python scripts to update PGO profiles
try_run(f"vpython3 tools/update_pgo_profiles.py --target=win64 update --gs-url-base=chromium-optimization-profiles/pgo_profiles")

# Downloading V8 builtins PGO profiles
try_run(f"vpython3 v8/tools/builtins-pgo/download_profiles.py --depot-tools={DEPOT_TOOLS_DIR} download --force")

# Print completion message
print("\n")

# Print final messages
print("Done!")
print("You can now run ./setup.sh.\n")
