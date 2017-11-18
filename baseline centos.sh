#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root"
    exit
fi

# Declared Varables

# Creating the needed Directories
mkdir ~/baseline
mkdir ~/baseline/log
mkdir ~/baseline/ssh
mkdir ~/baseline/ssh/root


# Saves/Copys files preserving file attributes for incidence Response
cp -Ra --preserve /var/log ~/baseline/log
cp -Ra --preserve /etc/profile ~/baseline/ssh/global-bashrc
cp -Ra --preserve ~/.ssh/* ~/baseline/ssh/$USER/
cp -Ra --preserve ~/.bash_history ~/baseline/ssh/$USER/bash_history
cp -Ra --preserve ~/.bash_logout ~/baseline/ssh/$USER/bash_logout
cp -Ra --preserve ~/.bash_profile ~/baseline/ssh/$USER/bash_profile
cp -Ra --preserve ~/.bashrc ~/baseline/ssh/$USER/bashrc


# Lists the repos and asks to confirm if they are correct
yum -v repolist | more
echo "Is this correct?"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
	echo "Starting the Script"

	# Installing The Required Software
  yum install ca-certificates curl git nano nss openssl lynx  python -y

	# Setting up and Installing Lynis
  touch /etc/yum.repos.d/cisofy-lynis.repo
  cp .cisofy-lynis.repo /etc/yum.repos.d/cisofy-lynis.repo
  yum makecache fast
  yum install lynis -y

  touch lynis.$HOSTNAME.$(date +%F_%R)
  lynis audit system > ~/baseline/lynis/$HOSTNAME.$(date +%F_%R)



else
        echo "You Need to fix the Source List!"
	echo "Please try again later"
fi
