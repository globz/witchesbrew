#!/bin/bash

is_wd()
{
    local wd=$1
    
    if ! test -f "${wd}/.witchesbrew"; then
        echo -e "\033[31merror :\e[0m witchesbrew must be invoked from the root of your grimoire directory"
        exit 1
    fi
}
