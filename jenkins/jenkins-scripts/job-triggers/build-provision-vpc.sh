#! /bin/bash

AK="AKIA4RGYXL5FDDLAZCHE"
SK="oAYT8Y9fMQVcHxp8qJmN7q0e6Cltzt3RbmyZmL0K"
RG="us-east-1"
TO=$1
UN="admin"
PASSWD="admin"

java -jar /Users/praveenvaranasi/Downloads/divakar/jenkins-cli.jar -auth 'admin:admin' -s http://54.146.222.203:8080 build provision-vpc -p "ACCESS_KEY_ID=${AK}" -p "SECRET_ACCESS_KEY=${SK}" -p "REGION=${RG}" -p "TF_OPERATION=${TO}"


#######################################
# Run the script like this
# bash build-provision-vpc.sh destroy
#######################################