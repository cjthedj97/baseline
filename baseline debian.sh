#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. please run as root"
    exit
fi

## Checks the /etc/apt/sources.list and ask if it is correct
echo "Please verify that the source list is correct"
cat /etc/apt/sources.list
echo "is this correct"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
        echo "you entered Y"
	
	apt install curl git nano lynx
else
        echo "You entered N or an incorrct response"
fi
