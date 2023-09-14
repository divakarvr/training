#! /bin/bash 

# Run the script after becoming the root user

if [ `whoami` != 'root' ]; then
    echo "please run me with root user privileges or switch to root user and run me!"
    exit
fi
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update 
apt install openjdk-17-jre -y
sleep 1
apt-get install jenkins -y