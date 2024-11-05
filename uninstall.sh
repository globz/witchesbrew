#!/bin/bash

set -e

witchesbrew_do_uninstall() {

    echo "Uninstalling witchesbrew"

    # Remove witchesbrew from $HOME/.local/bin/
    if [ -f "$HOME/.local/bin/witchesbrew" ];
    then
        echo 'Removing $HOME/.local/bin/witchesbrew' && rm $HOME/.local/bin/witchesbrew
    else
        echo 'Skipping removing $HOME/.local/bin/witchesbrew, does not exist.'
    fi

    if [ -L "$HOME/.local/bin/witchesbrew_wd" ];
    then
        echo 'Removing $HOME/.local/bin/witchesbrew_wd' && rm $HOME/.local/bin/witchesbrew_wd
    else
        echo 'Skipping removing $HOME/.local/bin/witchesbrew_wd, does not exist.'
    fi

    # Remove bash_completion from ~/.profile
    if grep -Fq '\. "$HOME/.local/bin/witchesbrew_wd/witchesbrew_completion.sh"' ~/.profile
    then
        echo "Removing bash_completion from ~/profile" && sed -e 's|\\. "$HOME/.local/bin/witchesbrew_wd/witchesbrew_completion.sh"||g' -i ~/.profile
    else
        echo "Skipping removing bash_completion from ~/.profile, does not exist."
    fi

    echo "Operation complete."

}

witchesbrew_do_uninstall
