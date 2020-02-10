#!/bin/bash
#iREP server - [cauldron]

#This script is in charge of creating the required environment in order for iREP to work properly.
#Out of this hellish brewing will emerge a server properly configured and ready to operate a given iREP instance.

#Cauldron default configuration
#The configuration below will be executed by default if no $BUILD_SCRIPT has been supplied!

#brews/dexterity
DEXTERITY=false
BUILD_EMACS=true
BUILD_PHP_TOOLS=true

#brews/intelligence
INTELLECT=true
BUILD_CRONJOBS=true

#brews/strength
STRENGTH=true
BUILD_ARCHITECTURE=true

function cauldron () {

  local TARGET=$1 #MTL/JVF/InDev
  local BREW_RECIPE=$2

  if [ ! -z "$BREW_RECIPE" ] && [ ! -z "$TARGET" ]
  then
    local BREW=$(echo "$BREW_RECIPE" | tr '-' '_')
    local POUCH=$(locate -br "^$BREW_RECIPE.sh$")
    echo "Brewing recipe located @ $POUCH for TARGET : $TARGET"
    source $POUCH
    $BREW $TARGET

  else

    if [ "$DEXTERITY" == true ] && [ ! -z "$TARGET" ]
    then
      echo -e "\e[0;35mBrewing DEXTERITY potions...\e[m"
    fi

    if [ "$INTELLECT" == true ] && [ ! -z "$TARGET" ]
    then
      echo -e "\e[0;35mBrewing INTELLECT potions...\e[m"

      if [ "$BUILD_CRONJOBS" == true ]
      then
        source ./brews/intellect/build-cronjobs.sh
        build_cronjobs $TARGET
      fi

    fi

    if [ "$STRENGTH" == true ] && [ ! -z "$TARGET" ]
    then
      echo -e "\e[0;35mBrewing STRENGTH potions...\e[m"
    fi

  fi
}
