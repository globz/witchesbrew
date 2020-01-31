#!/bin/bash
#bashrc alias for witchesbrew/cauldron.sh

echo "Installing witchesbrew..."

function witchesbrew () {
  source ~/witchesbrew/cauldron.sh
  cauldron
}

typeset -f >> ~/.bashrc

source ~/.bashrc && exec bash
