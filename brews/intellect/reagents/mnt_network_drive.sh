#!/bin/bash
# This script is waiting for the network to come UP before running mount -a
# The configuration is done in /etc/fstab & /etc/nsswitch.conf
# The credentials for mapping the network drive are residing in $HOME/.smbcredentials
# !!!This script might cause some issue with iptable rules must always ping google.com!!!
# iREP-MTL/iREP-JVF : change host from 10.1.1.10 to google.com because of iptables rules

while true; do

if ! ( ping -c 1 google.com ) > /dev/null

then

   echo "Network is NOT up, cannot mount network drive..."

   sleep 2

else

   echo "Network is UP, lets mount our network drive!"

   sudo mount -a

   break

fi
done
