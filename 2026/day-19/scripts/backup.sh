#!/bin/bash

set -euo pipefail

<< readme

This script for backup with 5day rotation.
Useage: 
./backup.sh <source/dir/path/to/take/backup> <destination/dir/path/to/keep/backup>

readme

display_usage(){
	echo "Useage: ./backup.sh <source/dir/path/to/take/backup> <destination/dir/path/to/keep/backup> "
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
