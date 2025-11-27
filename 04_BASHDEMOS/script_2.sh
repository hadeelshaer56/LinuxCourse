#!/bin/bash

#get external param
PACKAGE=$1
echo "Checking package: $PACKAGE ..."

#Replace 'program_name' with the command you want to check 
PROGRAM="program_name"

# Use 'which' to check if the program exists
which $PROGRAM > /dev/null 2>&1


# Check the exit status
if [ $? -eq 0 ]; then
    echo "$PROGRAM is installed."
else
    echo "$PROGRAM is not installed."
    sudo apt update && sudo apt install -y "$PACKAGE"
fi