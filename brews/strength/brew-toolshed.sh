#!/bin/bash
#iREP server - [toolshed]

function brew_toolshed() {

  local ENV=$1
  local GIT_DIR="/home/$USER/git-irep-toolshed"
  local GIT_REPO="/var/www/toolshed"

  echo "Brewing iREP-toolshed..."

  #Clone iREP-toolshed from master branch
  #git-dir is located @ /home/$USER/git-irep-toolshed
  git clone --separate-git-dir=$GIT_DIR https://github.com/globz/iREP-toolshed.git $GIT_REPO

  #Stop tracking file permission
  (cd $GIT_DIR && git config --local core.fileMode false)

  echo "iREP-toolshed has been successfully cloned @ /var/www/toolshed for ENV : $ENV"

}
