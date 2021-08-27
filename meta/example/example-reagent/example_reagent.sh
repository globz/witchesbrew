#!/bin/bash

example_reagent()
{

  local env=$1
  local wd=$(pwd)

  echo "Hello from example_reagent with ENV: ${env}"

  # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"

  # Making use of spell dialog_prompt
  spellpouch -p "dialog_prompt" -e "This is a dialog prompt, press any key to continue..."
  
  # Making use of spellpouch, invoking example_pouch with spell example_spell_1
  # (external function #1)
  spellpouch -p "example_pouch" -s "example_spell_1" -e "example_reagent_arg1" "example_reagent_arg2" "example_reagent_arg3"

  # Making use of spellpouch, invoking example_pouch with spell example_spell_2
  # (external function #2)
  spellpouch -p "example_pouch" -s "example_spell_2" -e "example_reagent_arg1" "example_reagent_arg2" "example_reagent_arg3"

  # Making use of spellpouch, invoking example_standalone_pouch (single external function)
  spellpouch -p "example_standalone_pouch" -e "example_reagent_arg1" "example_reagent_arg2" "example_reagent_arg3"

}
