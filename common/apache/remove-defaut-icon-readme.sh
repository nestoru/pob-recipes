#!/bin/bash -e
# common/apache/remove-defaut-icon-readme.sh

alias_file=/etc/apache2/mods-available/alias.conf 
alias_new_content=$(awk '!/from all/
     /<Directory.*/ {print "                Deny from all"}
' $alias_file)
echo "$alias_new_content" > $alias_file
