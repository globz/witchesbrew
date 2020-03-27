#!/bin/bash
#iREP server - [iREP config]

function brew_irep_config() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local CONFIG="$DIR/brews/strength/reagents/iREP-config/iREP-$ENV/config.ini"
  local CONFIG_DIR="/var/www/config"

  echo "Brewing iREP config..."

  mkdir -p -v $CONFIG_DIR && touch "$CONFIG_DIR/config.ini" && cat $CONFIG | sudo tee "$CONFIG_DIR/config.ini"

  echo "Please enter the database credentials for iREP-$ENV (If already configured skip by pressing ENTER)"
  read -p 'Username: ' USERNAME_DB
  read -sp 'Password: ' PASSWORD_DB
  sed -i "s/KEEPASS_DB_USR/$USERNAME_DB/" "$CONFIG_DIR/config.ini"
  sed -i "s/KEEPASS_DB_PWD/$PASSWORD_DB/" "$CONFIG_DIR/config.ini"

  echo -e "\nPlease enter the SMTP credentials for iREP-$ENV (If already configured skip by pressing ENTER)"
  read -p 'Username: ' USERNAME_SMTP
  read -sp 'Password: ' PASSWORD_SMTP
  sed -i "s/KEEPASS_SMTP_USR/$USERNAME_SMTP/" "$CONFIG_DIR/config.ini"
  sed -i "s/KEEPASS_SMTP_PWD/$PASSWORD_SMTP/" "$CONFIG_DIR/config.ini"

  echo "iREP config is now properly configured for ENV : $ENV"

}
