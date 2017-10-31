#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. please run as root"
    exit
fi

## Lists the repos and asks to confirm if they are correct
yum -v repolist




yum install ca-certificates curl nano nss openssl lynx

touch /etc/yum.repos.d/cisofy-lynis.repo

echo  
