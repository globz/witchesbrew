#!/bin/bash
#iREP server - [unixODBC]
#source : http://www.unixodbc.org/

function brew_unixodbc() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"

  echo "Brewing unixODBC..."

  cp $REAGENTS/unixODBC-2.3.7.tar /home/$USER/
  tar xvf /home/$USER/unixODBC-2.3.7.tar

  sudo apt-get install build-essential

  cd /home/$USER/unixODBC-2.3.7/
  ./configure && make

  if echo `odbcinst --version` | grep -q "unixODBC 2.3.7"
  then
    echo "unixODBC has been successfully installed for ENV : $ENV"
  else
    echo "unixODBC failed to install for ENV : $ENV"
  fi

}
