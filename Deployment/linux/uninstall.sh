#!/usr/bin/env bash
set -e

script_dir=$(realpath "$(dirname "$0")")

# Get settings
source "$script_dir/install.sh"

# Remove user
userdel -f "$INSTALL_USR"

# Remove dir
rm -rf "$INSTALL_DIR"

# Remove file
rm "$INSTALL_SRV"

echo "Completed"
