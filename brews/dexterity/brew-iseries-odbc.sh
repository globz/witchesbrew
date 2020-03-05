#!/bin/bash
#iREP server - [iSeries Access ODBC driver]

function brew_iseries_odbc() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"
  local ODBC_DRIVER="$REAGENTS/iseriesaccess_7.1.0-1.0_amd64.deb"

  echo "Brewing iSeries Access ODBC driver..."

  sudo apt install odbcinst1debian2
  sudo apt install -f

  sudo dpkg -i $ODBC_DRIVER

  sudo ln -s /opt/ibm/iSeriesAccess/lib64/libcwb* /usr/lib

  echo "iSeries Access ODBC driver is now installed!"

}
