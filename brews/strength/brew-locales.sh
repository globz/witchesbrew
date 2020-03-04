#!/bin/bash
#iREP server - [locales]
#source : https://lintut.com/how-to-set-up-system-locale-on-ubuntu-18-04/
#source : https://perlgeek.de/en/article/set-up-a-clean-utf8-environment

function brew_locales() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")

  echo "Brewing locales..."

  sudo apt install locales

  read -p "Please select locale en_CA UTF-8 ~ Press enter to continue..."
  sudo dpkg-reconfigure locales

  sudo update-locale LANG=en_CA.UTF-8
  sudo update-locale LANGUAGE=en_CA:en

  locale

  #Output should match :
  # LANG=en_CA.UTF-8
  # LANGUAGE=en_CA:en
  # LC_CTYPE="en_CA.UTF-8"
  # LC_NUMERIC="en_CA.UTF-8"
  # LC_TIME="en_CA.UTF-8"
  # LC_COLLATE="en_CA.UTF-8"
  # LC_MONETARY="en_CA.UTF-8"
  # LC_MESSAGES="en_CA.UTF-8"
  # LC_PAPER="en_CA.UTF-8"
  # LC_NAME="en_CA.UTF-8"
  # LC_ADDRESS="en_CA.UTF-8"
  # LC_TELEPHONE="en_CA.UTF-8"
  # LC_MEASUREMENT="en_CA.UTF-8"
  # LC_IDENTIFICATION="en_CA.UTF-8"
  # LC_ALL=


  echo "locales are now properly configured for ENV : $ENV ~ Please restart your terminal or logout in order to apply your new locale."

}
