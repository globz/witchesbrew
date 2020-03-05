#!/bin/bash
#iREP server - [toolbox]

function brew_toolbox() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"
  local TOOLBOX="$REAGENTS/toolbox"

  echo "Brewing toolbox..."

  echo "The following tools are available, please make a choice ::"
  echo -e "\e[0;35m1 - tail apache2 error.log\e[m"

  read -p 'Choice: ' TOOL

  if [ "$TOOL" == 1 ]
  then
    $TOOLBOX/tailPHP.sh #executable flag set with git update-index --chmod=+x
  fi

}
