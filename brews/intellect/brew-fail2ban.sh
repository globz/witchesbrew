#!/bin/bash
#iREP server - [fail2ban]
#wiki : https://github.com/fail2ban/fail2ban/wiki
#source : https://github.com/fail2ban/fail2ban
#setup : https://www.linode.com/docs/security/using-fail2ban-to-secure-your-server-a-tutorial/

function brew_fail2ban() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/intellect/reagents"
  local JAIL_LOCAL=$REAGENTS/fail2ban/iREP-$ENV/jail.local
  local iREP_JAIL_CONF=$REAGENTS/fail2ban/jails/irep-auth.conf
  local APACHE_COMMON_JAIL_CONF=$REAGENTS/fail2ban/jails/apache-common.conf #TODO validate if needed or not

  echo "Brewing fail2ban..."

  sudo apt install fail2ban

  #Configuration change must be made to .local files
  sudo touch /etc/fail2ban/fail2ban.local
  sudo touch /etc/fail2ban/jail.local

  #Custom iREP Jail
  sudo cp $iREP_JAIL_CONF /etc/fail2ban/filter.d/

  #jail.local configuration
  cat $JAIL_LOCAL | sudo tee /etc/fail2ban/jail.local

  #Patch for apache-common.conf - Most likely only needed for Ubuntu 14 LTS
  cat $APACHE_COMMON_JAIL_CONF | sudo tee /etc/fail2ban/filter.d/apache-common.conf

  sudo fail2ban-client reload

  echo "fail2ban is now properly configured for ENV : $ENV"

}
