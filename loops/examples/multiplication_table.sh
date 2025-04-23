# author: Eswar Krishna Maganti
# email: maganti.ek@gmail.com
# problem statement: display the multiplication table of a given number
# input: Enter a number: 5
# output: 5*1=5,5*2=10,....

#! /bin/bash

read -p "Enter a number: " num

for (( i=1; i<=10; i++ ))
do
  echo "$num * $i = $(($num*$i))"
done

# output:
#(base) eswarmaganti~$bash multiplication_table.sh
#Enter a number: 5
#5 * 1 = 5
#5 * 2 = 10
#5 * 3 = 15
#5 * 4 = 20
#5 * 5 = 25
#5 * 6 = 30
#5 * 7 = 35
#5 * 8 = 40
#5 * 9 = 45
#5 * 10 = 50
