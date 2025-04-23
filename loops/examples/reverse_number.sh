# author: Eswar Krishna Maganti
# email: maganti.ek@gmail.com
# problem statement: bash script to find the reverse of a given number
# input: 123
# output: 321


#! /bin/bash

read -p "Enter a number: " num

temp=$num
reverse=0

while [ $num != 0 ];
do
  last=$((num%10))
  reverse=$((reverse*10 + last))
  num=$((num/10))
done

echo The reverse of $temp is $reverse

#(base) eswarmaganti~$./reverse_number.sh
#Enter a number: 123
#The reverse of 123 is 321
#(base) eswarmaganti~$./reverse_number.sh
#Enter a number: 123321
#The reverse of 123321 is 123321
