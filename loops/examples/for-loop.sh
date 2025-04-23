#! /bin/bash

# a simple for loop
echo "For loop using expression"
for i in {1..10};
do
  echo $i
done

# for loop using a condition
echo -n "Enter a number: "
read num

echo "For loop using condition"
for (( i=0; i<=$num; i++ ))
do
  echo $i
done

# for loop using sequence
echo "For loop using sequence"
for i in `seq $num`
do
  echo $i
done