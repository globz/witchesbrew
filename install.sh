#!/bin/bash

set -e

if [ $(readlink /proc/$$/exe)  != "/usr/bin/bash" ]; then echo "Please run this script with bash"; exit; fi

witchesbrew_do_install() {
echo "Installing witchesbrew..."


if [ -f "$HOME/bin/witchesbrew" ];
then
    echo "Aborting. You should first uninstall witchesbrew."
    return 1
fi

if [ -L "$HOME/bin/witchesbrew_wd" ];
then
    echo "Aborting. You should first uninstall witchesbrew."
    return 1
fi

# gawk requirement
_gawk=$( command -v gawk )
if [ -z "${_gawk}" ];
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

# bash_completion
if ! grep -Fq '\. "$HOME/bin/witchesbrew_wd/witchesbrew_completion.sh"' ~/.profile
then
    cat<<"EOF" >> ~/.profile
\. "$HOME/bin/witchesbrew_wd/witchesbrew_completion.sh"
EOF
else
    echo "bash_completion for witchesbrew is already present"
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
echo -e "\nClose and reopen your terminal to start using witchesbrew"

}

witchesbrew_do_install
