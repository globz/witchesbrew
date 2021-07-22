#!/bin/bash

list_grimoire()
{
    
    local target=$1 wd=$2

    case "${target}" in
        REAGENTS)
            gawk '/^\[REAGENT\]$/,/\// { print "\033[35m"$0 }' "${wd}/.witchesbrew" && return
            ;;
        RECIPES)
            gawk '/^\[RECIPE\]$/,/\// { print "\033[35m"$0 }' "${wd}/.witchesbrew" && return
            ;;
    esac
    
}
