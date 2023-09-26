#! /bin/bash
yum update -y
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'tmpfs /tmp tmpfs rw,nodev,nosuid,size=2G 0 0' >> /etc/fstab
echo 'devops123' | passwd --stdin root
dnf install java-11-amazon-corretto -y
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum -y install terraform
systemctl restart sshd
