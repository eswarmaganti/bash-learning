# BASH Fucntions

- A BASH function is essentially a set of commands that ca be called numerous times. The purpose of a function is to help you make your bash scripts more readable and to avoid writing three same code repeatedly.

## Defining BASH Functions

- The syntax for declaring bash function is straight forward. Functions may be declared in two ways
    1. The function starts with a function name, followed by parenthesis. This is preferred and most used format. 

        ```
        function_name (){
            // commands
        }
        ```

        Single line version  
        ```
        function_name() { //Commands; }
        ```

    2. The second format starts with the reserved word `function`, followed by the function name.
    
        ```
        function function_name(){
            //commands
        }
        ```
    Single Line Version
        ```
        function function_name { commands; }
        ```
- Few points to be noted:
  - THe commands between the curly braces ( {} ) are called the body of the function. The curly braces must be separated from the body by spaces or newlines.
    - Defining a function doesn't execute it. To invoke a bash function, simply use the function name. Commands between the curly braces are executed whenever the function is called in the shell script.
  - Function Definition must be placed before any calls to the function
  - When using single line `compacted` functions, a semicolon `;` must follow the last command in the function.
- Example function code in BASH

    ```
    #! /bin/bash

    # function definition
    welcome(){
        echo "Welcome!! to the world of BASH"
    }

    # function call
    welcome
    ```

## VAriables Scope

- Global variables are variables that can be accessed from anywhere in the script regardless of the scope. in BAASH, all variables by default are defined as global, even if declared inside the function.
- Local variable can be declared within the function body with the `local` keyword and can be used only inside that function. YOu can have local variables with the same name in different functions.
- Example

```
#! /bin/bash

var1='A'
var2='B'

my_function(){
    local var1='C'
    var2='D'
    echo 'Inside the $1: var1:$var1, var2:$var2'
}

echo "Before Function call: var1:$var1, var2:$var2

#function call
my_function

echo "Before Function call: var1:$var1, var2:$var2
```

- Output of the above script

```
Before Function call: var1:A, var2:B
Inside the ./scripts/variable-scope.sh : var1:$var1, var2:$var2
Before Function call: var1:A, var2:D
```

- From the above output, we can conclude that:
  - When a local variable is set inside the function body with the same name as an existing global variable, it will have precedence over the global variable.
  - Global variable can be changed from within the function.

## Return Values

- Unlike the functions in the real programming languages, BASH functions doesn't allow you to return a value when called.
- When a BASH function completed, its return value is the status of the last statement executed in the function, `0` for success and non-zero decimal in the 1-255 range for failure.
- The return status can be specified by using the return keyword, and it is assigned to the variable `$?`. The `return` statement terminates the function. YOu can think og it as the function's exit status. 
- Example

    ```
    #! /bin/bash

    my_function(){
        echo "Function Started"
        echo "Function Executed"
        return 1
    }

    my_function

    echo $?
    ```

- Output: 
    
    ```
    Function Started
    Function Executed
    1
    ```

- To actually return an arbitrary value from a function, we need to use other methods. The simplest option is to assign the result of the function to a global variable.

    ```
    #! /bin/bash

    my_function(){
        echo "Function Started"
        echo "Function Executed"
        result="Function:my_function"
    }

    my_function

    echo $result
    ```

- Another, better option to return a value from a function is to send the value to `stdout` using `echo` or `printf` as shown below

    ```
    #! /bin/bash

    my_function(){
        
        local result="Function:my_function"
        echo $result
    }

    result=$(my_function)

    echo $result
    ```

## Passing arguments to BASH Functions

- To pass any number of arguments to the bash function simply put them right after the function's name, separated by a space.
- It is a good practice to double-quote the arguments to avoid the misparsing of an argument with spaces in it.
  - THe passed arguments are `$1`, `$2`, `$3`, ... `$n`, corresponding to the position of the parameter after the function's name.
  - The `$0` variable is reserved for the function name.
  - The `$#` variable holds the number of positional parameters/arguments passed to the function.
  - The `$*` and `$@` variables hold all positional parameters/arguments passed to the function.
    - When double-quoted, `"$*"` expands to a single string separated by space - `"$1 $2 .. $n"`.
    - When doublr-quoted, `"$@"` expands to separate strings - `"$1" "$2" "$n"`
    - When not double-quoted, the `$*` and `$@` are the same.
- Example

    ```
    #! /bin/bash

    function my_function(){
        echo "Script Name: " $0
        echo "First Argument: " $1, "Second Argument: " $2
        echo "Total number of arguments: " $#
        echo "The value of $@ and $*"
    }

    my_function "Hello" "Eswar"
    ```

- Output:

    ```
    Script Name:  ./scripts/function-arguments.sh
    First Argument:  Hello, Second Argument:  Eswar
    Total number of arguments:  2
    The value of Hello Eswar and Hello Eswar
    ```

- A Timer function using BASH Functions

    ```
    #! /bin/bash

    function timer(){
        local t;
        t=$(date "+%s")

        test $1 &gt; 0 &amp;&amp; let t-=$1
        echo $t
    }

    echo "Timer function started"

    t=$(timer)

    sleep 10

    t=$(timer $t)

    echo "Timer function executed"
    echo "Total time used: $t"

    # Output
    # Timer function started
    # Timer function executed
    # Total time used: 10