## Task 1: Your First Script

![hello.sh](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/hello.sh.png)

**What happens if you remove the shebang line?**

- The script still runs even without the shebang line, we can see that the script still executes successfully.
- When we try to run the script, the OS looks for the shebang line. Finding none, it refuses to run the file and passes the error to our terminal shell.
- The shell assumes the text file contains standard shell commands. It reads the file line-by-line and executes it inside current shell environment.
- The script worked because 'echo' is a valid command in almost every shell, so it just got executed.

---


## Task 2: Variables

### using single quotes vs double quotes 

- **Double Quotes (" ") Enable Variable Expansion:** The shell looks inside the quotes, finds the variables prefixed with $, and replaces them with their actual values.
   - echo "I am $ROLE" prints: I am DevOps Engineer

- **Single Quotes (' ') Disable Variable Expansion:** The shell treats everything inside literal text. It ignores the $ symbol completely.
    - echo 'I am $ROLE' prints: I am $ROLE

![variable.sh-1](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/variable.sh-1.png)
![variable.sh-2](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/variable.sh-2.png)

---

### Task 3: User Input with read
1. Create `greet.sh` that:
   - Asks the user for their name using `read`
   - Asks for their favourite tool
   - Prints: `Hello <name>, your favourite tool is <tool>`

![greet.sh](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/greet.sh.png)

---

### Task 4: If-Else Conditions
1. Create `check_number.sh` that:
   - Takes a number using `read`
   - Prints whether it is **positive**, **negative**, or **zero**

![check_number.sh-1](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/check_number.sh-1.png)
![check_number.sh-2](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/check_number.sh-2.png)

2. Create `file_check.sh` that:
   - Asks for a filename
   - Checks if the file **exists** using `-f`
   - Prints appropriate message

![file_check.sh-1](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/file_check.sh-1.png)
![file_check.sh-2](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/file_check.sh-2.png)

---

### Task 5: Combine It All
Create `service_check.sh` that:

1. Stores a service name in a variable (e.g., `nginx`, `sshd`)
2. Asks the user: "Do you want to check the status? (y/n)"
3. If `y` — runs `systemctl status <service>` and prints whether it's **active** or **not**
4. If `n` — prints "Skipped."

![service_check.sh](https://github.com/Alok-Nayak/90DaysOfDevOps/blob/4cb6211b0e453b4eb160f108acb80b7667664ce1/2026/day-16/day-16-snapshots/service_check.sh.png)  

---






