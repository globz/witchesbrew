#!/bin/bash
#iREP server - [cauldron]
# Installation : copy script in $HOME and chmod u+x cauldron.sh

#This script is in charge of creating the required environment in order for iREP to work properly.
#Out of this hellish brewing will emerge a server properly configured and ready to operate a given iREP instance.

#brews/dexterity
DEXTERITY=false
BUILD_EMACS=true
BUILD_PHP_TOOLS=true

#brews/intelligence
INTELLECT=true
BUILD_CRONJOBS=false

#brews/strength
STRENGTH=true
BUILD_ARCHITECTURE=true

function cauldron () {

  local TARGET=$1 #MTL/JVF/InDev
  local BUILD_SCRIPT=$2

  if [ ! -z "$BUILD_SCRIPT" ]
  then
    echo "invoking a single build script for TARGET: $TARGET"

  else

    if [ "$DEXTERITY" == true ]
    then
      echo "Brewing DEXTERITY potions..."

    fi

    if [ "$INTELLECT" == true ]
    then
      echo "Brewing INTELLECT potions..."

      if [ "$BUILD_CRONJOBS" == true ]
      then
        source ./brews/intellect/build-cronjobs.sh
        build_cronjobs $TARGET
      fi

    fi

    if [ "$STRENGTH" == true ]
    then
      echo "Brewing STRENGTH potions..."

    fi

  fi
}
