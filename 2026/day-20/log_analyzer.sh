#!/bin/bash

# Task 1: Input and Validation

LOG_FILE=$1
LOG_LABEL=${2:-"ERROR"}

if [ $# -eq 0 ]; then
        echo "Please provide the log file path as argument. e.g.: log_analyzer.sh  <path/to/log/file>"
        exit 1
elif [ ! -f "$LOG_FILE" ]; then
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

