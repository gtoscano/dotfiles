function fzf-history
    # Use `fzf` to select a history item
    set cmd (history | fzf --reverse --height=15%)
    # If a command was selected, insert it into the command line
    if test -n "$cmd"
        commandline --replace -- $cmd
    end
end

bind \cp 'fzf-history'
