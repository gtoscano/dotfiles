#!/usr/bin/env bash

set -Eeuo pipefail

# If you want debug logs, set DOTFILES_DEBUG=1 in your environment.

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

USER=$(whoami)  # Assign the current username to the USER variable

# Minimal "DotFiles" ASCII logo
declare -r DOTFILES_LOGO='
 ____        _   _____ _ _           
|  _ \  ___ | |_|  ___(_) | ___  ___ 
| | | |/ _ \| __| |_  | | |/ _ \/ __|
| |_| | (_) | |_|  _| | | |  __/\__ \
|____/ \___/ \__|_|   |_|_|\___||___/

*** DotFiles Setup Script ***
  https://github.com/gtoscano/dotfiles
  run: 
Inspired by:
 https://github.com/shunk031/dotfiles
'

declare -r DOTFILES_REPO_URL="https://github.com/gtoscano/dotfiles"
declare -r BRANCH_NAME="${BRANCH_NAME:-main}"

###############################################################################
# Helper Functions
###############################################################################

function get_os_type() {
    # 'Darwin' for macOS, 'Linux' for Linux
    uname
}

###############################################################################
# Package Installation (zsh, git, chezmoi)
###############################################################################

function install_packages_macos() {
    # 1. Install Homebrew if needed
    if ! command -v brew &>/dev/null; then
        echo "Homebrew not found. Installing Homebrew..."

        # Non-interactive Homebrew installation
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" <<EOF
# Bypass prompts; you may need to adjust these for newer brew installers.
\n
EOF

        # Set up Homebrew environment
        if [[ $(arch) == "arm64" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ $(arch) == "i386" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        else
            echo "Unsupported CPU architecture: $(arch)"
            exit 1
        fi
    else
        echo "Homebrew is already installed."
    fi

    # 2. Install zsh, git, chezmoi
    echo "Installing zsh, git, chezmoi via Homebrew (non-interactive)..."
    brew install zsh git
}

function install_packages_debian() {
    echo "Updating apt packages..."
    sudo apt-get update -y

    echo "Installing zsh, git, chezmoi via apt (non-interactive)..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y zsh git
}

function set_default_shell_to_zsh() {
    local zsh_path
    zsh_path="$(command -v zsh)"

    # Check if current shell is already zsh
    if [ "${SHELL}" != "${zsh_path}" ]; then
        echo "Setting default shell to zsh (non-interactive)..."
        # For non-interactive use, this requires passwordless sudo or being root.
        sudo chsh -s "${zsh_path}" "${USER}" || {
            echo "Failed to change shell to zsh. Please do it manually."
        }
    else
        echo "Default shell is already zsh."
    fi
}

###############################################################################
# OS Setup Functions
###############################################################################

function initialize_os_macos() {
    install_packages_macos
    set_default_shell_to_zsh
}

function initialize_os_linux() {
    install_packages_debian
    set_default_shell_to_zsh
}

function initialize_os_env() {
    local ostype
    ostype="$(get_os_type)"

    if [ "${ostype}" == "Darwin" ]; then
        initialize_os_macos
    elif [ "${ostype}" == "Linux" ]; then
        initialize_os_linux
    else
        echo "Unsupported OS type: ${ostype}" >&2
        exit 1
    fi
}

###############################################################################
# ChezMoi Setup
###############################################################################


function run_chezmoi() {
    # 1. Create the ./bin directory if it doesn’t exist
    mkdir -p ./bin

    # 2. Download and install the chezmoi binary into ./bin
    # The official install script accepts -- -b <DIR> to place the binary in a custom directory.
    echo "Downloading chezmoi into ./bin..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "./bin"

    # 3. Define where the chezmoi binary is located
    local chezmoi_cmd="./bin/chezmoi"

    # 4. Use non-interactive mode by default (no TTY prompts)
    local no_tty_option="--no-tty"

    echo "Initializing dotfiles with chezmoi (non-interactive)..."
    "${chezmoi_cmd}" init "${DOTFILES_REPO_URL}" \
        --force \
        --branch "${BRANCH_NAME}" \
        --use-builtin-git true 
        #\
        #${no_tty_option}

    echo "Removing any encrypted files (since we're non-interactive)..."
    find "$(${chezmoi_cmd} source-path)" -type f -name "encrypted_*" -exec rm -fv {} +

    echo "Applying dotfiles with chezmoi (non-interactive)..."
    "${chezmoi_cmd}" apply ${no_tty_option}

    # 5. (Optional) Remove the downloaded chezmoi binary if you want a self-cleaning setup
    # rm -fv "${chezmoi_cmd}"
}

###############################################################################
# Main
###############################################################################

function main() {
    echo "$DOTFILES_LOGO"

    # 1. Initialize environment (install packages)
    initialize_os_env

    # 2. Run chezmoi (no prompts, no TTY)
    run_chezmoi

    # If you want to automatically switch to zsh right away (in your current shell):
    # exec zsh
    # But note this only works if you run the script directly, not piped.
}

main
