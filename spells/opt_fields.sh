#!/bin/bash

# Populate & update optional fields for a given .witchesbrew section [REAGENT] or [RECIPE] 
# The following optional fields are currently supported, :installed: & :executed: 
opt_fields()
{

    local name=$1 type=$2 wd=$3 from_record to_record version
    local wb=$(readlink -f $HOME/bin/witchesbrew_wd)
    local datetime=$(date)
    
    source "${wb}/spells/_spellpouch.sh"

    # Find record & record version
    from_record=$(_spellpouch -p "wb_parsers" -s "records_by_name" -e "${name}")
    to_record=$(_spellpouch -p "wb_parsers" -s "records_by_name" -e "${name}")
    version=$(_spellpouch -p "wb_parsers" -s "field_by_named_category" -e "${type}" "${name}" "version")
    
    if grep -Fxq ":installed:" <<<$from_record
    then
        to_record=$(sed "/:installed:/{n;d}" <<< $to_record)
        to_record=$(sed "/:installed:/a $version @ $datetime" <<< $to_record)
    fi

    if grep -Fxq ":executed:" <<<$from_record
    then
        to_record=$(sed "/:executed:/{n;d}" <<< $to_record)
        to_record=$(sed "/:executed:/a $version @ $datetime" <<< $to_record)
    fi

    # Helper function (escapes for use in a regex)
    # original source @ https://stackoverflow.com/a/29613573/4975913
    # quoteRe <text>
    quoteRe() { sed -e 's/[^^]/[&]/g; s/\^/\\^/g; $!a\'$'\n''\\n' <<<"$1" | tr -d '\n'; }

    # Helper function (quotes for use in the substitution string of a s/// call)
    # original source @ https://stackoverflow.com/a/29613573/4975913
    # quoteSubst <text>
    quoteSubst() {
        IFS= read -d '' -r < <(sed -e ':a' -e '$!{N;ba' -e '}' -e 's/[&/\]/\\&/g; s/\n/\\&/g' <<<"$1")
        printf %s "${REPLY%$'\n'}"
    }


    # Apply substitution to .witchesbrew
    # Note the use of -e ':a' -e '$!{N;ba' -e '}' to read all input at once, so that the multi-line substitution works.
    sed -e ':a' -e '$!{N;ba' -e '}' -i -e "s/$(quoteRe "$from_record")/$(quoteSubst "$to_record")/" "${wd}/.witchesbrew"

}
