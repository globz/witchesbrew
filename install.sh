#!/bin/bash
#bashrc invocation call for witchesbrew/cauldron.sh

echo "Installing witchesbrew..."

if grep -Fq "witchesbrew" ~/.bashrc || grep -Fq "witchesbrew" ~/.bash_profile
then
  echo "witchesbrew is already present in your ~/.bashrc configuration file."
  echo "remove it from ~/.bashrc in order to re-install||upgrade"
else
  function witchesbrew () {
    local ENV=$1
    local BREW_RECIPE=$2
    local DIR=$(locate -br "^witchesbrew$")
    source $DIR/cauldron.sh
    cauldron $ENV $BREW_RECIPE
  }

  typeset -f >> ~/.bashrc
  typeset -f >> ~/.bash_profile

  echo "witchesbrew will now update mlocate database..."
  sudo updatedb

  source ~/.bashrc
  source ~/.bash_profile

  echo "witchesbrew is now installed."

fi
