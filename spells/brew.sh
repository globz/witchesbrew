#!/bin/bash

# brew look for /reagents/ @ user grimoire ($wd)
# brew enforce shell script execution 
# brew enforce function name to use underscore over dashes
brew()
{

    local all_args=("$@") recipe=$1 wd=$2 env=$3 rest_args=("${all_args[@]:3}") r_src src_sh src
    local wb=$(readlink -f $HOME/.local/bin/witchesbrew_wd)

    source "${wb}/spells/_spellpouch.sh"

    # Find the recipe source code
    r_src=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "RECIPE" "${recipe}" "source")

    # Enforce shell script execution and underscores over dashes
    src_sh=$(echo "${r_src}" | gawk '/\.sh$/ { print }')
    if [[ ! -z "${src_sh}" ]]; then
        src=$(echo "${src_sh}" | gawk '/\.sh$/ { sub(/\.sh$/, "") } { print }' | tr '-' '_')
        _spellpouch -p "${src}" -w "${wd}/recipes/${recipe}" -e "${env}" "${rest_args[@]}"
    else
        echo -e "\033[31merror :\e[0m Could not brew requested recipe!" && return 1
    fi

}
