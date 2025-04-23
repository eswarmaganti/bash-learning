# calculate the sum of all digits of a number
# input: 123
# output: 6

read -p "Enter a Number: " num
temp=$num

while [ $num != 0 ]; do
  last=$((num % 10))
  sum=$((sum+last))
  num=$((num/10))
done
echo The sum of all the digits of $temp is $sum

# Output
#./digit_sum.sh
#Enter a Number: 100
#The sum of all the digits of 100 is 1


#./digit_sum.sh
#Enter a Number: 123456789
#The sum of all the digits of 123456789 is 45
