#!/bin/bash
#bashrc invocation call for witchesbrew/cauldron.sh

echo "Installing witchesbrew..."

if grep -F "witchesbrew" ~/.bashrc
then
  echo "witchesbrew is already present in your ~/.bashrc configuration file."
  echo "remove it from ~/.bashrc in order to re-install||upgrade"
else
  function witchesbrew () {
    source ~/witchesbrew/cauldron.sh
    cauldron
  }

  typeset -f >> ~/.bashrc

  source ~/.bashrc && exec bash
fi
