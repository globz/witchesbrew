Installation :
- cd ~/ && git clone || pull https://github.com/globz/witchesbrew.git
- cd ~/witchesbrew && ./install.sh

Usage :
- witchesbrew $TARGET (Brew from default cauldron configuration)
- witchesbrew $TARGET $BUILD_SCRIPT (Brew specific $BUILD_SCRIPT)
- $TARGET = InDev, MTL, JVF

TODO :
- Finalize build-architecture & make use of $USER instead of TARGET
- Improve install.sh, try to replace exec bash
