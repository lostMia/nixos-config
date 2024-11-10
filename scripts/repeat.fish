#!/usr/bin/env fish

# Parse options with argparse
argparse 'n/numbers=' 'd/delay=' -- $argv
or begin
    # If parsing fails, print usage and exit
    echo "Usage: r [-n times] [-d delay_in_ms] program [arguments...]"
    exit 1
end

# Default values if the options aren't provided
set -l number_of_times -1  # Infinite by default
set -l delay_in_ms 1000    # Default delay is 1000 ms (1 second)

# If the flags were set, update the variables
if set -q _flag_numbers
    set number_of_times $_flag_numbers
end

if set -q _flag_delay
    set delay_in_ms $_flag_delay
end

# Remaining arguments after the options
set program_and_args $argv

# Ensure a program to run was provided
if test (count $program_and_args) -eq 0
    echo "Error: You must specify a program to run."
    echo "Usage: r [-n times] [-d delay_in_ms] program [arguments...]"
    exit 1
end

# Run the program with optional repeats and delay
set -l counter 0
while true
    # Run the command
    eval $program_and_args

    # Increment the counter if a number of repetitions was specified
    if test $number_of_times -gt 0
        set counter (math $counter + 1)
        if test $counter -ge $number_of_times
            break
        end
    end

    # Sleep for the specified delay (convert milliseconds to seconds for sleep)
    sleep (math $delay_in_ms / 1000.0)
end
