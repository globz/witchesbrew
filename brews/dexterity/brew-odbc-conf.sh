#!/bin/bash
#iREP server - [ODBC configuration files]

function brew_odbc_conf() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"

  echo "Brewing ODBC configuration files..."

  ODBC_CONF=$REAGENTS/odbc-ini/iREP-$ENV
  ODBC_DRV=$REAGENTS/odbc-ini/odbcinst.ini

  #odbcinst -i -s -f ODBC_CONF
  cp -R $ODBC_CONF /home/$USER/odbc-ini/
  cp $ODBC_DRV /home/$USER/odbc-ini/

  #ENV variables
  export ODBCSYSINI=/home/$USER/odbc-ini
  export ODBCINI=/home/$USER/odbc-ini/odbc.ini
  #export LD_LIBRARY_PATH=/usr/lib64/:$LD_LIBRARY_PATH


  echo "ODBC configuration files are now active, please edit and configure the user/password for both odbc.ini files located @"
  odbcinst -j

}
