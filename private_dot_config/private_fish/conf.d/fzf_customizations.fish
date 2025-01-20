# Preview functionality with fzf
function fzf_preview
    fzf --preview 'bat --style=numbers --color=always {} || cat {}'
end

# Ripgrep integration
function search
    rg --files | fzf
end

