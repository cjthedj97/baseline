#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root."
    exit
fi

# Declared Varables

# Creating the needed Directories
mkdir ~/baseline
mkdir ~/baseline/log
mkdir ~/baseline/ssh

# Saves/Copys files preserving file attributes for incidence Response
cp -Ra --preserve /var/log ~/baseline/log
cp -Ra --preserve /etc/profile ~/baseline/ssh/global-bashrc
cp -Ra --preserve ~/.ssh/* ~/baseline/ssh/$USER/
cp -Ra --preserve ~/.bash_history ~/baseline/ssh/$USER/bash_history
cp -Ra --preserve ~/.bash_logout ~/baseline/ssh/$USER/bash_logout
cp -Ra --preserve ~/.bash_profile ~/baseline/ssh/$USER/bash_profile
cp -Ra --preserve ~/.bashrc ~/baseline/ssh/$USER/bashrc

## Checks the /etc/apt/sources.list and ask if it is correct
echo "Please verify that the source list is correct"
cat /etc/apt/sources.list | less
echo "Is this correct?"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
  echo "Starting the Script"

  # Updating the system
  apt update -Y
  apt upgrade -Y

  # Installing the Required Software
	apt install curl git nano lynx



	# Check to see if system reboot is required
  if [ -f /var/run/reboot-required ]; then
  echo 'Reboot Required, please consiter rebooting'
  fi
else
        echo "You entered N or an incorrct response"
fi
