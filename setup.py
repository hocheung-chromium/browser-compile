import os
import shutil

def main():
    # Define source and destination directories
    src_dir = 'src'
    dest_dir = r'C:\src\chromium\src'  # Target directory

    print("\n")
    print("Copying files from src directory to Chromium source tree.")
    print("\n")

    try:
        # Iterate over items in source directory
        for item in os.listdir(src_dir):
            src_item = os.path.join(src_dir, item)
            dest_item = os.path.join(dest_dir, item)
            
            # Copy item to destination directory
            if os.path.isdir(src_item):
                shutil.copytree(src_item, dest_item, dirs_exist_ok=True)
            else:
                shutil.copy2(src_item, dest_item)  # Use shutil.copy2 to preserve metadata

        print("\n")
        print("Done!")
        print("\n")

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()
