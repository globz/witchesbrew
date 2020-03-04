#!/bin/bash
#iREP server - [samba]
#source : http://patorjk.com/software/taag/#p=display&f=Doom&t=iREP%20-%20MTL
#setup : https://www.tecmint.com/protect-ssh-logins-with-ssh-motd-banner-messages/

function brew_banner() {

  local ENV=$1
  local DIR=$(locate -br "^witchesbrew$")
  local REAGENTS="$DIR/brews/strength/reagents"
  local BANNER="$REAGENTS/banners/iREP-$ENV/banner"

  echo "Brewing banner..."

  cat $BANNER | sudo tee /etc/issue.net

  sudo sed -i 's/#Banner.*/Banner \/etc\/issue.net/' /etc/ssh/sshd_config

  echo "The banner is now deployed for ENV: $ENV ~ SAIL STRONG!"

}
