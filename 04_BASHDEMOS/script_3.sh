#!/bin/bash

# Loop through all argument provided
while [ "$#" -gt 0 ]; do
    case "$1" in 
        -n)
            NAME="$2" # Store the value next to -n
            shift 2   #skip over '-n' and 'Alice'
            ;;
        -a)
            AGE="$2" # Store the value next to -a
            shift 2   #skip over '-a' and '25'
            ;;
        *)
            echo "Unknown flag: $1"
            exit 1
            ;;
    esac
done

# Print the result
echo "Hello, $NAME, you are $AGE years old."