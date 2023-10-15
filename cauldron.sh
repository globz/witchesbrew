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
                echo "    witchesbrew example [-a|r]          Add(-a) or remove(-r) example files [REAGENT] & [RECIPE]."
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
        # Parse options to the example command
        example)
            while getopts ":ar" opt; do
                case "${opt}" in
                    a)
                        _spellpouch -p "example" -s "example_add" -e "${wd}" "${wb}"
                        ;;
                    r)
                        _spellpouch -p "example" -s "example_remove" -e "${wd}" "${wb}"
                        ;;
                     \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                esac
            done

            shift $((OPTIND -1))
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
            while getopts "e:" opt; do
                case "${opt}" in
                    e)
                        local env="${OPTARG}"
                        _spellpouch -p ".witchesbrew.env" -s "validate_env" -w "${wd}/" || return
                        echo "mix environment: [${env}]"
                        ;;
                    \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                    :)
                        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                        ;;
                esac
            done

            # Invoke mix with all the rest of the arguments which may have been
            # passed by the user & update optional fields
            : ${env:?Missing -e <env>}
            _spellpouch -p "mix" -e "${reagent}" "${wd}" "${env}" "${@:3}" && _spellpouch -p "opt_fields" -e "${reagent}" "REAGENT" "${wd}"

            shift $((OPTIND -1))
            ;;
    esac

    case "$command" in
        # Parse options to the brew command
        brew)
            _spellpouch -p "is_wd" -e "${wd}" || return
            local recipe=$1; shift
            while getopts "e:" opt; do
                case "${opt}" in
                    e)
                        local env="${OPTARG}"
                        _spellpouch -p ".witchesbrew.env" -s "validate_env" -w "${wd}/" || return
                        echo "brew environment: [${env}]"
                        ;;
                    \?)
                        echo "Invalid Option: -$OPTARG" 1>&2
                        ;;
                    :)
                        echo "Invalid Option: -$OPTARG requires an argument" 1>&2
                        ;;
                esac
            done

            # Invoke brew with all the rest of the arguments which may have been
            # passed by the user & update optional fields
            _spellpouch -p "brew" -e "${recipe}" "${wd}" "${env}" "${@:3}" && _spellpouch -p "opt_fields" -e "${recipe}" "RECIPE" "${wd}"
            : ${env:?Missing -e <env>}
            shift $((OPTIND -1))
            ;;
    esac

}
