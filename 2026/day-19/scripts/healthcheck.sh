#!/bin/bash

set -euo pipefail

MAX_DISK=80
MAX_MEM=80
MAX_CPU=85

echo "-----------------------------"
echo "--    HEALTH CHECK STATUS  --"
echo "-----------------------------"

CURRENT_DISK_USED=$(df -h / | awk 'NR==2 {print $5}' | tr -d "%")

if [ "$CURRENT_DISK_USED" -gt "$MAX_DISK" ]; then
	echo "WARNING: Disk utilization is critical at ${CURRENT_DISK_USED}%!"
else
    echo "Storage Health: OK (${CURRENT_DISK_USED}% used)"
fi

CURRENT_MEM_USED=$(free -m | awk 'NR==2 {print int(($3 / $2) * 100)}')

if [ "$CURRENT_MEM_USED" -gt "$MAX_MEM" ]; then
	echo "WARNING: (RAM)Memory utilization is critical at ${CURRENT_MEM_USED}%!"
else
    echo "Memory Health: OK (${CURRENT_MEM_USED}% used)"
fi

CORES=$(nproc)

CURRENT_CPU_USED=$(uptime | tr -d ',' | awk -v c="$CORES" '{print int(($11 / c) * 100)}')

if [ "$CURRENT_CPU_USED" -gt "$MAX_CPU" ]; then
    echo "WARNING: CPU utilization is critical at ${CURRENT_CPU_USED}%!"
else
    echo "Compute Health: OK (${CURRENT_CPU_USED}% used)"
fi

echo ""
