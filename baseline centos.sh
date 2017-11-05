#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. please run as root"
    exit
fi

read a
if [[ $a == "Y" || $a == "Y" ]]; then
        echo "you entered Y Starting the Script"
        ## Lists the repos and asks to confirm if they are correct
        yum -v repolist


        yum install ca-certificates curl git nano nss openssl lynx -y

        touch /etc/yum.repos.d/cisofy-lynis.repo
        cp .cisofy-lynis.repo /etc/yum.repos.d/cisofy-lynis.repo
        yum makecache fast
        yum install lynis -y

        touch lynis.$host.$(date +%F_%R)
        lynis audit system > lynis.$host.$(date +%F_%R)



else
        echo "You Need to fix the Source List!"
	echo "Then try again"
fi
