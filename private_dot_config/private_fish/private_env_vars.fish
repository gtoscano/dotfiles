# General

set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# Set default editor
set -gx EDITOR nvim

# PATH
if test (uname -s) = "Linux"
    set -x DOCKER_GID 994
    if test -f /home/gtoscano/.local/bin/ghostty
        set -gx TERMINAL /home/gtoscano/.local/bin/ghostty
    end
    
    if test -d /home/gtoscano/.local/bin
        set -gx PATH /home/gtoscano/.local/bin $PATH
    end
    
    if test -d /opt/nvim-linux64/bin 
        set -gx PATH /opt/nvim-linux64/bin $PATH
    end
    if test -d /usr/lib/x86_64-linux-gnu/nvidia/current 
        set -gx LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/nvidia/current $LD_LIBRARY_PATH
    end
end

if test (uname -s) = "Darwin"
    set -gx PATH /System/Cryptexes/App/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin $PATH
    set -gx PATH /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin $PATH

    if test -d /Users/gtoscano/Downloads/google-cloud-sdk/bin 
        set -gx PATH /Users/gtoscano/Downloads/google-cloud-sdk/bin $PATH
    end
    if test -d /opt/homebrew/bin 
        set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
    end
    if test -d /Applications/Ghostty.app/Contents/MacOS 
        set -gx PATH /Applications/Ghostty.app/Contents/MacOS $PATH
    end
    if test -d /Applications/iTerm.app/Contents/Resources/utilities
        set -gx PATH /Applications/iTerm.app/Contents/Resources/utilities $PATH
    end
    if test -d /Library/TeX/texbin 
        set -gx PATH /Library/TeX/texbin $PATH
    end
end


# LD_LIBRARY_PATH
set -gx LD_LIBRARY_PATH /usr/local/lib $LD_LIBRARY_PATH


# LD_RUN_PATH
set -gx LD_RUN_PATH /usr/local/lib $LD_RUN_PATH


# Misc
set -x BITWARDEN_EMAIL gtoscano@gmail.com
set -x GITHUB_USERNAME gtoscano
set -x EDITOR nvim
