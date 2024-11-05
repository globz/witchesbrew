#!/bin/bash

study()
{

    local type=$1 name=$2 wd=$3 r_src src_sh src version description path
    local wb=$(readlink -f $HOME/.local/bin/witchesbrew_wd)

    source "${wb}/spells/_spellpouch.sh"

    # Find the reagent||recipe version, description and source code
    case "${type}" in
        REAGENT)
            version=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "REAGENT" "${name}" "version")
            description=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "REAGENT" "${name}" "description")
            src=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "REAGENT" "${name}" "source")
            path="${wd}/reagents/${name}"
            ;;
        RECIPE)
            version=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "RECIPE" "${name}" "version")
            description=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "RECIPE" "${name}" "description")
            src=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "RECIPE" "${name}" "source")
            path="${wd}/recipes/${name}"
            ;;
    esac
        
    # Enforce shell script execution and underscores over dashes
    src_sh=$(echo "${src}" | gawk '/\.sh$/ { print }')
    if [[ ! -z "${src_sh}" ]]; then
        echo -e "\033[35mVersion :\e[0m ${version}"
        echo -e "\033[35mDescription :\e[0m ${description}"
        echo -e "\033[35mSource :\e[0m" && cat "${path}/${src_sh}"
    else
        echo -e "\033[31merror :\e[0m something went wrong!" && return 1
    fi
    
}
