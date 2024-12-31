#!/bin/bash
# taken from https://github.com/logandonley/dotfiles/


install_on_debian() {
    echo "Installing Ansible on Debian-based system"
    sudo apt-get update
    sudo apt-get install -y ansible
}

install_on_ubuntu() {
    echo "Installing Ansible on Ubuntu-based system"
    sudo apt-get update
    sudo apt-get install -y ansible
}

install_on_mac() {
    brew install ansible
}

OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if grep -q "Debian" /etc/os-release 2>/dev/null; then
            install_on_debian
        elif [ -f /etc/lsb-release ]; then
            install_on_ubuntu
        else
            echo "Unsupported Linux distribution"
            exit 1
        fi
        ;;
    Darwin*)
        install_on_mac
        ;;
    *)
        echo "Unsupported operating system: ${OS}"
        exit 1
        ;;
esac

ansible-playbook ~/.bootstrap/install_essentials.yml -i ~/.bootstrap/inventory.ini --ask-become-pass
ansible-playbook ~/.bootstrap/install_docker.yml -i ~/.bootstrap/inventory.ini --ask-become-pass 
ansible-playbook ~/.bootstrap/install_flatpaks.yml -i ~/.bootstrap/inventory.ini --ask-become-pass --extra-vars "ansible_env.HOME=/home/gtoscano ansible_user=gtoscano"
ansible-playbook ~/.bootstrap/install_snaps.yml -i ~/.bootstrap/inventory.ini  --ask-become-pass

echo "Ansible installation complete."
