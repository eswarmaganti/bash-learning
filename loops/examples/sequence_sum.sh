#! /bin/bash

# read a comma seperated values into an array and calculate the sum of all the elements of array

# Input: 1,2,3,4,5
# output: 15

values=()
printf "Enter comma seperated values: "
IFS=','
read -a values


sum=0
for val in ${values[@]}; do
  sum=$(($sum + val))
done

echo The sum of all the numbers is $sum