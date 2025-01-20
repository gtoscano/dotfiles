
# ~/.config/fish/config.fish

#
# 1. Dracula Color Scheme for Fish
#    Reference Dracula palette:
#    Background:  #282a36
#    Foreground:  #f8f8f2
#    Comment:     #6272a4
#    Cyan:        #8be9fd
#    Green:       #50fa7b
#    Orange:      #ffb86c
#    Pink:        #ff79c6
#    Purple:      #bd93f9
#    Red:         #ff5555
#    Yellow:      #f1fa8c
#

# Normal text
set -g fish_color_normal        f8f8f2

# Command color (purple)
set -g fish_color_command       bd93f9

# Parameters (yellow-ish)
set -g fish_color_param         f1fa8c

# Quotes (green)
set -g fish_color_quote         50fa7b

# Redirection (pink)
set -g fish_color_redirection   ff79c6

# End-of-command marker (pink)
set -g fish_color_end           ff79c6

# Errors (red)
set -g fish_color_error         ff5555

# Comments (comment color)
set -g fish_color_comment       6272a4

# Selection (reverse or something subtle)
set -g fish_color_selection     --background=44475a

# Search matches
set -g fish_color_search_match  --background=ff79c6

# Autosuggestions (gray-ish)
set -g fish_color_autosuggestion  6272a4

# (Optional) If you want user, host, and CWD to appear with certain colors:
set -g fish_color_user           8be9fd
set -g fish_color_host           ffb86c
set -g fish_color_cwd            50fa7b

#
# 2. Astronaut Prompt
#    A simple custom prompt with a space icon, rocket, and user@host + cwd.
#    You can customize colors, icons, or layout as you like.
#
function fish_prompt --description 'Astronaut Prompt'
    # Use user color for the username
    set_color $fish_color_user
    echo -n (whoami)

    # Separator
    set_color normal
    echo -n "@"

    # Use host color for short hostname
    set_color $fish_color_host
    echo -n (hostname | cut -d '.' -f 1)

    # Separator + current directory
    set_color normal
    echo -n " "
    set_color $fish_color_cwd
    echo -n (prompt_pwd)

    # Astronaut / rocket icon
    set_color normal
    echo -n " "
    set_color $fish_color_command
    echo -n "🚀 "
    set_color normal
end

#
# 3. Commonly Used Configurations
#

# Disable the default fish greeting
set -g fish_greeting ""


# (Optional) If using a plugin manager like fisher, load it here:
#   if test -f (which fisher)
#       fisher update
#   end

# (Optional) Sourcing additional scripts or local configs
#   if test -f ~/.config/fish/local.fish
#       source ~/.config/fish/local.fish
#   end

if status is-interactive
    # Commands to run in interactive sessions can go here

end

[ -f ~/.fzf.fish ]; and source ~/.fzf.fish

if type -q zoxide
    zoxide init fish | source
    bind \cz 'set dir (zoxide query --interactive); and test -n "$dir"; and cd "$dir"'
end

source ~/.config/fish/env_vars.fish

load_secrets

starship init fish | source

