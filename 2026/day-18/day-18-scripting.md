# Day 18 – Shell Scripting: Functions & intermediate Concepts

## Challenge Tasks

### Task 1: Basic Functions
1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script

**Answer**

```bash

#!/bin/bash

name=$1
greet(){
	
	echo "Heloo, $name!"
}


add(){
	read -p "'(+)'Enter the first number:  " n1
	read -p "'(+)'Enter the second number: " n2

	sum=$(( $n1 + $n2 ))

	echo "The sum of $n1 + $n2 = $sum"
}



greet 
add

```

---

### Task 2: Functions with Return Values
1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results

**Answer**

```bash

#!/bin/bash

check_disk(){
	df -h / | awk 'NR==2 {print $3}'
}


check_memory(){
 free -h | awk 'NR==2 {print $3}'
}


main(){

	echo "Used disk: $(check_disk)"
	echo "Used RAM: $(check_memory)"
}

```

### Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top
2. Try using an **undefined variable** — what happens with `set -u`?
3. Try a command that **fails** — what happens with `set -e`?
4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?

**Answer**

**Document:** What does each flag do?
- `set -e` → 
    -   Exit on Error. Tells Bash to immediately exit the script if any command returns a non-zero exit status (a failure).
- `set -u` →
    - No Unset Variables. Treats references to undefined variables as an error.
- `set -o pipefail` →
    - Pipeline Error Tracking. Changes the exit status of a pipeline to match the last command that returned a non-zero status. This ensures that if any command inside a pipe chain fails, the script catches it and halts, even if the final command succeeds.

**Script**

```bash

#!/bin/bash


set -euo pipefail

# TEST 1: The '-u' flag (Exits if a variable is undefined)
echo "Testing set -u..."

# UNCOMMENT THE LINE BELOW TO TEST:

#echo "My name is $UNDEFINED_VARIABLE"
echo "Tthe script didn't crash on the undefined variable."
echo "-------------------------------"

##################################################

# TEST 2: The '-e' flag (Exits immediately if a command fails)
# UNCOMMENT THE LINE BELOW TO TEST:

echo "Testing set -e..."
#ls /nonexistent/directory/path
echo "If you see this, the script didn't crash on the failed command."
echo "--------------------------------"

#################################################

# TEST 3: The '-o pipefail' flag (Exits if ANY command in a pipe fails)
# UNCOMMENT THE LINE BELOW TO TEST:

echo "Testing set -o pipefail..."
some_fake_command | echo "The pipe processed this text"
echo "If you see this, the script didn't crash on the broken pipeline."

```
---

### Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables

**Answer**

- Execution order dictates visibility.
```bash
#!/bin/bash

g_var="I Am Global Variable"

greet(){
        local l_var="I Am Local"
        f_var="Variable"
        echo "$l_var + $g_var"
}


echo "Before calling the greet function: $l_var+ $f_var + $g_var"
echo ""

greet

echo""
echo "After calling the greet function: $l_var + $f_var + $g_var"
```

**Answer**

```OUTPUT:
Before calling the greet function: +  + I Am Global Variable

I Am Local + I Am Global Variable

After calling the greet function:  + Variable + I Am Global Variable
```

---

### Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

**Answer**

```bash

#!/bin/bash

set -euo pipefail

show_host_os() {
    echo "Hostname: $(hostname)"
    echo "OS Version: $( grep -w "PRETTY_NAME" /etc/os-release | cut -d '"' -f2 )"
}

show_uptime(){
	echo "System uptime: $(uptime -p)"
}


show_disk() {
    echo "Root Disk Used Space: $(df -h | head -n 5)"
}

show_memory() {
    free -h | awk 'NR==1 || NR==2'
}

show_cpu_processes() {

    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}


main() {
    echo "========================================="
    echo "          SYSTEM INFO REPORT"
    echo "========================================="
    
    echo -e "\n*** HOSTNAME & OS INFO ***"
    show_host_os
    
    echo -e "\n *** SYSTEM UPTIME ***"
    show_uptime
    
    echo -e "\n***TOP 5 DISK USAGE ***"
    show_disk
    
    echo -e "\n*** MEMORY USAGE ***"
    show_memory
    
    echo -e "\n*** TOP 5 CPU CONSUMING PROCESSES ***"
    show_cpu_processes
    
    echo -e "\n=========END OF REPORT============="
}

main

```
---

## Key Take Away:

- Call the function first: Variables inside a function don’t exist in memory until that function actually runs.

- Use local to stop leaks: Variables inside a function automatically become global and spill out unless you explicitly add local before them.

- Strict mode blocks hidden errors: `set -euo pipefail` crashes the script immediately if a command fails or a variable is empty, preventing silent bugs.

---
