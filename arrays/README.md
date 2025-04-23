# Arrays

- An array is a variable containing multiple values may be of same type or of different type. There is no maximum limit to the size of an array, nor any requirement that member variable be indexed or assigned contiguously.

## Declaring an Array and assigning values
- In bash array is created automatically when a variable is used in format as below
  - `name[index]=value`
- We can declare an array explicitly using `declare -a <arrayname>`.

```
#! /bin/bash

unix[0]='Debian'
unix[1]='Red Hat'
unix[2]='Ubuntu'
unix[3]='Suse'

echo ${unix[2]}
```
Output:
- `Ubuntu`

## Initializing an array

- Instead of initializing an each element of an array separately, you can declare and initialize an array by specifying the list of elements separated by white spaces with parenthesis.
- Syntax:
  - `declare -a arrayname=(element1 element2 element3)`
- If the elements have white spaces, then enclose them with quotes.
  ```
  #! /bin/bash
  
  declare -a unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse')
  ```

## Print the whole bash array
- There are different ways to print the whole bash array. If the index number is @ or *, all members of an array are referenced.
- We can traverse through the array elements and print it, using looping statements in bash.
```
#! /bin/bash
  
declare -a unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse')

echo Array Elements: ${unix[@]}
echo Array Elements: ${unix[*]}
```
- Output:
  ```Array Elements: Debian Red Hat Ubuntu Suse
    Array Elements: Debian Red Hat Ubuntu Suse
  ```

## Length of the bash array
- We can find the length of the bash array using special parameter called `$#`.
- `${#arrayname[@]}` will give the length of the array.
  ```
  #! /bin/bash
    
  declare -a unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse')
  
  echo "Array Length: ${#unix[@]}"
  ```
- Output: `Array Length: 4`

## Extraction by offset and length of an array
- We can use the syntax `${arrayname[@]:<start>,length}` to extract a specified number of elements starting from an index in an array.
  ```
  #! /bin/bash
    
  declare -a unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse')
  
  ${unix[@]:1:3}
  ```
- Output: `Red Hat Ubuntu Suse`

## Extract with offset and length, for a particular element of an array
- To extract only specific characters from an array element, we can use the syntax `${arrayname[<element_index>]:start:end}`

  ```
   #! /bin/bash
      
    declare -a unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse')
    echo ${unix[2]:0:3}
  ```
- Output: `Red`

## Search and replace in array elements
- We can use the following syntax to search an element and replace it with other `${arrayname[@]/<search_element>/<new_element>}`
```
#! /bin/bash
unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse' 'Fedora')

echo ${unix[@]/Ubuntu/SCO Unix}
```
- Output: `Debian Red Hat Ubuntu Suse Fedora`

## Add an element to an existing BASH Array
- We can extend the elements of one bash array and create a new bash array as shown below
  ```
  #! /bin/bash
  
  unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse' 'Fedora')
  os=("${unix[@]}" "Windows" "Mac")
  echo ${os[@]}
  ```
- Output: `Debian Red Hat Ubuntu Suse Fedora Windows Mac

## Removing an element from a bash array
- `unset` is used to remove an element from an array. unset will have same effect of assigning null to an element
  ```
  #! /bin/bash
  
  unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse' 'Fedora')
  unset unix[1]
  echo ${unix[@]}
  ```
- Output: `Debian Ubuntu Suse Fedora`
- We can also use slicing to remove an element and create a new array
  ```
  #! /bin/bash
  
  unix=('Debian' 'Red Hat' 'Ubuntu' 'Suse' 'Fedora')
  unix=(${unix[@]:0:$pos} ${unix[@]:$(($pos+1))})
  echo ${unix[@]}
  ```
- Output: `Debian Ubuntu Suse Fedora`
