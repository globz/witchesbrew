#!/bin/bash
#iREP server - [cauldron]

#This script is in charge of creating the required environment in order for iREP to work properly.
#Out of this hellish brewing will emerge a server properly configured and ready to operate a given iREP instance.

#Cauldron default configuration
#The configuration below will be executed by default if no $BREW_RECIPE has been supplied!

#brews/dexterity
DEXTERITY=false
BREW_EMACS=true
BREW_PHP_TOOLS=true
BREW_WKHTMLTOPDF=true
BREW_UNIXODBC=true

#brews/intelligence
INTELLECT=false
BREW_CRONJOBS=true

#brews/strength
STRENGTH=false
BREW_ARCHITECTURE=true

function cauldron () {

  local VALID_ENV=("MTL" "JVF" "InDev")
  local ENV=$1
  local BREW_RECIPE=$2
  local DIR=$(locate -br "^witchesbrew$")

  if ! elementIn "$ENV" "${VALID_ENV[@]}"
  then
    echo "Invalid ENV, expected value are one the following : ${VALID_ENV[@]}" && return

  elif [ "$ENV" == "MTL" ] && [ "$USER" != "irep" ]
  then
    echo "Invalid user for ENV : $ENV - expected user [irep]" && return

  elif [ "$ENV" == "InDev" ] && [ "$USER" != "dev" ]
  then
    echo "Invalid user for ENV : $ENV - expected user [dev]" && return

  elif [ "$ENV" == "JVF" ] && [ "$USER" != "irep" ]
  then
    echo "Invalid user for ENV : $ENV - expected user [irep]" && return
  fi

  if [ ! -z "$BREW_RECIPE" ]
  then
    local BREW=$(echo "$BREW_RECIPE" | tr '-' '_')
    local POUCH=$(locate -br "^$BREW_RECIPE.sh$")
    echo -e "\e[0;35mBrewing recipe located @ $POUCH for ENV : $ENV\e[m"
    source $POUCH
    $BREW $ENV

  else

    if [ "$DEXTERITY" == true ]
    then
      echo -e "\e[0;35mBrewing DEXTERITY potions...\e[m"

      if [ "$BREW_WKHTMLTOPDF" == true ]
      then
        source $DIR/brews/dexterity/brew-wkhtmltopdf.sh
        brew_wkhtmltopdf $ENV
      fi

      if [ "$BREW_UNIXODBC" == true ]
      then
        source $DIR/brews/dexterity/brew-unixodbc.sh
        brew_unixodbc $ENV
      fi

    fi

    if [ "$INTELLECT" == true ]
    then
      echo -e "\e[0;35mBrewing INTELLECT potions...\e[m"

      if [ "$BREW_CRONJOBS" == true ]
      then
        source $DIR/brews/intellect/brew-cronjobs.sh
        brew_cronjobs $ENV
      fi

    fi

    if [ "$STRENGTH" == true ]
    then
      echo -e "\e[0;35mBrewing STRENGTH potions...\e[m"
    fi

    if [ "$BREW_ARCHITECTURE" == true ]
    then
      source $DIR/brews/strength/brew-architecture.sh
      brew_architecture $ENV
    fi

  fi

}

elementIn () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}
