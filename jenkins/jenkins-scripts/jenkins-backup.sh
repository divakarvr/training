#!/bin/bash

JENKINS_HOME='/opt/jenkins'
BACKUP_PATH='/home/ec2-user/jenkins-backups'
time_stamp=$(date +%d-%m-%y-%m-%s)
backup_file_name="jenkins-backup-${time_stamp}.tar"

cd ~

if [ -d "${JENKINS_HOME}" ]; then
    echo "---> Jenkins home directory exists."
    cd /tmp/
    tar -cf ${backup_file_name} ${JENKINS_HOME}
    echo "---> Created the backup file ${backup_file_name}"
    if [ -d "${BACKUP_PATH}" ]; then
        echo "---> Backup directory exists."
        mv ${backup_file_name} ${BACKUP_PATH}/${backup_file_name}
    else
        echo "Directory does not exist."
        mkdir ${BACKUP_PATH}
        mv ${backup_file_name} ${BACKUP_PATH}/${backup_file_name}
    fi
else
    echo "---> Jenkins Home Directory does not exist."
    exit 1
fi