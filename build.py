import os
import subprocess
import sys
import argparse

# Error handling
def yell(msg):
    sys.stderr.write(f"{sys.argv[0]}: {msg}\n")

def die(msg):
    yell(msg)
    sys.exit(111)

def try_run(command):
    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError:
        die(f"Failed {' '.join(command)}")

AUTONINJA_DIR = r'C:\src\depot_tools'
CODE_DIR = r'C:\src\chromium\src'

def main():

    # Argument parsing
    parser = argparse.ArgumentParser(description="Build Chromium for Windows.")
    parser.add_argument('-j', type=int, default=os.cpu_count(), help='Number of parallel jobs to run')
    args = parser.parse_args()

    # Print message
    print("\n")
    print("Building Chromium for Windows.")
    print("\n")

    # Change directory to Chromium source
    os.chdir(CODE_DIR)

    # Build Chromium and installer
    autoninja_path = os.path.join(AUTONINJA_DIR, "autoninja.bat")
    try_run([autoninja_path, "-C", os.path.join(CODE_DIR, "out", "chromium"), "chrome", "setup", "mini_installer", f"-j{args.j}"])

    # Print completion message
    print("\n")
    print("Build Completed!")
    print("\n")

if __name__ == "__main__":
    main()
