# Parameter Expansion in BASH

- Parameter expansion is one of the key concepts in BASH Scripting. It is useful to find, replace or modify the value of a parameter. THe multi-purpose dollar `($)` symbol is used for parameter expansion.

## Basics of parameter expansion in BASH

- `${parameter_name}` is the basic synatx of parameter expansion in BASH. It allows users to access the value of the parameter. The optional curly braces `{}` is often used to avoid ambiguity between the value of the parameter and he characters enclosed in it.
- Example

  ```
  bash-3.2$ name="Eswar Krishna Maganti"
  bash-3.2$ echo ${name}
  Eswar Krishna Maganti
  bash-3.2$ echo $name
  Eswar Krishna Maganti
  ```

- In the first line of code, **name** is a variable, in other words, a parameter. The value of the parameter is set to `Eswar Krishna Maganti`.

## Indirect Parameter Expansion in BASH\

- While expanding, an exclamation mark before the parameter name like - `${!parameter_name}` refers to a level of indirectness.
- This means BASH first expands the part after the exclamation sign. Then the value of the first expansion is used as a new parameter. It then expands the new parameter, rather than using the original parameter, rather than using the original parameter's expansion.
- Example

  ```
  name="Eswar Krishna Maganti"
  bash-3.2$ echo ${name}
  Eswar Krishna Maganti
  bash-3.2$ echo $name
  Eswar Krishna Maganti

  bash-3.2$ admin='name'
  bash-3.2$ echo $admin
  name
  bash-3.2$ echo ${!admin}
  Eswar Krishna Maganti
  ```

- In the above example, `${!admin}` first expands the parameter `admin` and retrives it's value which is `name`.
- Then `name` is used as the new parameter. Finally the value of the `name` parameter is expanded as you see `Eswar Krishna Maganti` is the output of echo command.

- NOTE:
  - when the name ref is an array variable, the exclamation sign doesn't refer to indirect expansion. So `${!name[@]}` or `${!name[*]}` is an exception of indirect expansion.
  - Rather than regular parameter expansion, these expand to the list of indices of the assigned array or keys in case of an associate array.
  - `${!prefix*}` or `${!prefix@}` also doesn't refer traditional parameter expansion. THese expand to the names of the variables that start with the particular **prefix**.

## Default value expansion

- You can set the default value or initial value of a parameter using parameter expansion. The **default value** is the value of a variable or parameter when that variable is either unset or empty.

  ```
  bash-3.2$ name="Eswar Krishna Maganti"
  bash-3.2$ echo $name
  Eswar Krishna Maganti
  bash-3.2$ unset name
  bash-3.2$ echo $name

  echo ${name:='John Doe'}
  John Doe
  bash-3.2$ echo $name
  John Doe
  ```

- To set a default value for the **name** parameter, we can use the syntax

  - `${parameter_name:=default_value}`

- If the value of the parameter is set then default value expansion doesn't expand the value mentioned as the default value. Thought we set the value of the **user** as John Doe as the default value, it expands to **Eswar Krishna Maganti** as **name** is set already.

  ```
  bash-3.2$ name='Eswar Krishna Maganti'
  bash-3.2$ echo $name
  Eswar Krishna Maganti
  bash-3.2$ echo ${name:='John Doe'}
  Eswar Krishna Maganti
  ```

- There are other syntaxes related to default value expansion. The important thing to understand about those syntaxes is `:-` check for the parameter that is unset ot null.
- If colon is omitted then it checks for a parameter that is null. On the contrary, if colon is included then the operator checks the existence of a parameter and its value if not null.
- Below are the few options that include colon.

| Syntax                | Explenation                                                                                                                                   |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `${parameter:-value}` | If tehe parameter is null or unset, it is replaced by value if the parameter has a value, it's not changed.                                   |
| `${parameter:?value}` | If parameter is null or unset, an error is triggered, and value is displayed. If parameter has a value, it's not changed                      |
| `${parameter:+value}` | If parameter is null or unset, nothing is substituted, and parameter remains empty. If parameter has a value, it's replaces by the new value. |

    ```
    bash-3.2$ name='Eswar Krishna Maganti'
    bash-3.2$ echo $name
    Eswar Krishna Maganti
    bash-3.2$
    bash-3.2$ unset name

    bash-3.2$
    bash-3.2$ echo ${name:-John}
    John
    bash-3.2$ echo $name


    bash-3.2$ echo ${name:?John}
    bash: name: John
    bash-3.2$
    bash-3.2$ echo ${name:+John}

    bash-3.2$ name='Eswar Krishna Maganti'
    bash-3.2$ echo ${name:+John}
    John
    bash-3.2$ echo $name
    Eswar Krishna Maganti
    ```

## Types of parameter expansion in BASH

### Basic string operations using BASH parameter expansion

- TO perform basic operations, such as finding the length of a parameter, capitalizing or lowercasing the parameter requires proper use of special characters like `#` and `^` before or after the _parameter_ name.

1. Length of a parameter using parameter expansion

- To find the lenght of a parameter, place a `#` before the name of the parameter. For example, if then name of a parameter is **user**, `${#user}` will expand to the length of its value.

      ```
      bash-3.2$ echo $name
      Eswar Krishna Maganti

      echo ${#name}
      21
      ```

2. Capitalizing the value of a parameter using parameter expansion

- YOu can capitalize the value of a parameter using the caret `^` sign. A single caret should be placed at the end of the parameter name to capitalize the first letter.

  ```
  bash-3.2$ name='john'
  bash-3.2$$ echo $name
  john
  bash-3.2$$ echo ${name^}
  John
  bash-3.2$$ echo ${name^^}
  JOHN
  ```

- TO capitalize the whole value of a parameter, use the double caret as shown above.

3. Lowercasing the value of a parameter using parameter expansion

- TO convert a parameter's value to lowercase, use comma `,` after parameter's name. A single comma changes the first character of the parameter's value to lowercase, while double comma changes the entire value to lowercase.

  ```
  bash-3.2$ name='JOHN'
  bash-3.2$ echo ${name}
  JOHN
  bash-3.2$ echo ${name,}
  jOHN
  bash-3.2$ echo ${name,,}
  john
  ```

4. Parameter expansion operators

- There are few operatos available to quickly manipulate the value of a parameter.
- The syntax of using these operators is `${parameter_name@operator}`. The below are the list of operators.

  | Operator | Explanation                                                                                                                                                    |
  | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
  | `U`      | Convert lowercase alphabetic characters in the value of parameter to uppercase                                                                                 |
  | `u`      | convert the first character of the value of parameter to uppercase, if it's alphabetic.                                                                        |
  | `L`      | Convert uppercase alphabetic characters in the value of parameter to lowercase                                                                                 |
  | `Q`      | Quotes the value of parameter in a format that can be reused as input.                                                                                         |
  | `E`      | Expands backslash escape sequences in the value of parameter as with the $`...` quoting mechanism.                                                             |
  | `P`      | Expands the value of the parameter as if it were a prompt string                                                                                               |
  | `A`      | Expanded string generates a string in the form of an assignment statement or declare command. Evaluating it recreates parameter with its attributes and value. |
  | `K`      | Produces a possibly-quoted version of the value of parameter. For arrays, it prints index or key-value pairs                                                   |
  | `a`      | Generates a string consists of flag values representing parameter's attributes.                                                                                |
  | `k`      | Similar to `K` but expands keys and values f array to separate words after word splitting                                                                      |

### Substring Slicing using parameter expansion

- It's perfectly fine to use commands like `awk` or `sed` to modify or extract substrings. However you can also utilize the built-in syntax of parameter expansion to modify or extract parts from the value of a parameter.
- Colon is used to specify the index of a substring after the name of a parameter.
- Example

  ```
  bash-3.2$ name="Eswar Krishna Maganti"
  bash-3.2$ echo $name
  Eswar Krishna Maganti
  bash-3.2$
  bash-3.2$ echo ${name:0:5}
  Eswar
  bash-3.2$ echo ${name::5}
  Eswar
  bash-3.2$ echo ${name:6}
  Krishna Maganti
  ```

- `Note`: If either of the indices is not defined explicitly in parameter expansion, BASH takes the start index as `zero` and the `end` index as he end of the string.

### Substitution with parameter expansion

- You can perform find and replace operations using parameter expansion in BASH

1. ### Find and Replace using parameter expansion

- The basic syntax for find and replace operation is `${parameter_name/find_key/replace_key}`.
- Example:
  ```
  bash-3.2$ echo $name
  Eswar Krishna Maganti
  bash-3.2$
  bash-3.2$ echo ${name/Eswar/Aruna}
  Aruna Krishna Maganti
  ```
- `${name/Eswar/Aruna}`- replaces the first occurrence of `Eswar` with `Aruna` in the string stored in the variable `name` and then prints the modified string.

2. ### Find and Replace with wildcard's using parameter expansion.

- It raises no error if you use wildcard characters such as asterisk `*` and question mark `?` to match pattern in parameter expansion
- Example
  ```
  bash-3.2$ msg='Python is a most popular scripting language'
  bash-3.2$ echo $msg
  echo ${msg/lang*/'and programming language' }
  Python is a most popular scripting and programming language
  ```

3. ### Global Replacement in parameter expansion.

- The syntax `${parameter//search/replace}` will replaces all the instances of the `search` string with the `replace` string.
  ```
  bash-3.2$ msg='python is the most popular scripting language. Python is also a popular choice for machine learning'
  bash-3.2$
  bash-3.2$ echo ${msg//popular/famous}
  python is the most famous scripting language. Python is also a famous choice for machine learning
  ```
- Note: THere is another syntax for global replacement using parameter expansion. `${parameter/search/replace/g}` replaces all occurrences of `search` with `replace`. The `"g"` tag indicates that the replacement should be global.

4. ### Using "#" to remove matching from the beginning of a parameter.

- We can you the `#` character for the substring expansion. `${parameter/#pattern/}` this will removes the shortest matching pattern from the beginning of the parameter.
- `##` is also used to modify the values of a parameter. `${parameter/##pattern/}` removes the longest matching pattern from the beginning of the parameter.
- Example

```
bash-3.2$ echo $path
/Users/eswarkrishnamaganti/learing
bash-3.2$
bash-3.2$ echo ${path#/}
Users/eswarkrishnamaganti/learing
bash-3.2$
bash-3.2$ echo ${path#*/}
Users/eswarkrishnamaganti/learing
bash-3.2$ echo ${path#*/Users}
/eswarkrishnamaganti/learing
bash-3.2$
bash-3.2$ echo ${path##/}
Users/eswarkrishnamaganti/learing
bash-3.2$ echo ${path##*/}
learing
bash-3.2$ echo ${path##*/U}
sers/eswarkrishnamaganti/learing
bash-3.2$ echo ${path##*/l}
earing
bash-3.2$ echo ${path#/l}
/Users/eswarkrishnamaganti/learing
bash-3.2$ echo ${path#*/l}
earing
```

5. ### Using `%` to remove matching from the end of a parameter.

- `%` will work just the opposite of `#`. For example, a single `%` will remove the shortest matching pattern from the end of a parameter. The syntax should be look like this - `${variable%pattern}` .
- the `%%` will work just the opposite of `##` it removes the longest matching pattern from the end of a parameter. THe syntax should be - `${variable%%pattern}`

```
echo $path
/Users/eswarkrishnamaganti/learing
bash-3.2$
bash-3.2$ echo ${path%/}
/Users/eswarkrishnamaganti/learing
bash-3.2$ echo ${path%/*}
/Users/eswarkrishnamaganti
bash-3.2$
bash-3.2$ echo ${path%/*}
/Users/eswarkrishnamaganti

echo ${path%%/*}

bash-3.2$ echo ${path%%/l*}
/Users/eswarkrishnamaganti
```
