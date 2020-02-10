#!/bin/bash
#bashrc invocation call for witchesbrew/cauldron.sh

echo "Installing witchesbrew..."

if grep -Fq "witchesbrew" ~/.bashrc
then
  echo "witchesbrew is already present in your ~/.bashrc configuration file."
  echo "remove it from ~/.bashrc in order to re-install||upgrade"
else
  function witchesbrew () {
    local TARGET=$1
    local BREW_RECIPE=$2
    source ~/witchesbrew/cauldron.sh
    cauldron $TARGET $BREW_RECIPE
  }

  typeset -f >> ~/.bashrc

  source ~/.bashrc && exec bash
fi
