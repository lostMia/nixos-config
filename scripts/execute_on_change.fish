#!/usr/bin/env fish

# Check if a file/directory is provided as the first argument
if test (count $argv) -lt 1
    echo "Usage: $argv[0] <file_or_directory_to_watch> <command_to_execute>"
    exit 1
end

# Get the file/directory to watch
set path_to_watch $argv[1]

# Get the command to execute (all parameters except the first)
set command_to_run (string join " " $argv[2..-1])

# Check if the specified file or directory exists
if not test -e $path_to_watch
    echo "Error: $path_to_watch does not exist."
    exit 1
end

# Use inotifywait to monitor the file/directory for changes
while true
    inotifywait -qq -e modify,create,delete,move $path_to_watch
    eval $command_to_run
end
