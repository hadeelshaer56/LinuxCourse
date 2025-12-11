#!/bin/bash

# CHECK IF PARAMETER IS SENT  
if [[ $# -ne 4 ]]; then
    echo "Error: Exactly 4 parameters are required."
    exit 1
fi
