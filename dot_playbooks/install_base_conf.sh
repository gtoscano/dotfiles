#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Please run it with sudo or as root."
  exit 1
fi

# Install necessary packages
apt update
apt install -y sudo python3 openssh-server

# Prompt for username
read -p "Enter the username that will be used to install the base configuration: " username

# Ensure the user exists
if id "$username" &>/dev/null; then
  echo "User $username exists, proceeding with configuration..."
else
  echo "User $username does not exist. Please create the user first."
  exit 1
fi

# Grant sudo privileges without password
sudoers_file="/etc/sudoers.d/99-$username"
echo "$username ALL=(ALL) NOPASSWD: ALL" >"$sudoers_file"
chmod 0440 "$sudoers_file"

# Add user to sudo group
usermod -aG sudo "$username"

echo -e "\nConfiguration completed successfully!"

# Display SSH access instructions
echo -e "\nTo securely access this machine, follow these steps:\n"
echo "1. Generate SSH keys on your client machine if you don't have one:"
echo "   a) ssh-keygen -t rsa -b 4096 -C \"your_email@example.com\""
echo "      Alternative: ssh-keygen -t ed25519 -C \"your_email@example.com\""
echo "   b) A key pair will be generated:"
echo "      - Private key: ~/.ssh/id_rsa"
echo "      - Public key:  ~/.ssh/id_rsa.pub"
echo
echo "2. Identify the IP of this this machine:"
echo "   The IP addresses of this server are:"
hostname -I | tr ' ' '\n'
echo
echo "3. Copy the Public Key to this machine:"
echo "   ssh-copy-id -i  ~/.ssh/id_rsa $username@<REMOTE_HOST_IP_OR_HOSTNAME>"
echo
echo "4. Test SSH access:"
echo "   ssh -i  ~/.ssh/id_rsa $username@<REMOTE_HOST_IP_OR_HOSTNAME>"
echo "Done! You should now be able to SSH into this machine securely."
