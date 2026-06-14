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
