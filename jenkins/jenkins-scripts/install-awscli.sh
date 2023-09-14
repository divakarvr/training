#! /bin/bash 


if [ `whoami` != 'root' ]; then
    echo "please run me with root user privileges or switch to root user and run me!"
    exit
fi

apt update -y
apt install awscli -y