#!/bin/bash
# Usage
#
#     Desktop Example:
#     bash run_playbooks.sh desktop /path/to/local_inventory.ini
#     Example: bash run_playbooks.sh desktop net_inventory.yml
#
#     Server Example:
#     bash run_playbooks.sh server /path/to/net_inventory.yml
#
#     Apple Example:
#     bash run_playbooks.sh apple /path/to/apple_inventory.ini

# Define the usage function
usage() {
  echo "Usage: $0 [desktop|server|apple] [inventory_file_path]"
  exit 1
}

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  usage
fi

# Assign the first and second arguments
TARGET="$1"
INVENTORY_FILE="$2"

# Validate the first argument (desktop, server, apple)
if [[ "$TARGET" != "desktop" && "$TARGET" != "server" && "$TARGET" != "apple" ]]; then
  echo "Error: First argument must be one of [desktop, server, apple]."
  usage
fi

# Validate the second argument (inventory file path)
if [ ! -f "$INVENTORY_FILE" ]; then
  echo "Error: Inventory file '$INVENTORY_FILE' not found!"
  exit 1
fi

# Define the playbooks for each target
if [ "$TARGET" == "desktop" ]; then
  PLAYBOOKS=(
    "install_essentials.yml"
    "install_neovim.yml"
    "install_snaps.yml"
    "install_flatpaks.yml"
    "install_docker.yml"
    "install_cloudflared.yml"
    "install_ghostty.yml"
    "install_regolith_bookworm.yml"
    "install_starship.yml"
  )
elif [ "$TARGET" == "server" ]; then
  PLAYBOOKS=(
    "install_essentials.yml"
    "install_nvim.yml"
    "install_docker.yml"
    "install_cloudflared.yml"
    "install_starship.yml"
  )
elif [ "$TARGET" == "apple" ]; then
  PLAYBOOKS=(
    "install_essentials.yml"
    "install_nvim.yml"
    "install_docker.yml"
    "install_cloudflared.yml"
    "install_starship.yml"
  )
fi

# Directory containing the playbooks
PLAYBOOK_DIR="$HOME/.playbooks"

# Ensure the playbook directory exists
if [ ! -d "$PLAYBOOK_DIR" ]; then
  echo "Error: Playbook directory '$PLAYBOOK_DIR' not found!"
  exit 1
fi

# Execute each playbook
for PLAYBOOK in "${PLAYBOOKS[@]}"; do
  PLAYBOOK_PATH="$PLAYBOOK_DIR/$PLAYBOOK"

  # Check if the playbook exists
  if [ ! -f "$PLAYBOOK_PATH" ]; then
    echo "Warning: Playbook '$PLAYBOOK_PATH' not found. Skipping."
    continue
  fi

  # Run the playbook
  echo "Running playbook: $PLAYBOOK_PATH"
  ansible-playbook -i "$INVENTORY_FILE" "$PLAYBOOK_PATH"
  # --ask-become-pass

  # Check the exit status of the playbook
  if [ $? -ne 0 ]; then
    echo "Error: Playbook '$PLAYBOOK_PATH' failed!"
    exit 1
  fi
done

echo "All playbooks executed successfully for target '$TARGET' using inventory '$INVENTORY_FILE'!"
