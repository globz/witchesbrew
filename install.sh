#!/bin/bash

set -e

if [ $(readlink /proc/$$/exe)  != "/usr/bin/bash" ]; then echo "Please run this script with bash"; exit; fi

witchesbrew_do_install() {
echo "Installing witchesbrew..."


if [ -f "$HOME/.local/bin/witchesbrew" ];
then
    echo "Aborting. You should first uninstall witchesbrew."
    return 1
fi

if [ -L "$HOME/.local/bin/witchesbrew_wd" ];
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

# bash_completion
if ! grep -Fq '\. "$HOME/.local/bin/witchesbrew_wd/witchesbrew_completion.sh"' ~/.profile
then
    cat<<"EOF" >> ~/.profile
\. "$HOME/.local/bin/witchesbrew_wd/witchesbrew_completion.sh"
EOF
else
    echo "bash_completion for witchesbrew is already present"
fi

# Create $HOME/.local/bin if it does not already exist
if [ -d "$HOME/.local/bin" ];
then
    echo "Skipping creation of directory $HOME/.local/bin since it already exists."
else
    echo "Creating Directory $HOME/.local/bin" && mkdir $HOME/.local/bin
fi

cat<<"EOF" >> "$HOME/.local/bin/witchesbrew"
function repl() {
    local wd=$(readlink -f $HOME/.local/bin/witchesbrew_wd)

    . $wd/cauldron.sh
    cauldron "$@"
}
repl "$@"
EOF

chmod u+x $HOME/.local/bin/witchesbrew
ln -sf "$(pwd)" $HOME/.local/bin/witchesbrew_wd

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
