#/usr/bin/env bash

_witchesbrew_completion() {
    local cur prev prev2 prev3 opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    prev2="${COMP_WORDS[COMP_CWORD-2]}"
    prev3="${COMP_WORDS[COMP_CWORD-3]}"
    opts="-h grimoire example study list mix brew"  # Updated list of available options

    case "${prev}" in
        "witchesbrew")
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
            return 0
            ;;
        "example")

            COMPREPLY=($(compgen -W "-a -r" -- ${cur}))
            return 0
            ;;
        "study")
            COMPREPLY=($(compgen -W "-g -r" -- ${cur}))
            return 0
            ;;
        "list")
            COMPREPLY=($(compgen -W "-g -r" -- ${cur}))
            return 0
            ;;
        "mix")
            COMPREPLY=($(compgen -W "<reagent>" -- ${cur}))
            return 0
            ;;
        "brew")
            COMPREPLY=($(compgen -W "<recipe>" -- ${cur}))
            return 0
            ;;
    esac

    case "${prev2}" in
        "mix")
            COMPREPLY=($(compgen -W "-e" -- ${cur}))
            return 0
            ;;
        "brew")
            COMPREPLY=($(compgen -W "-e" -- ${cur}))
            return 0
            ;;
        "reagent")
            COMPREPLY=($(compgen -W "-e" -- ${cur}))
            return 0
            ;;
        "recipe")
            COMPREPLY=($(compgen -W "-e" -- ${cur}))
            return 0
            ;;
    esac

    case "${prev3}" in
        "mix")
            COMPREPLY=($(compgen -W "<env>" -- ${cur}))
            return 0
            ;;
        "brew")
            COMPREPLY=($(compgen -W "<env>" -- ${cur}))
            return 0
            ;;
        "reagent")
            COMPREPLY=($(compgen -W "<env>" -- ${cur}))
            return 0
            ;;
        "recipe")
            COMPREPLY=($(compgen -W "<env>" -- ${cur}))
            return 0
            ;;
    esac

}

complete -F _witchesbrew_completion witchesbrew
