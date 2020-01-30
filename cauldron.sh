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

#TARGET (MTL/JVF/InDev)
TARGET="InDev"

function cauldron () {

    if [ "$DEXTERITY" == true ]
    then
      echo "dex"

    fi

    if [ "$INTELLECT" == true ]
    then
      echo "int"

    fi

    if [ "$STRENGTH" == true ]
    then
      echo "str"

    fi
}
