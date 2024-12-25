#!/bin/bash

<< readme
This script takes backup of given directory
./backup.sh <path of directory> <path of backup directory>
readme

source_dir=$1

target_dir=$2

timestamp=$(date '+%y-%m-%d-%H-%M-%S')

backup_dir="${target_dir}/backup_${timestamp}"
function create_backup() {
zip -r "${backup_dir}.zip" "${source_dir}"



if [ $? -eq 0 ]; then
	echo "Backup created successfully"
else
	echo "Backup not created successfully $timestamp"
fi
}

function perform_rotation() {
    # List backups sorted by modification time (newest first)
    backups=($(ls -t "${target_dir}/backup_"*.zip 2>/dev/null))

    echo "Available backups: ${backups[@]}"
	echo "---------------------"
    if [ "${#backups[@]}" -gt 5 ]; then
        backups_to_remove=("${backups[@]:5}")
        echo "Backups to remove: ${backups_to_remove[@]}"
	 # Remove old backups
        for backup in "${backups_to_remove[@]}"; do
            echo "Removing $backup"
            rm -f "$backup"
        done
    fi
}


create_backup
perform_rotation
