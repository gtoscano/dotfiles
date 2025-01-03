#!/bin/bash
# taken from https://github.com/logandonley/dotfiles/


install_on_debian() {
    echo "Installing Ansible on Debian-based system"
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
            ansible-playbook ~/.playbooks/install_essentials.yml -i ~/.playbooks/inventory.ini --ask-become-pass
            ansible-playbook ~/.playbooks/install_flatpaks.yml -i ~/.playbooks/inventory.ini --ask-become-pass --extra-vars "ansible_env.HOME=/home/gtoscano ansible_user=gtoscano"
            ansible-playbook ~/.playbooks/install_snaps.yml -i ~/.playbooks/inventory.ini  --ask-become-pass
            ansible-playbook ~/.playbooks/install_docker.yml -i ~/.playbooks/inventory.ini --ask-become-pass 
        else
            echo "Unsupported distribution"
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


echo "Ansible installation complete."
