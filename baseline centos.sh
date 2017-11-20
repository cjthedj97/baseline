#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root"
    exit
fi

# Creating the needed Directories
mkdir ~/baseline

# Lists the repos and asks to confirm if they are correct
yum -v repolist | more
echo "Is this correct?"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
	echo "Starting the Script"
  yum update -y

	# Installing The Required Software
  echo "Installing the required Software"
  yum install ca-certificates curl git nano nss openssl lynx python tmux yum-utils -y

  # Downloads and Runs IR (Incidance Response) program
  echo "Installing IR program"
  git clone https://github.com/SekoiaLab/Fastir_Collector_Linux
  cd Fastir_Collector_Linux
  python fastIR_collector_linux.py

	# Setting up and Installing Lynis
  touch /etc/yum.repos.d/cisofy-lynis.repo
  cp .cisofy-lynis.repo /etc/yum.repos.d/cisofy-lynis.repo
  yum makecache fast
  yum install lynis -y
  touch lynis.$HOSTNAME.$(date +%F_%R)
  lynis audit system > ~/baseline/lynis/$HOSTNAME.$(date +%F_%R)

  # Updating the system
  echo "Updating"
  yum update -y

  needs-restarting -r
  sleep 5
  exit
else
  echo "You Need to fix the Source List!"
	echo "Please try again later"
fi
