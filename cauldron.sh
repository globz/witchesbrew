#!/bin/bash
#iREP server - [cauldron]

#This script is in charge of creating the required environment in order for iREP to work properly.
#Out of this hellish brewing will emerge a server properly configured and ready to operate a given iREP instance.

#brews/dexterity
DEXTERITY=false
BUILD_EMACS=true
BUILD_PHP_TOOLS=true

#brews/intelligence
INTELLIGENCE=true
BUILD_CRONJOBS=false

#brews/strength
STRENGTH=true
BUILD_ARCHITECTURE=true


function cauldron {

    if [ "$DEXTERITY" == true ]
    then
      echo "dex"

    if [ "$INTELLIGENCE" == true ]
    then
      echo "int"

    if [ "$STRENGTH" == true ]
    then
      echo "str"

    fi
}
