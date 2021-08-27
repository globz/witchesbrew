#!/bin/bash

example_add()
{

    local wd=$1
    local wb=$2
    
    read -p 'Would you like to add example files for [REAGENT] & [RECIPE]? (y/n) ' confirm_example_files

    case $confirm_example_files in  
        y|Y)

            # push example test-reagent
            cp -R -f -i "${wb}/meta/example/example-reagent" "${wd}/reagents/"

            # push example test-recipe
            cp -R -f -i "${wb}/meta/example/example-recipe" "${wd}/recipes/"

            # push example test_pouch
            cp -f -i "${wb}/meta/example/example_pouch.sh" "${wd}/spells/"            

            # push example test_standalone_pouch
            cp -f -i "${wb}/meta/example/example_standalone_pouch.sh" "${wd}/spells/"                        
            
            echo -e "Example files added.\n"
            echo -e "You may now invoke example-reagent with '\033[35mwitchesbrew mix example-reagent -e <env>\e[0m'\n"
            echo -e "You may now invoke example-recipe with '\033[35mwitchesbrew brew example-recipe -e <env>\e[0m'\n"
            echo -e "Example files can be removed with '\033[35mwitchesbrew example -r\e[0m'\n"
            ;; 

        n|N) echo -e "\nSkipping example files."
             echo -e "Example files may be added with '\033[35mwitchesbrew example -a\e[0m'" 
             ;; 
        *) echo "this is confusing..." ;; 
    esac
          
}

example_remove()
{

    local wd=$1
    local wb=$2
    
    read -p 'Would you like to remove example files for [REAGENT] & [RECIPE]? (y/n) ' confirm_example_files

    case $confirm_example_files in  
        y|Y)

            # remove example test-reagent
            rm -rf "${wd}/reagents/example-reagent/"

            # remove example test-recipe
            rm -rf "${wd}/recipes/example-recipe/"

            # remove example test_pouch
            rm "${wd}/spells/example_pouch.sh"

            # remove example test_standalone_pouch
            rm "${wd}/spells/example_standalone_pouch.sh"
            
            echo -e "Example files removed.\n"
            echo -e "Example files can be added with '\033[35mwitchesbrew example -a\e[0m'\n"
            ;; 

        n|N) echo -e "\nAborting removal of example files."
             ;; 
        *) echo "this is confusing..." ;; 
    esac
          
}
