#!/bin/bash

set -e

witchesbrew_do_uninstall() {

    echo "Uninstalling witchesbrew"

    # Remove witchesbrew from $HOME/bin/
    if [ -f "$HOME/bin/witchesbrew" ];
    then
        echo 'Removing $HOME/bin/witchesbrew' && rm $HOME/bin/witchesbrew
    else
        echo 'Skipping removing $HOME/bin/witchesbrew, does not exist.'
    fi

    if [ -L "$HOME/bin/witchesbrew_wd" ];
    then
        echo 'Removing $HOME/bin/witchesbrew_wd' && rm $HOME/bin/witchesbrew_wd
    else
        echo 'Skipping removing $HOME/bin/witchesbrew_wd, does not exist.'
    fi

    # Remove bash_completion from ~/.profile
    if grep -Fq '\. "$HOME/bin/witchesbrew_wd/witchesbrew_completion.sh"' ~/.profile
    then
        echo "Removing bash_completion from ~/profile" && sed -e 's|\\. "$HOME/bin/witchesbrew_wd/witchesbrew_completion.sh"||g' -i ~/.profile
    else
        echo "Skipping removing bash_completion from ~/.profile, does not exist."
    fi

    echo "Operation complete."

}

witchesbrew_do_uninstall
