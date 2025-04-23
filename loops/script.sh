#! /bin/bash

for (( i=0; i<10; i++ )); do
  if (( i==5 )); then
    echo "Skipping the current iteration using 'continue'"
    continue
  elif (( i==7 )); then
    echo "Breaking the loop using 'break'"
    break
  fi
  echo "Iteration: $i"
done


