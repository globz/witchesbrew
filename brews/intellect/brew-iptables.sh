#!/bin/bash
#iREP server - [iptables]
#TODO : https://askubuntu.com/questions/1052919/iptables-reload-restart-on-ubuntu-18-04

function brew_iptables() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/intellect/reagents"
  local V4=$REAGENTS/iptables/iREP-$ENV/V4
  local V6=$REAGENTS/iptables/iREP-$ENV/V6

  echo "Brewing iptables..."

  sudo apt install iptables

  sudo iptables-restore < V4
  sudo ip6tables-restore < V6

  sudo apt install iptables-persistent

  sudo invoke-rc.d iptables-persistent save

  sudo iptables -L && sudo ip6tables -L

  echo "iptables are now properly configured for ENV : $ENV"

}
