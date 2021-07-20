#!/bin/bash

set -e

echo "Installing witchesbrew..."

# gawk requirement
_gawk=$( command -v gawk )
if [[ -z "${_gawk}" ]];
then
    echo -e "\033[31mError :\e[0m Aborting installation... [host-requirement: gawk is not installed]"
    exit 1
fi

# $HOME/bin must be exported to $PATH
if ! grep -Fq 'PATH="$HOME/bin:$PATH"' ~/.profile
then
    cat<<"EOF" >> ~/.profile
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi
EOF
else
    echo "$HOME/bin already exported to PATH"
fi

# Create $HOME/bin if not available
if [ -d "$HOME/bin" ];
then
    echo "Directory $HOME/bin already exists."
else
    echo "Creating Directory $HOME/bin" && mkdir $HOME/bin
fi

function repl() {
    local wd=$(readlink -f $HOME/bin/witchesbrew_wd)

    . $wd/cauldron.sh
    cauldron "$@"
}

typeset -f > $HOME/bin/witchesbrew && echo 'repl "$@"' >> $HOME/bin/witchesbrew
chmod u+x $HOME/bin/witchesbrew
ln -sf "$(pwd)" $HOME/bin/witchesbrew_wd 

cat<<"EOF"
                             (
                             )  )
                          ______(____
                         (___________)
                          /         \
                         /           \
                        |             |
                    ____\             /____
                   ()____'.__     __.'____()
                        .'` .'```'. `-.
                       ().'`       `'.()

▄▄▌ ▐ ▄▌▪ ▄▄▄▄▄ ▄▄·  ▄ .▄▄▄▄ ..▄▄ · ▄▄▄▄· ▄▄▄  ▄▄▄ .▄▄▌ ▐ ▄▌
██· █▌▐███•██  ▐█ ▌▪██▪▐█▀▄.▀·▐█ ▀. ▐█ ▀█▪▀▄ █·▀▄.▀·██· █▌▐█
██▪▐█▐▐▌▐█·▐█.▪██ ▄▄██▀▐█▐▀▀▪▄▄▀▀▀█▄▐█▀▀█▄▐▀▀▄ ▐▀▀▪▄██▪▐█▐▐▌
▐█▌██▐█▌▐█▌▐█▌·▐███▌██▌▐▀▐█▄▄▌▐█▄▪▐███▄▪▐█▐█•█▌▐█▄▄▌▐█▌██▐█▌
 ▀▀▀▀ ▀▪▀▀▀▀▀▀ ·▀▀▀ ▀▀▀ · ▀▀▀  ▀▀▀▀ ·▀▀▀▀ .▀  ▀ ▀▀▀  ▀▀▀▀ ▀▪

Cauldron born.

https://github.com/globz/witchesbrew

EOF
echo "witchesbrew is now installed."
