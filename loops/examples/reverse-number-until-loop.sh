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
