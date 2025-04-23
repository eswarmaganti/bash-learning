#! /bin/bash

# read a number from prompt and print all even and odd numbers till that number

# reading a number
read -p "Enter a number: " num

for (( i=1; i <= $num; i++ )) do
  if [ $((i % 2)) == 0 ]; then
    echo Even Number: $i
  elif [ $((i % 2)) != 0 ]; then
    echo Odd Number: $i
  fi
done

# output
#/bin/bash /Users/eswarmaganti/Developer/Learning/bash-learning/loops/even_odd.sh
#Enter a number: 10
#Odd Number: 1
#Even Number: 2
#Odd Number: 3
#Even Number: 4
#Odd Number: 5
#Even Number: 6
#Odd Number: 7
#Even Number: 8
#Odd Number: 9
#Even Number: 10
