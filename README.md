Installation :
- cd ~/ && git clone || pull https://github.com/globz/witchesbrew.git
- cd ~/witchesbrew && ./install.sh

Usage :
- witchesbrew $TARGET (Brew from default cauldron configuration)
- witchesbrew $TARGET $BREW_RECIPE (Brew specific $BREW_RECIPE)
- $TARGET = InDev, MTL, JVF
- $BREW_RECIPE = brew-* (no file extension needed)

TODO :
- Finalize build-architecture & make use of $USER instead of TARGET
- Improve install.sh, try to replace exec bash
