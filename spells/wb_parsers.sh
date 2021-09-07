#!/bin/bash

# witchesbrew parsers
# @Supported files@
# .witchesbrew

# GAWK LEGEND ::
# NF = Number of fields inside a record
# $NF = The last field in a record can be represented by $NF.
# NR = It represents the number of the current record
# FS = It represents the (input) field separator and its default value is space
# FNR = It represents the number of the current record for the first file only
# RS = It represents (input) record separator and its default value is newline.
# RSTART = It represents the first position in the string matched by match function.
# RLENGTH = The length of the substring matched by the match()
# $0 = It represents the entire input record.
# $n = It represents the nth field in the current record where the fields are separated by FS.
# NR==1 {print} = print the first record

# The parsers below are meant to be called as follow :
# _spellpouch -p "wb_parsers" -s "function_name" -e "external_env"

# [category] => records_by_category => category_record(s)
# Return one ore more records based on a given category
records_by_category()
{
 
    local category=${1:-UNUSED} category_record

    category_record=$(gawk -v _category="$category" -F: '
    BEGIN { RS="\\[/\\]"; regex_c="\\["_category"\\]"; }
    $0 ~ regex_c { category[NR]; }
    NR in category' .witchesbrew)

    echo "${category_record}"
    
}

# :name: => records_by_name => named_record(s)
# Return one ore more records based on a given :name: value matched against the :name: field
records_by_name()
{

    local name=${1:-UNUSED} named_record

    named_record=$(gawk -v _name="$name" -F: 'BEGIN { RS="\\[/\\]"; regex_n=":name:\\n"_name"\\n"; };
    $0 ~ regex_n { name[NR]; } NR in name' .witchesbrew)
    
    echo  "${named_record}"

}

# :field: => records_by_field => field_record(s)
# Return one ore more records based on a given :field:
records_by_field()
{

    local field=${1:-UNUSED} field_record

    field_record=$(gawk -v _field="$field" -F: 'BEGIN { RS="\\[/\\]"; regex_f=":"_field":";}
    $0 ~ regex_f { field[NR]; } NR in field' .witchesbrew)

    echo "${field_record}"

}

# identifier => records_by_id => id_record(s)
# Return one ore more records based on a given identifier
records_by_id()
{

    local id=${1:-UNUSED} id_record

    id_record=$(gawk -v _id="$id" -F: 'BEGIN { RS="\\[/\\]"; regex_i=_id; };
    $0 ~ regex_i { id[NR]; } NR in id' .witchesbrew)

    echo  "${id_record}"

}

# category_record(s) => field_by_category => category_field_value
# Return one ore more field values based on a given category_record(s) & :field:
field_by_category_record()
{
    local category_record=${1:-UNUSED} field=${2:-UNUSED} category_field_value
    
    category_field_value=$(echo "${category_record}" | gawk -v _field="$field" -F: '
    BEGIN { regex_f=":"_field":"; } $0 ~ regex_f { getline; field[NR] } NR in field')

    echo  "${category_field_value}"
}

# named_record(s) => field_by_name => named_field
# Return one ore more fields value based on a given named_record(s) & :field:
field_by_named_record()
{
    local named_record=${1:-UNUSED} field=${2:-UNUSED} named_field_value
    
    named_field_value=$(echo "${named_record}" | gawk -v _field="$field" -F: '
    BEGIN { regex_f=":"_field":"; } $0 ~ regex_f { getline; field[NR] } NR in field')

    echo  "${named_field_value}"
}

# [category] && :name: && :field: => field_by_named_category => named_category_field_value
# Return one ore more field values based on a given [category], :name: & :field:
field_by_named_category()
{
    
    local category=${1:-UNUSED} name=${2:-UNUSED} field=${3:-UNUSED}
    local category_record=$(records_by_category "${category}")
    local named_record=$(records_by_name "${name}") 
    local named_field_value=$(field_by_named_record "${named_record}" "name") 
    local named_category_record="";
    local named_category_field_value="";
    
    named_category_record=$(echo "${category_record}" | gawk \
    -v _named_field_value="$named_field_value" -v _category="$category" -F: '
    BEGIN { RS="\\["_category"\\]"; regex_n_f=":name:\\n"_named_field_value"\\n"; } 
    { if ($0 ~ regex_n_f) { record[NR]; } } NR in record')

    named_category_field_value=$(field_by_named_record "${named_category_record}" "${field}")
    
    echo  "${named_category_field_value}"

}
