#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root."
    exit
fi

# Creating the needed Directories
mkdir ~/baseline

## Checks the /etc/apt/sources.list and ask if it is correct
echo "Please verify that the source list is correct"
cat /etc/apt/sources.list | less
echo "Is this correct?"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
  echo "Starting the Script"
  apt update -Y

  # Installing the Required Software
  echo "Installing the required Software"
	apt install curl git nano lynx python tmux lynis -y

  # Downloads and Runs IR (Incidance Response) program
  echo "Installing IR program"
  git clone https://github.com/SekoiaLab/Fastir_Collector_Linux
  cd Fastir_Collector_Linux
  python fastIR_collector_linux.py

  # Setting up and Installing Lynis
  touch lynis.$HOSTNAME.$(date +%F_%R)
  lynis audit system > ~/baseline/lynis/$HOSTNAME.$(date +%F_%R)

  # Updating the system
  echo "Upgradeing"
  apt upgrade -Y

	# Check to see if system reboot is required
  if [ -f /var/run/reboot-required ]; then
  echo 'Reboot Required, please consiter rebooting'
  sleep 5
  exit
  fi
else
        echo "You entered N or an incorrct response"
fi
