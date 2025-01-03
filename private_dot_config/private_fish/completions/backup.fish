# Tab completions for the 'backup' command

# Add --help and --version options
complete -c backup -l help -d "Show help for the backup command"
complete -c backup -l version -d "Show the version of the backup tool"

# Add a --type option that accepts 'full' or 'incremental'
complete -c backup -l type -a "full incremental" -d "Specify the type of backup"

# Add a --destination option that dynamically lists directories
complete -c backup -l destination -a "(ls -d */)" -d "Specify the backup destination (directories only)"

# Add a --device option that dynamically lists available drives
complete -c backup -l device -a "(lsblk -ln | awk '{print $1}' | xargs -I{} echo /dev/{})" -d "Specify the device for the backup"

# Add positional arguments: operations like 'start', 'stop', 'status'
complete -c backup -a "start stop status" -d "Specify the backup operation to perform"
