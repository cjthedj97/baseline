#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root."
    exit
fi

## Checks the /etc/apt/sources.list and ask if it is correct
echo "Please verify that the source list is correct"
cat /etc/apt/sources.list | less
echo "Is this correct?"
echo "Enter Y or N"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
  echo "Starting the Script"
  sleep 5
  apt update -y &> ~/baseline/update.log

  # Installing the Required Software
  echo "Installing the required Software"
  sleep 5
	apt install curl git nano lynx python tmux lynis -y

  # Downloads and Runs IR (Incidance Response) program
  echo "Installing IR program"
  sleep 5
  git clone https://github.com/SekoiaLab/Fastir_Collector_Linux
  cd Fastir_Collector_Linux
  python fastIR_collector_linux.py &> ~/baseline/fastir.log
  cp -R output/ ~/baseline/output

  # Setting up and Installing Lynis
  echo "Starting Lynis"
  Sleep 5-
  lynis audit system
  cp /var/log/lynis.log ~/baseline/output/lynis.log
  cp /var/log/lynis-report.dat ~/baseline/output/lynis-report.dat

  # Updating the system
  echo "Upgradeing"
  apt upgrade -y

	# Check to see if system reboot is required
  if [ -f /var/run/reboot-required ]; then
  echo 'Reboot Required, please consiter rebooting'
  sleep 5
  exit
  fi
else
        echo "You entered N or an incorrct response"
        echo "Please try again later"
fi
