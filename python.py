import shutil
import subprocess
import os

def copy_and_open_gvim(source_file):
    # Extract the directory path from the source file path
    destination_dir = os.path.dirname(source_file)

    # Copy the gzipped file to the destination directory
    shutil.copy(source_file, destination_dir)

    # Extract the filename from the source file path
    filename = os.path.basename(source_file)

    # Get the full path to the copied file
    copied_file = os.path.join(destination_dir, filename)

    # Open the copied gzipped file using gvim
    subprocess.run(["gvim", "-c", "e " + copied_file], check=True)

# Example usage:
source_file = "path/to/source/file.gz"
copy_and_open_gvim(source_file)
