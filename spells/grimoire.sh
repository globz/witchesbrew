#!/bin/bash

grimoire()
{

    local wd=$1
    local wb=$2
    
    read -p 'witchesbrew is about to claim this directory and turn it into a grimoire, are you sure? (y/n) ' confirm

    case $confirm in  
        y|Y)
            # create configuration files
            touch "${wd}/.witchesbrew"           
            touch "${wd}/.witchesbrew.env.sh"    

            # create reagents & recipes directory
            mkdir "${wd}/reagents"
            mkdir "${wd}/recipes"

            # create spells directory
            mkdir "${wd}/spells"
            touch "${wd}/spells/spellpouch.sh"

            # push template for (.witchesbrew)
            cp "${wb}/meta/.witchesbrew" "${wd}/.witchesbrew"
            # push source code (.witchesbrew.env.sh)
            cp "${wb}/meta/.witchesbrew.env.sh" "${wd}/.witchesbrew.env.sh"
            # push source code (spellpouch.sh)
            cp "${wb}/meta/spellpouch.sh" "${wd}/spells/spellpouch.sh"
            # push source code (elementIn.sh)
            cp "${wb}/meta/elementIn.sh" "${wd}/spells/elementIn.sh"
            
            
            echo "witchesbrew have now claim this directory and made it into a grimoire!" && ls -a
            ;; 
        n|N) echo -e "\nAborting." ;; 
        *) echo "this is confusing..." ;; 
    esac
          
}
