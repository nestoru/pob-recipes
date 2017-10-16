#!/bin/bash -e
# podlogs.sh
# @description Tails all kubernetes logs for a given context
#              Available contexts can be found by running 'kubectl config view'.  
# @author Nestor Urquiza
# @date 20171016

# main
USAGE="Usage: `basename $0` <context>"
if [ $# -ne "1" ]; then
  echo $USAGE
  exit 1
fi

context=$1

kubectl config use-context $context
command="cat <("
for line in $(kubectl get pods | \
  grep nodejs | grep Running | awk '{print $1}'); do 
    command="$command (kubectl logs --tail=2 -f $line &) && "
  done
command="$command echo)"
eval $command
