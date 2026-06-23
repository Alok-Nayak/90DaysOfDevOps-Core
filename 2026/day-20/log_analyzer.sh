#!/bin/bash

# Task 1: Input and Validation

LOG_FILE=$1

if [ $# -eq 0 ]; then
	echo "Please provide the log file path as argument. e.g.: log_analyzer.sh  <path/to/log/file>"
elif
	[ ! -f "$LOG_FILE" ]; then
	echo "The $LOG_FILE file not exists.. Please ReCheck!!!"
fi

# Task 2: Error Count

for i in "ERROR" "Failed"
do
	echo "The Total '$i' count : $(grep -ic "$i"  "$LOG_FILE")"
done	

# Task 3: Critical Events


echo -e "---Critical Events---- \n$(grep -in "CRITICAL"  "$LOG_FILE")"


