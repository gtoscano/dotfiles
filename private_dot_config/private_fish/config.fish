# ~/.config/fish/config.fish
# Colors: conf.d/colors.fish (Dracula)   Prompt: starship (~/.config/starship.toml)

#
# Commonly Used Configurations
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

test -f ~/.fzf.fish; and source ~/.fzf.fish

if type -q zoxide
    zoxide init fish | source
    bind \cz 'set dir (zoxide query --interactive); and test -n "$dir"; and cd "$dir"'
end

source ~/.config/fish/env_vars.fish

load_secrets

starship init fish | source

