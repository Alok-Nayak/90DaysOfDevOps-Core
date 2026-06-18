# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab


### Task 1: Log Rotation Script
Create `log_rotate.sh` that:
1. Takes a log directory as an argument (e.g., `/var/log/myapp`)
2. Compresses `.log` files older than 7 days using `gzip`
3. Deletes `.gz` files older than 30 days
4. Prints how many files were compressed and deleted
5. Exits with an error if the directory doesn't exist

**Answer**
```bash
#!/bin/bash

set -euo pipefail

echo ""
echo "*********** Starting Log Rotation ***********"

LOG_DIR=$1


if [ ! -d "$LOG_DIR" ]; then
	echo "Error: Directory '$LOG_DIR' does not exist."
	exit 1
fi
echo ""
echo "Success: Directory $LOG_DIR exists, Proceeding execution..."
echo ""
echo "     ----   ---   ---   ---   ---   ----    "
echo ""

files_to_compress=$(find $LOG_DIR -type f -name "*.log" -mtime +7 | wc -l)

if [ "$files_to_compress" -gt 0 ]; then
	echo "Found $files_to_compress files older than 7 days to compress..."
	find "$LOG_DIR" -type f -name "*.log" -mtime +7 -print0 | xargs -0 gzip -9
	echo "Successfully compressed $files_to_compress files."
else
    echo "No .log files older than 7 days found to compress."
fi

echo ""
echo "___________________________________________________________-"
echo ""

files_to_delete=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 | wc -l)

if [ "$files_to_delete" -gt 0 ]; then
    echo "Found $files_to_delete compressed files older than 30 days to purge..."
    find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print0 | xargs -0 rm -f
    echo ""
    echo "Successfully deleted $files_to_delete files."
else
    echo "No .gz files older than 30 days found to delete."
fi
echo ""
echo "**********************************************"

echo "    Log Rotation Completed Successfully!   "

echo "**********************************************"
echo ""

```

---

## Task 2: Server Backup Script
Create `backup.sh` that:
1. Takes a source directory and backup destination as arguments
2. Creates a timestamped `.tar.gz` archive (e.g., `backup-2026-02-08.tar.gz`)
3. Verifies the archive was created successfully
4. Prints archive name and size
5. Deletes backups older than 14 days from the destination
6. Handles errors — exit if source doesn't exist

**Answer**

```bash
#!/bin/bash

set -euo pipefail

<< readme

This script for backup with 5day rotation.
Useage: 
./log_rotate.sh < source path > < destination path >
readme

display_usage(){
	echo "Useage: ./log_rotate.sh <source path> <destination path> "
}

if [ $# -ne 2 ]; then
	display_usage
fi

keep_backup_for_days=14
source_dir=$1
backup_dir=$2

timestamp=$( date '+%Y-%m-%d-%H-%M-%S')

create_backup(){
	tar -czf "${backup_dir}/backup_${timestamp}.tar.gz" "$source_dir" > /dev/null
	if [ $? -eq 0 ]; then
                echo " Backup generated successfully for ${timestamp}"
		echo " Backup Size: $(du -sh "${backup_dir}/backup_${timestamp}.tar.gz" | awk '{print $1}')"
        else
                echo "Backup failed!"
                exit 1
        fi
}

perform_rotation(){
	backups=($(ls -t "${backup_dir}/backup_"*.tar.gz 2>/dev/null))

	#echo ${backups[@]}  #Printing the backups array
	if  [ "${#backups[@]}" -gt $keep_backup_for_days  ]; then
		echo "Performing rotation for 14 days..."

		backups_to_remove=("${backups[@]:$keep_backup_for_days}")

		for backup in "${backups_to_remove[@]}";
		do 
			rm -f ${backup}
		done
	fi
}

create_backup
perform_rotation

```
---


