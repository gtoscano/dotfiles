function load_secrets
    # Ensure the secrets file exists
    if not test -f ~/.config/secrets.env
        echo "Secrets file ~/.config/secrets.env does not exist."
        return 1
    end

    # Iterate over each line in the secrets file
    set -l n 0
    for line in (cat ~/.config/secrets.env)
        set n (math $n + 1)
        # Skip empty lines and lines starting with #
        if string match -q -r '^\s*(#|$)' -- $line
            continue
        end
        # Check if the line contains a key=value pattern
        if string match -q -r '^[^#\s]+=.+$' -- $line
            # Split the line into key and value
            set -l key (string split "=" $line)[1]
            set -l value (string join "=" (string split "=" $line)[2..-1])
            # Strip one pair of surrounding quotes: KEY="value" or KEY='value'
            set value (string replace -r '^"(.*)"$' '$1' -- $value)
            set value (string replace -r "^'(.*)'\$" '$1' -- $value)

            # Export the variable
            set -gx $key $value
        else
            # Never echo the line itself: it may contain a secret
            echo "Warning: invalid line format in secrets.env (line $n)"
        end
    end
end
