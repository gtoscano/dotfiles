# General

# Set default editor
set -gx EDITOR nvim

# PATH
if test -f /home/gtoscano/.local/bin/ghostty
    set -gx TERMINAL /home/gtoscano/.local/bin/ghostty
end

if test -d /home/gtoscano/.local/bin
    set -gx PATH /home/gtoscano/.local/bin $PATH
end

if test -d /opt/nvim-linux64/bin 
    set -gx PATH /opt/nvim-linux64/bin $PATH
end

# LD_LIBRARY_PATH
set -gx LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/nvidia/current /usr/local/lib $LD_LIBRARY_PATH

# LD_RUN_PATH
set -gx LD_RUN_PATH /usr/local/lib $LD_RUN_PATH

# LANG & LC_ALL
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# 
set -x DOCKER_GID 994
set -x BITWARDEN_EMAIL gtoscano@gmail.com
set -x GITHUB_USERNAME gtoscano
set -x EDITOR nvim
