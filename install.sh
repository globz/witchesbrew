#!/bin/bash -i
#bashrc alias for witchesbrew/cauldron.sh

echo "Installing witchesbrew...press ENTER to continue or CTRL+C to cancel"

function witchesbrew () {
  source ~/witchesbrew/cauldron.sh
  cauldron
}

typeset -f >> ~/.bashrc && source ~/.bashrc
