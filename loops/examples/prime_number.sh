# author: Eswar Krishna Maganti
# email: maganti.ek@gmail.com
# problem statement: Find wheter the given number is prime number or not
# input: 7
# output: 7 is a prime number


#! /bin/bash

read -p "Enter a number: " num

flag=false

for (( i=2; i < $num; i++ ))
do
  if  [ $((num % i)) == 0 ];
  then
    flag=true
    break
  fi
done

if [ $flag == true ];
then
  echo $num is not a prime number
else
  echo $num is a prime number
fi


#(base) eswarmaganti~$bash prime_number.sh
#Enter a number: 7
#7 is a prime number
#(base) eswarmaganti~$bash prime_number.sh
#Enter a number: 123
#123 is not a prime number
#(base) eswarmaganti~$bash prime_number.sh
#Enter a number: 8
#8 is not a prime number
