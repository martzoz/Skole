#!/bin/bash

# Read password without echoing
read -s -p "Enter password to test strength: " password
echo ""

# Check if the password is at minimum 12 characters long
if [ ${#password} -lt 12 ]; then
    >&2 echo "Error: Password must be at least 12 characters long"
    exit 1
fi

# Variables to calculate the entropy of the password
L=${#password}  # Gets the length of the password
N=0  # Number of the possible symbols, this gets changed later in the code

# Checking what sets of characters are used in the password
if [[ "$password" =~ [a-z] ]]; then
    N=$((N + 26))
fi

if [[ "$password" =~ [A-Z] ]]; then
    N=$((N + 26))
fi

if [[ "$password" =~ [0-9] ]]; then
    N=$((N + 10))
fi

# Check for special characters by checking everything that is NOT an alphanumeric character
if [[ "$password" =~ [^a-zA-Z0-9] ]]; then
    N=$((N + 32))
fi

# Calculate the entropy with the formula from the assignment: E = L * log(N) / log(2)
# Using bc -l so bash can calculate with floats
entropy=$(echo "scale=2; $L * l($N) / l(2)" | bc -l)

# Checking if the password entropy is below 80 bits
if (( $(echo "$entropy < 80" | bc -l) )); then
    >&2 echo "Warning: Password entropy is less than $entropy bits"
fi

# Checking if the password exists in the rockyou.txt file
if grep -Fxq "$password" rockyou.txt 2>/dev/null; then
    >&2 echo "Error: Password found in rockyou.txt breach database"
    exit 2
fi

# Success - this will only print to stdout if entropy is good
if (( $(echo "$entropy >= 80" | bc -l) )); then
    echo "Password strength: $entropy bits of entropy"
fi
exit 0
