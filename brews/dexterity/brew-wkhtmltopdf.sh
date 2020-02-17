#!/bin/bash
#iREP server - [wkhtmltopdf]
#source : https://wkhtmltopdf.org/

function brew_wkhtmltopdf() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"

  echo "Brewing wkhtmltopdf..."

  sudo apt intall $REAGENTS/wkhtmltox_0.12.5-1.bionic_amd64

  if echo `wkhtmltopdf -V` | grep -q "wkhtmltopdf 0.12.5.1 (with patched qt)" #update version string if needed
  then
    echo "wkhtmltopdf has been successfully installed for ENV : $ENV"
  else
    echo "wkhtmltopdf failed to install for ENV : $ENV"
  fi

}
