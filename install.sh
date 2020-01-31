#!/bin/bash
#bashrc alias for witchesbrew/cauldron.sh

function witchesbrew () {
  source ~/witchesbrew/cauldron.sh
  cauldron
}

typeset -f >> ~/.bashrc

source ~/.bashrc
