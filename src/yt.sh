#!/bin/sh
while true; do
  if [ $1 = "q" ]; then
      return
  fi
  query="'$*'"  
  isFound=0
  url=""
  output="$(ddgr -x --np --unsafe site:youtube.com/watch $query)\n"
  clear
  echo "$output"
  echo -ne "Input # or search term (q to quit): "
  read term
  echo "$output" | while read line || [[ -n $line ]];
  do
      if [ $isFound -eq 1 ]; then
          url=$line
          break
      fi
      if [[ $line == *$term". "* ]]; then
          isFound=1
      fi
  done
  if [ $isFound = 0 ]; then
    set -- $term
  else
      mpv $url
    set -- $query
  fi 
done