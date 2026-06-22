#!/bin/bash

set -u

LOG_FILE="test_logs/logs/maintenance.log"

exec >> "$LOG_FILE" 2>&1

log_header() {
    echo "==================================================="
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "==================================================="
}

log_header "SYSTEM MAINTENANCE PIPELINE INITIATED"

SCRIPT_DIR="/home/alok-nayak/DevOps/workdir/shell-script"
TARGET_LOG_DIR="test_logs/logs"  # Input for log_rotate.sh
BACKUP_SRC="test_logs/logs"      # Input 1 for backup.sh
BACKUP_DEST="backup"            # Input 2 for backup.sh

#Log Rotation
echo ""
echo "[1/3] Starting Log Rotation..." > /dev/tty
echo "[Step 1/3] Triggering Log Rotation..."
"$SCRIPT_DIR/log_rotate.sh" "$TARGET_LOG_DIR"

LOG_ROTATE_STATUS=$?

if [ $LOG_ROTATE_STATUS -eq 0 ]; then
    echo "> Log rotation completed successfully."
else
    echo "> ERROR: Log rotation failed with exit code $LOG_ROTATE_STATUS"
fi
echo "[1/3] Log Rotation Complete..." > /dev/tty

#Execute System Backup
echo ""
echo "[2/3] Executing File Backup..." > /dev/tty
echo "[Step 2/3] Triggering System Backup..."
"$SCRIPT_DIR/backup.sh" "$BACKUP_SRC" "$BACKUP_DEST"
BACKUP_STATUS=$?

if [ $BACKUP_STATUS -eq 0 ]; then
    echo "> System backup completed successfully."
else
    echo "> ERROR: System backup failed with exit code $BACKUP_STATUS"
fi
echo "[2/3] File Backup Complete..." > /dev/tty
#Health Check
echo ""
echo "[3/3] Running System Health Check..." > /dev/tty
echo "[Step 3/3] Running Infrastructure Health Check..."
"$SCRIPT_DIR/healthcheck.sh"

HEALTH_STATUS=$?

echo ""
echo "[3/3] Health Check Complete..." > /dev/tty
# Final Pipeline Evaluation

if [ $LOG_ROTATE_STATUS -eq 0 ] && [ $BACKUP_STATUS -eq 0 ] && [ $HEALTH_STATUS -eq 0 ]; then
    log_header "MAINTENANCE PIPELINE COMPLETED SUCCESSFULLY"
else
    log_header " MAINTENANCE PIPELINE COMPLETED WITH ERRORS (CHECK ABOVE LOGS)"
fi

echo -e "\n\n" 
