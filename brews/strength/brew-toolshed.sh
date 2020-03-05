#!/bin/bash
#iREP server - [toolshed]

function brew_toolshed() {

  local ENV=$1

  echo "Brewing iREP-toolshed..."

  #Clone iREP-toolshed from master branch
  #git-dir is located @ /home/$USER/git-irep-toolshed
  git clone --separate-git-dir=/home/$USER/git-irep-toolshed https://github.com/globz/iREP-toolshed.git /var/www/toolshed

  echo "iREP-toolshed has been successfully cloned @ /var/www/toolshed for ENV : $ENV"

}
