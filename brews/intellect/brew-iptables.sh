#!/bin/bash
#iREP server - [iptables]

function brew_iptables() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/intellect/reagents"
  local V4=$REAGENTS/iptables/iREP-$ENV/V4
  local V6=$REAGENTS/iptables/iREP-$ENV/V6

  echo "Brewing iptables..."

  sudo apt install iptables

  sudo iptables-restore < V4
  sudo iptables-restore < V6

  sudo apt install iptables-persistent

  sudo invoke-rc.d iptables-persistent save

  echo "iptables are now properly configured for ENV : $ENV"

}
