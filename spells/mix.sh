#!/bin/bash

# mix by default will look for /reagents/ @ user grimoire ($wd)
# mix will enforce shell script execution and function name must use underscore
# over dashes
mix()
{

    local reagent=$1 wd=$2 env=$3 r_src src_sh src
    local wb=$(readlink -f $HOME/bin/witchesbrew_wd)

    source "${wb}/spells/_spellpouch.sh"

    # Find the reagent source code
    r_src=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "REAGENT" "${reagent}" "source")

    # Enforce shell script execution and underscores over dashes
    src_sh=$(echo "${r_src}" | gawk '/\.sh$/ { print }')
    if [[ ! -z "${src_sh}" ]]; then
        src=$(echo "${src_sh}" | gawk '/\.sh$/ { sub(/\.sh$/, "") } { print }' | tr '-' '_')
        _spellpouch -p "${src}" -w "${wd}/reagents/${reagent}" -e "${env}"
    else
        echo -e "\033[31merror :\e[0m Use option (-w) if you need an escape hatch!" && return 1
    fi

}

# mix external has a more lax attitude and does not enforce the sole use of
# shell script, user must provide the working directory (-w) of the external grimoire
mix_external()
{

    local reagent=$1 wd=$2 env=$3

    echo "mix_external"
    echo "${reagent}"
    echo "${wd}"
    echo "${env}"

}
