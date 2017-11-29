#!/bin/bash
## Baseline Script that is ran on a system to give you a baseline to go from there.
## Written by cjthedj97 on Github

## The Start of the Script

## Checking to see if script was ran as root or with sudo privileges
if [ $(id -u) != 0 ]; then
    echo "You're not root. Please run as root"
    exit
fi

# Lists the repos and asks to confirm if they are correct
yum -v repolist | more
echo "Is this correct?"
echo "Enter Y or N"
read a
if [[ $a == "Y" || $a == "Y" ]]; then
  # If Correct then Runs the following
	echo "Starting the Script"
  sleep 5
  yum update -y &> ~/baseline/update.log

	# Installing The Required Software
  echo "Installing the required Software"
  sleep 5
  yum install ca-certificates curl git nano nss openssl lynx python tmux yum-utils -y

  # Downloads and Runs IR (Incidance Response) program
  echo "Installing IR program"
  Sleep 5
  git clone https://github.com/SekoiaLab/Fastir_Collector_Linux
  cd Fastir_Collector_Linux
  python fastIR_collector_linux.py &> ~/baseline/fastir.log
  cp -R output/ ~/baseline/output

	# Setting up and Installing Lynis
  touch /etc/yum.repos.d/cisofy-lynis.repo
  cp ~/baseline/cisofy-lynis.repo /etc/yum.repos.d/cisofy-lynis.repo
  yum makecache fast
  yum install lynis -y

  # Setting up and Installing Lynis
  echo "Starting Lynis"
  Sleep 5
  lynis audit system
  cp /var/log/lynis.log ~/baseline/output/lynis.log
  cp /var/log/lynis-report.dat ~/baseline/output/lynis-report.dat

  # Updating the system
  echo "Upgradeing"
  yum upgrade -y

  needs-restarting -r
  sleep 5
  exit
else
  echo "You entered N or an incorrct response"
	echo "Please try again later"
fi
