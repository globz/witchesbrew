#!/bin/bash
#iREP server - [ODBC configuration files]
#guide : https://www.tecmint.com/set-unset-environment-variables-in-linux/
#env help : https://www.tecmint.com/set-unset-environment-variables-in-linux/

function brew_odbc_conf() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/dexterity/reagents"
  local ODBC_INI="$REAGENTS/odbc-ini/iREP-$ENV/odbc.ini"
  local ODBC_INST="$REAGENTS/odbc-ini/odbcinst.ini"
  local ODBC_DIR="/home/$USER/odbc-ini"

  echo "Brewing ODBC configuration files..."

  mkdir -p $ODBC_DIR
  cp $ODBC_INI $ODBC_DIR
  cp $ODBC_INST $ODBC_DIR

  #ENV variables
  if grep -Fq "ODBCSYSINI" ~/.bashrc || grep -Fq "ODBCSYSINI" ~/.bash_profile || grep -Fq "ODBCINI" ~/.bashrc || grep -Fq "ODBCINI" ~/.bash_profile
  then
    echo "export ODBCSYSINI & ODBCINI are already present in ~/.bashrc & ~/.bash_profile"
    echo "Please remove those exports and try again..."
  else
    echo "export ODBCSYSINI=$ODBC_DIR" | sudo tee -a ~/.bashrc
    echo "export ODBCSYSINI=$ODBC_DIR" | sudo tee -a ~/.bash_profile
    echo "export ODBCINI=$ODBC_DIR/odbc.ini" | sudo tee -a ~/.bashrc
    echo "export ODBCINI=$ODBC_DIR/odbc.ini" | sudo tee -a ~/.bash_profile

    echo "Please enter the ODBC credentials for iREP-$ENV (If already configured skip by pressing ENTER)"
    read -p 'Username: ' USERNAME_ODBC
    read -sp 'Password: ' PASSWORD_ODBC
    sed -i "s/KEEPASS_ODBC_USR/$USERNAME_ODBC/" "$ODBC_DIR/odbc.ini"
    sed -i "s/KEEPASS_ODBC_PWD/$PASSWORD_ODBC/" "$ODBC_DIR/odbc.ini"

    source ~/.bashrc
    source ~/.bash_profile

    #Create Hard symlink to /etc/
    #PHP reads this location by default
    #Edit mades in /home/$USER/odbc-ini will be reflected in /etc/
    sudo ln $ODBC_DIR/odbc.ini /etc/
    sudo ln $ODBC_DIR/odbcinst.ini /etc/

    odbcinst -j

    echo "ODBC configuration files are now active for iREP-$ENV"

  fi

}
