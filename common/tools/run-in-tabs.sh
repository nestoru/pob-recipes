#!/bin/bash -e
# name: run-in-tabs.sh
# date: 20120921
# author: Nestor Urquiza

USAGE="Usage: `basename $0` <commandsFile>"

if [ $# -ne "1" ] 
then
  echo $USAGE
  exit 1 
fi

commandsFile=$1
old_IFS=$IFS
IFS=$'\n'
lines=($(cat $commandsFile)) # array
IFS=$old_IFS

runInTabsCommand="gnome-terminal"
for command in "${lines[@]}"
do
  if [[ $command =~ ^[^#].* ]]; then
    runInTabsCommand="$runInTabsCommand --tab -e \"$command\""
  fi
done
echo Running $runInTabsCommand
eval $runInTabsCommand

