#!/bin/bash
#iREP server - [ODBC configuration files]

function brew_odbc_conf() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"

  echo "Brewing ODBC configuration files..."

  ODBC_CONF=$REAGENTS/odbc-ini/iREP-$ENV/odbc.ini

  cat ODBC_CONF

}
