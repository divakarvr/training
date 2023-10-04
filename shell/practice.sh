#!/bin/bash
cd ~
pwd
if [ -d "/var/lib/jenkins" ]; then
    echo "Directory exists."
    zip jenkins.zip /var/lib/jenkins
else
    echo "Directory does not exist."
    exit 1
fi

if [ -d "/home/ec2-user/jenkins-backup" ]; then
    echo "Directory exists."
else
    echo "Directory does not exist."
    mkdir /home/ec2-user/jenkins-backup
    mv ~/jenkins.zip /home/ec2-user/jenkins-backup
fi
