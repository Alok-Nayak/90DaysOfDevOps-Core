#!/bin/bash

# Enable strict mode
set -euo pipefail

echo "--- Starting Strict Mode Demo ---"

# TEST 1: The '-u' flag (Exits if a variable is undefined)
echo "Testing set -u..."

# UNCOMMENT THE LINE BELOW TO TEST:

#echo "My name is $UNDEFINED_VARIABLE"
echo "Tthe script didn't crash on the undefined variable."
echo "-------------------------------"


# TEST 2: The '-e' flag (Exits immediately if a command fails)
# UNCOMMENT THE LINE BELOW TO TEST:

echo "Testing set -e..."
#ls /nonexistent/directory/path
echo "If you see this, the script didn't crash on the failed command."
echo "--------------------------------"


# TEST 3: The '-o pipefail' flag (Exits if ANY command in a pipe fails)
# UNCOMMENT THE LINE BELOW TO TEST:

echo "Testing set -o pipefail..."
some_fake_command | echo "The pipe processed this text"
echo "If you see this, the script didn't crash on the broken pipeline."
echo "--- Script Finished Successfully ---"
