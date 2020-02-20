Installation :
- cd ~/ && git clone || pull https://github.com/globz/witchesbrew.git
- cd ~/witchesbrew && ./install.sh

Usage :
- witchesbrew $ENV (Brew from default cauldron configuration)
- witchesbrew $ENV $BREW_RECIPE (Brew specific $BREW_RECIPE)
- $ENV = InDev, MTL, JVF
- $BREW_RECIPE = brew-* (no file extension needed)

TODO :
- Test brew-wkhtmltopdf grep version string
- Validate if iseriesaccess_7.1.0-1.0_amd64.deb still works on Ubuntu 18
