#!/bin/bash
#iREP server - [samba]


function brew_samba() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/strength/reagents"
  local SMBCREDENTIALS="/home/$USER/.smbcredentials"
  local SAMBA_CONF="/etc/samba/smb.conf"
  local MOUNT_GP1070="/mnt/GP1070"
  local MOUNT_TRAILBLAZER="/mnt/trailBlazer"
  local MOUNT_WALMART="/mnt/trailBlazer/Walmart"
  local FSTAB_CONF="$REAGENTS/samba/iREP-$ENV/fstab_conf"
  local NSSWITCH_CONF="$REAGENTS/samba/nsswitch.conf"

  echo "Brewing samba..."

  sudo apt install cifs-utils samba-common samba winbind

  touch $SMBCREDENTIALS
  echo "Please enter the samba credentials for iREP-$ENV"
  read -p 'Username: ' USERNAME
  read -sp 'Password: ' PASSWORD
  echo -e "username=$USERNAME\npassword=$PASSWORD" > $SMBCREDENTIALS
  chmod 0700 $SMBCREDENTIALS

  #Create mounting point for GP1070
  sudo mkdir -p $MOUNT_GP1070
  sudo chown $USER:$USER $MOUNT_GP1070
  sudo chmod 0700 $MOUNT_GP1070

  #Create mounting point for trailBlazer
  sudo mkdir -p $MOUNT_TRAILBLAZER
  sudo chown $USER:$USER $MOUNT_TRAILBLAZER
  sudo chmod 0700 $MOUNT_TRAILBLAZER

  #Create mounting point for trailBlazer/Walmart
  sudo mkdir -p $MOUNT_WALMART
  sudo chown $USER:$USER $MOUNT_WALMART
  sudo chmod 0700 $MOUNT_WALMART

  #Append FSTAB_CONF
  cat $FSTAB_CONF | sudo tee -a /etc/fstab

  #Validate /etc/nsswitch.conf on Ubuntu 18.04 before overriding it
  #cat $NSSWITCH_CONF | sudo tee /etc/nsswitch.conf

  #Validate /etc/samba/smb.conf on Ubuntu 18.04 before overriding it
  #cat $SAMBA_CONF | sudo tee /etc/samba/smb.conf

  #sudo service smbd restart
  #sudu mount -a
  #df -h

  echo "samba is now properly configured for ENV : $ENV"

}
