function load_secrets
    # Ensure the secrets file exists
    if not test -f ~/.config/secrets.env
        echo "Secrets file ~/.config/secrets.env does not exist."
        return 1
    end

    # Iterate over each line in the secrets file
    for line in (cat ~/.config/secrets.env)
        # Skip empty lines and lines starting with #
        if not string match -q -r '^(\s*)#' -- $line
            # Check if the line contains a key=value pattern
            if string match -q -r '^[^#\s]+=.+$' -- $line
                # Split the line into key and value
                set key (string split "=" $line)[1]
                set value (string join "=" (string split "=" $line)[2..-1])
                
                # Export the variable
                set -gx $key $value
            else
                echo "Warning: Invalid line format in secrets.env: $line"
            end
        end
    end
end

