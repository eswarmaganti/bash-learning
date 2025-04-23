# author: Eswar Krishna Maganti
# email: maganti.ek@gmail.com
# problem statement: display the first n terms in  fibanocci series
# input: 5
# output: 0,1,1,2,3

#! /bin/bash

read -p "Enter a number: " num
fp=0
fn=1

echo $fp
echo $fn
for (( i=0 ; i < $num-2; i++ ))
do
  f=$((fp+fn))
  echo  $f
  fp=fn
  fn=f
done