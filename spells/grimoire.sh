#!/bin/bash

grimoire()
{

    local wd=$1
    local wb=$2
    
    read -p 'witchesbrew is about to claim this directory and turn it into a grimoire, are you sure? (y/n) ' confirm

    case $confirm in  
        y|Y)

            # create reagents & recipes directory
            mkdir "${wd}/reagents"
            mkdir "${wd}/recipes"

            # create spells directory
            mkdir "${wd}/spells"

            # push template for (.witchesbrew)
            cp -f -i "${wb}/meta/.witchesbrew" "${wd}/.witchesbrew"
            # push source code (.witchesbrew.env.sh)
            cp -f -i "${wb}/meta/.witchesbrew.env.sh" "${wd}/.witchesbrew.env.sh"
            # push source code (spellpouch.sh)
            cp -f -i "${wb}/meta/spellpouch.sh" "${wd}/spells/spellpouch.sh"
            # push source code (elementIn.sh)
            cp -f -i "${wb}/meta/elementIn.sh" "${wd}/spells/elementIn.sh"
            # push source code (dialog_prompt.sh)
            cp -f -i "${wb}/meta/dialog_prompt.sh" "${wd}/spells/dialog_prompt.sh"
            
            echo "witchesbrew have now claim this directory and made it into a grimoire!" && ls -a
            ;; 
        n|N) echo -e "\nAborting." ;; 
        *) echo "this is confusing..." ;; 
    esac
          
}
