# Loops in BASH
- In BASH we have three different types of looping statements available 
  - `for`
  - `while`
  - `until`

## For loop in BASH
- There are two different styles for writing for loops
  - C-styled for loops
  - Using for loop on a list/range of items
### C-Styled for loops in BASH
- Syntax 
    ```
    for ((initialize ; condition ; increment / decrement )); do
    [Statements]
    done
    ```
- Example: Using the C-styled for loop to print out "Hello World" for 10 times
    ```
    bash-3.2$ for ((i=0 ; i<10; i++)); do
    > echo "Hello World"
    > done
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    Hello World
    ```
### List/Range for loops in BASH
- Another syntax variation of for loop also exists that is particularly useful if you are working with list of files (or strings), range of numbers, arrays, output of a command, etc.
- Synatx:
    ```
    for item in [LIST]; do
    [Statements]
    done
    ```
- Example: the following code will do the same thing as c-styled for loop in the above example
  ```
  bash-3.2$ for i in {1..10}; do echo "Hello World"
  > done
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  Hello World
  ```
- Example:  Looping over files in a directory
  ```
  bash-3.2$ for item in /var/*; do echo $item
  > done
  /var/MobileSoftwareUpdate
  /var/OOPJit
  /var/agentx
  /var/at
  /var/audit
  /var/backups
  /var/containers
  /var/db
  /var/dextcores
  /var/dirs_cleaner
  /var/empty
  /var/folders
  /var/install
  /var/jabberd
  /var/lib
  /var/log
  /var/logs
  /var/ma
  /var/mail
  /var/msgs
  /var/netboot
  /var/networkd
  /var/personalized_factory
  /var/protected
  /var/root
  /var/rpc
  /var/run
  /var/select
  /var/sntpd
  /var/spool
  /var/tmp
  /var/vm
  /var/yp
  ```

## While Loops in BASH
- While loop is another popular and intuitive loop you can use in bash scripts. The general syntax for a while loop in BASH is as follows
  ```
  while [condition]; do
  [Statements]
  done
  ```
- Example: The following example calculates the reverse of a number using while loop
  ```
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
  ```
- Output of above example
  ```
  (base) eswarmaganti~$./reverse_number.sh
  Enter a number: 123
  The reverse of 123 is 321
  (base) eswarmaganti~$./reverse_number.sh
  Enter a number: 123321
  The reverse of 123321 is 123321
  ```
  
## Until Loop in BASH
- In C/C++, we have do-while loop but that one doesn't exist in bash. There is another kind of loop that exists in bash. The until loop follows the same syntax as the while loop
  ```
  until [ condition ]; do
  [Statements]
  done
  ```
- The key difference between until loop and while loop is the test condition. A while loop will keep running as long as the test condition is true; on the flip side, the until loop keeps running as long as the test condition is false.
- The above reverse number example will look like below using until loop
```
  #! /bin/bash
  
  read -p "Enter a number: " num
  
  temp=$num
  reverse=0
  
  until [ $num == 0 ];
  do
    last=$((num%10))
    reverse=$((reverse*10 + last))
    num=$((num/10))
  done
  
  echo The reverse of $temp is $reverse
  ```

## More on Loops in BASH
### Print the contents of an Array
```
bash-3.2$ primes=(2 3 5 7 11 13 17 19 23 29)
bash-3.2$ for prime in ${primes[@]}; do 
> echo $prime
> done
2
3
5
7
11
13
17
19
23
29
bash-3.2$ 
```

### Using `break` and `continue` in BASH loops
- Sometimes you may want to exit a loop prematurely or skip a loop iteration. To do this, you can use the `break` and `continue` statements.
- Example:
  ```
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
  ```
- Output:-
  ```
  bash-3.2$ ./script.sh 
  Iteration: 0
  Iteration: 1
  Iteration: 2
  Iteration: 3
  Iteration: 4
  Skipping the current iteration using 'continue'
  Iteration: 6
  Breaking the loop using 'break'
  ```
  
