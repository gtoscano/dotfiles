# General
# abbr v "nvim $(fzf)"
abbr l "ls -lAhF"
abbr la "ls -laF"

# Directory Navigation
abbr dc "cd"
abbr .. "cd .."
abbr cd.. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr ..... "cd ../../../.."
abbr cdc "cd ~ && clear"

# SSH Shortcuts
#alias tunnel="ssh -L 8123:localhost:8123 148.247.201.78 -N"

# Job Control
abbr pu "pushd"
abbr po "popd"
abbr j "jobs"
abbr d "dirs -v"


# Miscellaneous
#alias mc="mc -bs"
#alias man="PAGER=less man -a"
#alias wcat="wget -q -O -"

if test (uname -s) = "Linux"
    abbr open "xdg-open &>/dev/null"
    abbr sapt "sudo nala"
end

if test (uname -s) = "Darwin"
end

# Git
abbr gst "git status"
abbr gd "git diff"


# DotFiles

abbr config "/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
