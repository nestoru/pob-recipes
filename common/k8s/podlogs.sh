#!/bin/bash -ex
# podlogs.sh
# @description Tails all kubernetes logs for a given context (kubectl config view ).  
# @author Nestor Urquiza
# @date 20171016

# options
while [[ $# -gt 1 ]]; do
  key="$1"
  case $key in
    -c|--context)
      context="$2"
      shift
    ;;
    -r|--podNameRegex)
      podNameRegex="$2"
      shift
    ;;
    -l|--podLogPath)
      podLogPath="$2"
      shift
    ;;
    *)
      # unknown
    ;;
  esac
  shift
done

# functions
function fail() {
  echo $1
  echo $USAGE
  exit 1
}

# main
USAGE="Usage:  `basename $0` (-c, --context) (from 'kubectl config view') [(-r, --podNameRegex) (defaults to all)] [(-l, --podLogPath) (defaults to pod stdout)]"

if [ "$context" == "" ]; then
  fail "Context is mandatory. Find available contexts by running 'kubectl config view'"
fi

if [ "$podNameRegex" == "" ]; then
  podNameRegex=.
fi

kubectl config use-context $context
command="cat <("
for line in $(kubectl get pods | \
    grep "$podNameRegex" | grep Running | awk '{print $1}'); do 
      if [ "$podLogPath" == "" ]; then
        command="$command (kubectl logs --tail=2 -f $line &) && "
      else
        command="$command (kubectl exec -ti $line -- tail -2f $podLogPath &) && "
      fi
done
command="$command echo)"
eval $command
