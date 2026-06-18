#!/bin/bash

set -euo pipefail

LOG_DIR="test_logs/logs"

mkdir -p "$LOG_DIR"

file_count=$(find "$LOG_DIR" -type f | wc -l)

if [ $file_count -eq 0 ]; then
	echo "Directory '$LOG_DIR' is empty or newly created. Populating with test logs..."

	for i in {0..40}; do
		DATE_STR=$(date -d "$i days ago" +"%Y-%m-%d")

		if [ $i -le 7 ]; then
			touch -d "$i days ago" "$LOG_DIR/app-${DATE_STR}.log" "$LOG_DIR/nginx-${DATE_STR}.log"
		elif [ $i -gt 7 ] && [ $i -le 30 ]; then
			touch -d "$i days ago" "$LOG_DIR/app-${DATE_STR}.log" "$LOG_DIR/nginx-${DATE_STR}.log"
			if (( i % 5 == 0 )); then
				touch -d "$i days ago" "$LOG_DIR/system-${DATE_STR}.log"
			fi
		else
			touch -d "$i days ago" "$LOG_DIR/app-${DATE_STR}.log" "$LOG_DIR/nginx-${DATE_STR}.log" "$LOG_DIR/db-backup-${DATE_STR}.log"

		fi
	done
	
	echo "Test environment successfully initialized."
else
    echo "Directory '$LOG_DIR' already contains $file_count files. Skipping log file generation."
fi
