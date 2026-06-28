# Bash Scripting Challenge: Log Analyzer and Report Generator
## Script Code

```bash
#!/bin/bash

set -euo pipefail

date=$(date +%Y-%m-%d)

# Task 1: Input and Validation
if [ $# -eq 0 ]; then
        echo "Please provide the log file path as argument. e.g.: log_analyzer.sh  <path/to/log/file>"
        exit 1
fi

LOG_FILE=$1
LOG_LABEL=${2:-ERROR}

if [ ! -f "$LOG_FILE" ]; then
        echo "The '$LOG_FILE' file does not exist.. Please ReCheck!!!"
        exit 1
fi

# Task 2: Error Count
for i in "ERROR" "Failed"
do
        echo "The Total '$i' count : $(grep -ic "$i" "$LOG_FILE")"
done

# Task 3: Critical Events
echo ""
echo -e "---Top 5 Critical Events---- \n$(grep -in "CRITICAL" "$LOG_FILE" | head -5 )"
echo ""

# Task 4: Top Error Messages
echo "--- Top 5 $LOG_LABEL Messages ---"
grep "\[$LOG_LABEL\]" "$LOG_FILE" | cut -d']' -f2 | cut -d'-' -f1 | sort | uniq -c | sort -rn | head -5
echo " "

# Task 5: Summary Report

REPORT_FILE="log_report_${date}.txt"
REPORT_DIR="reports"

if [ -d "$REPORT_DIR" ]; then
	echo ""
	echo " The $REPORT_DIR directory exists."
else
	echo " The '$REPORT_DIR' directory does not exist."
	mkdir -p "$REPORT_DIR"
	echo " The '$REPORT_DIR' dir created successfully."
	echo ""
fi

echo "Generating report: $REPORT_FILE..."

echo "" > "$REPORT_DIR/$REPORT_FILE"
echo "--- Log Analysis Summary Report ---" >> "$REPORT_DIR/$REPORT_FILE"
echo "" >>"$REPORT_DIR/$REPORT_FILE"
echo "Date of analysis: $date" >> "$REPORT_DIR/$REPORT_FILE"
echo "Log file name: $LOG_FILE" >> "$REPORT_DIR/$REPORT_FILE"
echo "Total lines processed: $(wc -l < "$LOG_FILE")" >> "$REPORT_DIR/$REPORT_FILE"

echo "Total error count: $(grep -ic "ERROR" "$LOG_FILE")" >> "$REPORT_DIR/$REPORT_FILE"
echo "" >> "$REPORT_DIR/$REPORT_FILE"

echo "--- Top 5 $LOG_LABEL Messages ---" >> "$REPORT_DIR/$REPORT_FILE"
echo "" >> "$REPORT_DIR/$REPORT_FILE"
grep "\[$LOG_LABEL\]" "$LOG_FILE" | cut -d']' -f2 | cut -d'-' -f1 | sort | uniq -c | sort -rn | head -5 >> "$REPORT_DIR/$REPORT_FILE"
echo "" >> "$REPORT_DIR/$REPORT_FILE"

echo "--- Critical Events with Line Numbers ---" >> "$REPORT_DIR/$REPORT_FILE"
echo "" >> "$REPORT_DIR/$REPORT_FILE"
grep -in "CRITICAL" "$LOG_FILE" | tail -15 >> "$REPORT_DIR/$REPORT_FILE"
echo "" >> "$REPORT_DIR/$REPORT_FILE"

echo "Report saved successfully!"



# Task 6: Archive Processed Logs
 
ARCHIVE_DIR="archive"

if [ -d "$ARCHIVE_DIR" ]; then
	echo ""
	echo "The $ARCHIVE_DIR directory exists."
else
	echo " '$ARCHIVE_DIR' directory does not exist."
	mkdir -p "$ARCHIVE_DIR"
	echo " The '$ARCHIVE_DIR' dir created successfully."
fi


if mv "$LOG_FILE" "$ARCHIVE_DIR"; then
	echo "Success: '$LOG_FILE' has been moved to '$ARCHIVE_DIR'"
else
	echo "Error: Failed to move log file to archive directory."
fi

```

## Sample output from running against the sample log

```bash

--- Log Analysis Summary Report ---

Date of analysis: 2026-06-26
Log file name: log_dir/linux.log
Total lines processed: 300
Total error count: 62

--- Top 5 ERROR Messages ---

     17  Segmentation fault 
     17  Disk full 
     12  Failed to connect 
      8  Out of memory 
      8  Invalid input 

--- Critical Events with Line Numbers ---

265:2026-06-23 11:22:18 [CRITICAL]  - 14626
266:2026-06-23 11:22:18 [CRITICAL]  - 6175
267:2026-06-23 11:22:18 [CRITICAL]  - 17267
269:2026-06-23 11:22:18 [CRITICAL]  - 2653
270:2026-06-23 11:22:18 [CRITICAL]  - 32028
273:2026-06-23 11:22:18 [CRITICAL]  - 21671
278:2026-06-23 11:22:18 [CRITICAL]  - 32445
279:2026-06-23 11:22:18 [CRITICAL]  - 726
286:2026-06-23 11:22:18 [CRITICAL]  - 4962
287:2026-06-23 11:22:18 [CRITICAL]  - 11277
289:2026-06-23 11:22:18 [CRITICAL]  - 25697
292:2026-06-23 11:22:18 [CRITICAL]  - 30876
295:2026-06-23 11:22:18 [CRITICAL]  - 16699
298:2026-06-23 11:22:18 [CRITICAL]  - 12996
299:2026-06-23 11:22:18 [CRITICAL]  - 26443

```
## commands/tools you use

- `grep -ic` : Counts exactly how many times a word appears in the file, ignoring uppercase or lowercase differences.
- `grep -in` : Finds lines matching a target word and prefixes each line with its exact line number.
- `wc -l <` : Counts total lines in the file. Using < prints only the count number without the filename attached.
- `cut -d']' -f2` : Splits lines at the ] bracket and shows only the second part (everything after the bracket).
- `cut -d'-' -f1` : Cuts text at the first - hyphen and keeps only the first part, removing everything after it.
- `sort` : Rearranges lines alphabetically so identical messages are grouped right next to each other.
- `uniq -c` : Merges duplicate lines together and prefixes them with a count of how many times they repeated.
- `sort -rn` : Sorts lines numerically in reverse order so the highest count appears at the very top.
- `head -5` : Selects and prints only the first 5 lines from the top of the output stream.
- `tail -15` : Selects and prints only the last 15 lines from the bottom of the output stream.

## What I Learned

- 1. Variable placement matters with strict mode: When using set -u, you cannot test a variable or check if a file exists before you actually define it. You must check argument counts first, assign the variable, and only then test it.

- 2. File overriding vs appending: Using a single > clears out the file and writes a fresh line from scratch, while using >> appends new text cleanly at the bottom without deleting what was already there.

- 3. Piping utilities to filter data: I learned that connecting simple tools using pipes (|) lets you clean up complex text step-by-step—first searching, then cutting, sorting, counting, and finally limiting the output.



