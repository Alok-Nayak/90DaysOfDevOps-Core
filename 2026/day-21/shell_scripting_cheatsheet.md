# Shell Scripting Cheat Sheet: Build Your Own Reference Guide

### Task 1: Basics

1. Shebang (`#!/bin/bash`) — what it does and why it matters

- It tells the linux kernel which interpreter to use.

2. Running a script — `chmod +x`, `./script.sh`, `bash script.sh`

- `chmod +x` - Giving executable permission to a file/script.
- `./script.sh` - Executing a script via path with executable permission.
- `bash script.sh` - Executing a script without executaion permission(+x).
 
3. Comments — single line (`#`) and inline
- Used to document scripts. Single-line comments start with #.
- # This is a dedicated single-line comment
- echo "Hello World" # This is an inline comment

4. Variables — declaring, using, and quoting (`$VAR`, `"$VAR"`, `'$VAR'`)

- No spaces around the = sign during variable assignment. 
- Always double-quote variables when expanding to prevent word splitting and globbing.

```bash
NAME="Alok"   # Declare variable
echo $NAME        # Basic usage
echo "$NAME"      # Correct: Double quotes allow variable expansion
echo '$NAME'      # Literal: Single quotes prevent expansion (outputs: $NAME)
```
5. Reading user input — `read`

- `read -p "Hey what's your name?" NAME` (Input: Alok)
- Captures interactive keyboard entry from the user.
- echo $NAME (Output: Alok )

6. Command-line arguments — `$0`, `$1`, `$#`, `$@`, `$?`
- Positional parameters passed to the script at runtime.
- ```bash
echo "Script name: $0"
echo "First argument: $1"
echo "Total arguments count: $#"
echo "All arguments passed: $@"
echo "Exit status of last command: $?"

```
---

### Task 2: Operators and Conditionals

1. String comparisons — `=`, `!=`, `-z`, `-n`

- [ "$A" = "$B" ]   # True if A & B  strings are equal
- [ "$A" != "$B" ]  # True if strings are not equal
- [ -z "$A" ]       # True if string is empty/null
- [ -n "$A" ]       # True if string is not empty

2. Integer comparisons — `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`

- [ "$X" -eq "$Y" ] # X equal to Y
- [ "$X" -ne "$Y" ] # X not equal to Y
- [ "$X" -lt "$Y" ] # X less than Y
- [ "$X" -gt "$Y" ] # X greater than Y
- [ "$X" -le "$Y" ] # X less than or equal to Y
- [ "$X" -ge "$Y" ] # X greater than or equal to Y

3. File test operators — `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s`

- `[ -f "$FILE" ]`    # True if regular file exists
- `[ -d "$DIR"  ]`    # True if directory exists
- `[ -e "$PATH" ]`    # True if path exists (file, dir, link, etc.)
- `[ -r "$FILE" ]`    # True if readable
- `[ -w "$FILE" ]`    # True if writable
- `[ -x "$FILE" ]`    # True if executable
- `[ -s "$FILE" ]`    # True if file exists and has size greater than 0

4. `if`, `elif`, else` syntax

```bash

if [ "$A" -gt "$B" ]; then
        echo "$A is bigger.."
elif [ "$A" -lt "$B" ]; then
        echo "$A is smaller.."
else
        echo "Both are same"
fi

``` 


5. Logical operators — `&&`, `||`, `!`
6. Case statements — `case ... esac`

---
