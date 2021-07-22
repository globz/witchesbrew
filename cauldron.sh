#!/bin/bash

cauldron()
{
    
    local OPTIND opt
    local wd=$(pwd)
    local wb=$(readlink -f $HOME/bin/witchesbrew_wd)

    # =_spellpouch=
    source "${wb}/spells/_spellpouch.sh"
    
    while getopts ":h" opt; do
        case "${opt}" in
            h)
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
                echo "Usage:"
                echo "    witchesbrew -h                      Display this help message."
                echo "    witchesbrew grimoire                Instantiate a grimoire directory or display existing details."
                echo "    witchesbrew study [-g|r] <name>     Study target reagent(-g) or recipe(-r)."
                echo "    witchesbrew list [-g|r]             List available reagents(-g) or recipes(-r)."
                echo "    witchesbrew mix <reagent> -e <env>  Mix reagent with host environment."
                echo "    witchesbrew brew <recipe> -e <env>  Brew recipe with host environment."
                ;;
        esac
    done
    shift $((OPTIND -1))

    local command=$1; shift  # Remove 'witchesbrew' from the argument list

    case "$command" in
        # Invoke grimoire
        grimoire)
            if ! test -f "${wd}/.witchesbrew"; then
                _spellpouch -p "grimoire" -e "${wd}" "${wb}"
            else
                gawk '/GRIMOIRE/,/\// { print "\033[35m"$0 }' "${wd}/.witchesbrew" && return
            fi
            ;;
    esac

    case "$command" in
        # Parse options to the study command
        study)
            local name
            while getopts ":r:g:" opt; do
                case "${opt}" in
                    r)
                        name="${OPTARG}"
                        _spellpouch -p "study" -e "RECIPE" "${name}" "${wd}"
                        ;;
                    g)
                        name="${OPTARG}"
                        _spellpouch -p "study" -e "REAGENT" "${name}" "${wd}"
                        ;;
                     \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                    :)
                        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                        ;;
                esac
            done

            shift $((OPTIND -1))
            ;;
    esac

    case "$command" in
        # Parse options to the list command
        list)
            _spellpouch -p "is_wd" -e "${wd}" || return
            while getopts ":rg" opt; do
                case "${opt}" in
                    r)
                        _spellpouch -p "list_grimoire" -e "RECIPES" "${wd}"
                        ;;
                    g)
                        _spellpouch -p "list_grimoire" -e "REAGENTS" "${wd}"
                        ;;
                    \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                    :)
                        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                        ;;
                esac
            done

            shift $((OPTIND -1))
            ;;
    esac

    case "$command" in
        # Parse options to the mix command
        mix)
            _spellpouch -p "is_wd" -e "${wd}" || return
            local reagent=$1; shift
            while getopts "e:w:" opt; do
                case "${opt}" in
                    e)
                        local env="${OPTARG}"
                        _spellpouch -p ".witchesbrew.env" -s "validate_env" -w "${wd}/" || return
                        echo "mix environment: [${env}]"
                        ;;
                    w)
                        local external_directory="${OPTARG}"
                        ;;
                    \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                    :)
                        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                        ;;
                esac
            done

            # Invoke from mix or mix_external based on -w option
            if [[ ! -z "${external_directory}" ]]
            then
                _spellpouch -p "mix" -s "mix_external" -e "${reagent}" "${external_directory}" "${env}"
            else
                _spellpouch -p "mix" -e "${reagent}" "${wd}" "${env}"
            fi

            shift $((OPTIND -1))
            ;;
    esac

}
