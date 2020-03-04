#!/bin/bash
#iREP server - [php tools]

function brew_php_tools() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"
  local PHPTOOLS="$REAGENTS/php-tools"

  echo "Brewing PHP-TOOLS..."

  echo "The following tools are available, please make a choice ::"
  echo "1 - tail apache2 error.log"

  read -p 'Choice: ' TOOL

  if [ "$TOOL" == 1 ]
  then
    ./$PHPTOOLS/tailPHP.sh
  fi

}
