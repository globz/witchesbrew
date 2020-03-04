#!/bin/bash
#iREP server - [emacs]

function brew_emacs() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"
  local DOT_EMACS="$REAGENTS/.emacs"

  echo "Brewing Emacs..."

  sudo apt install emacs

  cp $DOT_EMACS /home/$USER/

}
