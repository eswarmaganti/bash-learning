# Input & Output in BASH Scripting

## `read` command
- `read` is a build-in command that reads a line from standard input (or from the file descriptor) and splits the line into words.the first word is assigned to first name, the second one is assigned to second name and so on.
- The general syntax of `read` command is as follows
  - `read [options] [name..]`
- The following options are supported with read command.
  - `-p`: reads the input from the output of a process run by the korn shell using |& (pipe, ampersand). will prompt a string provided.
  - `-s`: does not echo the user's input. used for reading sensitive information
  - `-a <array>`: Assigns the provided word sequence to a variable named `<array>`.
  - `-e`: Starts an interactive shell session to obtain the line to read.
  - `-d <delimiter>`: Reads the line until the provided `<delimiter>` instead of new line.
  - `-i <prefix>`: Adds initial text before reading a line as prefix
  - `-n <number>`: Returns after reading the specified number of characters while honoring the delimiter to terminate early.
  - `-N <number>`: Returns after reading the specified number of characters, ignoring the delimiter.
  - `-r`: Disables the backslash to escape characters.
  - `-t <seconds>`: Timeout after the specified time in seconds
  - `-u <file descritor>`: Reads file descriptor instead of standard input.

```
# reading a string
read -p "Enter your Name: " name
Enter your Name: Eswar

echo $name
Eswar
```
```
# reading password data
read -sp "Enter your password: " password
Enter your password: 

echo $password
Kittu123
```

```
# read command with out any options
read message
Hello All

echo $message
Hello All
```

```
# reading multiple variables
read fname lname
Eswar Maganti

echo $fname $lname
Eswar Maganti

# if we pass more values than variables mentioned in read command, the variables are assigned by values delimited by space, the last variable will be assigned with the remaiing leftout value.

echo $fname $lname
Maganti Eswar Krishna

echo First Name: $fname Last Name: $lname
First Name: Maganti Last Name: Eswar Krishna
```

- We can pass input to a read command using heredoc
```
read name <<< "Eswar Krishna Maganti"
echo $name
Eswar Krishna Maganti
```
- Delimiter
  - By default the newline will be the delimiter to the read command. we can pass a custom delimiter using below approach
  ```
  read -d ',' name
  Eswar,
  echo $name
  Eswar
  ```
- Delimiter for splitting words, The variable `$IFS` stores the default delimiter. The default value for splitting words is space, we can change the default behavior by setting the `$IFS` value to a different value.
    ```
    read fname lname <<< "Eswar Maganti"
    echo $fname $lname
    Eswar Maganti
    
    # custom delimiter
    IFS=','
    read fname lname <<< "Eswar,Maganti"
    echo $fname $lname
    Eswar Maganti

    # multiple delimitors
    IFS=',-'
    read v1 v2 v3 <<< "Hello,World-Everyone:)"
    
    echo $v1
    Hello
    
    echo $v2
    World
    
    echo $v3
    Everyone:)
    ```
- Set character limit while reading input
    ```
    read -n 10 name <<< "Eswar Krishna Maganti"
    echo $name
    Eswar Kris
    
    read -n 10 name
    Eswar Kris
    echo $name
    Eswar Kris

    ```