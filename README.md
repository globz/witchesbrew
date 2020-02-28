Installation :
- git clone https://github.com/globz/witchesbrew.git witchesbrew
- cd witchesbrew/ && ./install.sh

Usage :
- witchesbrew $ENV (Brew from default cauldron configuration)
- witchesbrew $ENV $BREW_RECIPE (Brew specific $BREW_RECIPE)
- $ENV = InDev, MTL, JVF
- $BREW_RECIPE = brew-* (no file extension needed)

TODO :
- Test brew-wkhtmltopdf grep version string
- Validate if iseriesaccess_7.1.0-1.0_amd64.deb still works on Ubuntu 18
- fail2ban may not work as expected on Ubuntu 18.04 LTS (test properly)
- fail2ban apache-common patch will probably not be needed in Ubuntu 18.04 LTS
- samba ~ Validate /etc/nsswitch.conf on Ubuntu 18.04 before overriding it
- samba ~ Validate /etc/samba/smb.conf on Ubuntu 18.04 before overriding it
