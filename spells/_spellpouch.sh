#!/bin/bash

_spellpouch()
{
    local OPTIND opt _pouch wb=$(readlink -f $HOME/bin/witchesbrew_wd)

    while getopts ":p:w:s:e" opt; do
        case "${opt}" in
            p)
                local pouch="${OPTARG}"
                echo "_spellpouch: [${pouch}]"
                ;;
            w)
                local external_grimoire="${OPTARG}"
                echo "casting from external grimoire: [${external_grimoire}]"
                ;;
            s)
                local spell="${OPTARG}"
                echo "casting spell: [${spell}]"
                ;;
            e)
                shift $((OPTIND -1))
                local env="${@}"
                echo "casting with external environment: [${env}]"
                ;;
            \?)
                echo "Invalid Option: -$OPTARG" 1>&2
                ;;
            :)
                echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                ;;
        esac
    done
    
    # invoke from witchesbrew/spells or external grimoire
    if [[ -z $external_grimoire && ! -z $pouch ]]
    then
        _pouch=$(<"${wb}/spells/${pouch}.sh")
    elif [[ ! -z $external_grimoire && ! -z $pouch ]]
    then
        _pouch=$(<"${external_grimoire}/${pouch}.sh")
    fi
    
    # invoke from pouch or spell
    if [[ -z $spell && ! -z $_pouch ]]
    then
        bash -c "$_pouch; $pouch $env"

    elif [[ ! -z $spell && ! -z $_pouch ]]
    then
        bash -c "$_pouch; $spell $env"
    fi

    if [ ! ${?} -eq 0 ]
    then
        if [ "${pouch}" == "is_wd" ]
        then
            echo -e "\033[31mfizzled :\e[0m _spellpouch fell on the ground..." && return 1
        else
            echo -e "\033[31mfizzled :\e[0m _spellpouch failed to cast $pouch, $spell" && return 1
        fi
    fi
    
}
