#!/bin/bash

validate_env() {

    # define your host environment
    local valid_env=("DEV" "PROD")
    local wd=$(pwd)
    local env=$1
    
    # =spellpouch=
    source "${wd}/spells/spellpouch.sh"
    
    if ! spellpouch -p "elementIn" -e "${env}" "${valid_env[@]}"
    then
        echo -e "\033[33mInvalid ENV :\e[0m expected values are one of the following : ${valid_env[@]}"
        exit 1
    fi

    # Add your own validation steps...

}
