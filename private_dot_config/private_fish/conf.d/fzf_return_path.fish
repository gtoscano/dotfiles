function __fzf_return_path
    # Trigger fzf to select a file
    # for simple search
    # set selected_file (fzf | string trim)
    # for using a preview with bat
    # set selected_file (fzf --preview 'bat --style=numbers --color=always --line-range :100 {}' | string trim)
    # for using a preview with bat and xxd for binary files
    set selected_file (fzf --preview '
    if file --mime {} | grep -q binary; 
    then 
        echo "Binary file detected. Previewing as hexdump:"; 
        xxd {}; 
    else 
        (bat --style=numbers --color=always --line-range :100 {} || cat {}); 
    fi' | string trim)



    # If a file is selected, insert its path into the command line
    if test -n "$selected_file"
        # Remove any trailing/leading whitespace or newlines
        set selected_file (string join "" $selected_file)
        # Append the trimmed path to the current command
        commandline -r (commandline --current-buffer)" "$selected_file
    end
end

# Bind Ctrl-F to trigger the function
bind \cf '__fzf_return_path'
