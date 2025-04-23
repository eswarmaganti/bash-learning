# AWK Command

- AWK is a scripting language used for manipulating data anf generating reports. The awk command programming language requires no compiling and allows the user to use variables, numeric functions, string functions and logical operators.
- AWK is a utility that enables a programmer to write tiny but effective programs in the form of statements that define text patterns that are to be searched for in each line of a document and the action that us to be taken when a matching is found within a line.
- AWK is mostly used for pattern scanning and text processing. It searches one or more files ti see if they contain lines that matches with the specifies patterns and then perform the associated actions.
- AWK us abbreviated from the names of developers - Aho, Weinberger and Kernighan.

- Syntax:
  - `awk options 'selection _criteria {action }' input_file &gt; output_file`.

## Predefined and automatic-variables in AWK.

- AWK supports a couple of pre-defined and automatic variables to help you write your programs. Among then you will often encounter:
- `RS`: The record separator. AWK processes your data one record at a time. The record separator is the delimiter used to split the input data stream into records. By default, this is the newline character. SO if you do not change it , a record is one line of the input file.
- `NR`: THe current input record number. If you are using the standard newline delimiter for your records, this match with the current input line number.
- `FS/OPS`: The characters used as the field separator. Once AWK reads a record, it splits it into different fields based omn the value of `FS`. When AWK print a record on the output, it will rejoin the fields, but this time, using the `OPS` separator instead of `FS` separator. Usually the `FS` and `OPS` are the same, but this is not mandatory. "white space" is the default value for both of them.
- `NF`: THe number of fields in the current record. If you are using the standard white space delimiter in your fields, this will match the number of words in the current record.

- The below is the sample file we are going to use to run the awk commands.

  ```
  bash-3.2$ cat user-data.txt
  CREDITS,EXPDATE,USER,GROUPS
  99,01 jun 2018,sylvain,team:::admin
  52,01    dec   2018,sonia,team
  52,01    dec   2018,sonia,team
  25,01    jan   2019,sonia,team
  10,01 jan 2019,sylvain,team:::admin
  8,12    jun   2018,öle,team:support



  17,05 apr 2019,abhishek,guest
  bash-3.2$
  ```

- ### Basic usage of AWK command

  1. **Print all the lines**

  - AWK programs are made of one or many `pattern { action }` statements.

    ```
    bash-3.2$ awk '1 {print}' user-data.txt
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support



    17,05 apr 2019,abhishek,guest
    bash-3.2$
    ```

  - If for a given record ("line") of the input file, the pattern evaluates to a non-zero value (equivalent to "true" in AWK), the commands in the corresponding action block are executed.
  - In the above example, since 1 is a non-zero constant, the `{ print }` action block us executed for each input record.
  - Another trick is `{ print }` is a default action block that will be used by `AWK`. If you do not explicitly specify one. So the above command can be shortened as:

    ```
    bash-3.2$ awk 1 user-data.txt
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support



    17,05 apr 2019,abhishek,guest
    bash-3.2$
    ```

  2. **Remove a file header**

  - This below command will write the records of the input file except for the very first one since in that case the condition is `1&gt;1` which obviously is not true.

    ```
    bash-3.2$ awk 'NR&gt;1 {print}' user-data.txt
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support



    17,05 apr 2019,abhishek,guest
    bash-3.2$
    ```

  - We can also write it in a simplest for as follows

    ```
    bash-3.2$ awk 'NR&gt;1' user-data.txt
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support



    17,05 apr 2019,abhishek,guest
    bash-3.2$
    ```

  3. **Print the lines in a range**

  - This is just a generalization of preceding example, and it does not deserve many explanations, except the `&amp;&amp;` s the logical `and` operator.
    ```
    bash-3.2$ awk 'NR&gt;1 &amp;&amp; NR&lt;4' user-data.txt
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    bash-3.2$
    ```

  4. **Remove whitespaces only**

  - AWK splits each word into fields based on the field separator specified in `FS` variable. The default field separator is one or several white spaces (spaces or tabs). With those settings, any record containing at least one non-whitespace will contain at least one field.

    ```
    bash-3.2$ awk 'NF' user-data.txt
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support
    17,05 apr 2019,abhishek,guest
    bash-3.2$
    ```

  - In other words, the only case where `NF` is 0 ("false") is when the record contains only spaces. So, that one-liner will only print records containing ay least one non-space character.

  5. **Removing all blank lines.**

  - This one-liner is based on an obscure POSIX rule that specifies if the `RS` is set to the empty string, _"then records are separated by sequences consisting of a &lt;newline&gt; plus one or more blank lines."_

    ```
    bash-3.2$ awk '1' RS='' user-data.txt
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support

    17,05 apr 2019,abhishek,guest
    ```

  - In the POSIX Terminology, a blank line is a completely empty line. Lines that contain only whitespace do not count as "blank".

  6. **Extracting fields.**

  - This is probably one of the most common use case for AWK: extracting some columns of the data file.

    ```
    bash-3.2$ awk '{print $1, $3}' FS=, OFS=, user-data.txt
    CREDITS,USER
    99,sylvain
    52,sonia
    52,sonia
    25,sonia
    10,sylvain
    8,öle
    ,
                    ,
    ,
    17,abhishek
    ```

  - Here, we explicitly set the both the input and output field separator to the comma. When AWK split a record into fields, it stores the content of the first field into $1, the content of the second field into $2 and so on. I do not use that here, but worth mentioning _`$0` is the entire record._
  - In this one-liner, you many have noticed i use an action block without a pattern. In that case, 1 ("true") is assumed for the pattern, so the action block is executed for each record.
  - Depending o your needs, it may not produce what we would like for blank or whitespace-only lines. In that case, that second version could be a little bit better.

    ```
    bash-3.2$ awk 'NF {print $1, $3}' FS=, OFS=, user-data.txt
    CREDITS,USER
    99,sylvain
    52,sonia
    52,sonia
    25,sonia
    10,sylvain
    8,öle
                    ,
    17,abhishek
    bash-3.2$
    ```

  - In both cases, I passed custom values for `FS` and `OFS` on the commandline. Another option would be to use a special `BEGIN` block inside the AWK program to initialize those variables before the first record is read. So, depending on your taste, you may prefer writing that instead.

    ```
    bash-3.2$ awk 'BEGIN {FS=OFS=","} NF {print $1,$3}' user-data.txt
    CREDITS,USER
    99,sylvain
    52,sonia
    52,sonia
    25,sonia
    10,sylvain
    8,öle
                    ,
    17,abhishek
    ```

  - You may also use `END` blocks to perform some tasks after the last record has been read.

  7. **Performing calculations column-wise.**

  - AWK support the standard arithmetical operations. And will convert values between text and numbers automatically depending on the context. Also, you can use your own variables to store intermediate values. All that allows you to write compact programs to perform calculations on data columns.

    ```
    bash-3.2$ awk '{SUM+=$1} END {print SUM}' FS=, OFS=, user-data.txt
    263
    bash-3.2$ awk '{SUM=SUM+$1} END {print SUM}' FS=, OFS=, user-data.txt
    263
    ```

  - Please note that awk variables do not need to be declared before usage. An undefined variable assumed to hold the empty string. Which, according to the AWK type conversion rules, is equal to the number `0`.

  8. **Counting the number of non-empty lines**

  - I have already mentioned the `END` rule before. Here is another possible application to count the number of non-empty lines in a file.

    ```
    bash-3.2$ awk '/./ {COUNT+=1} END {print COUNT}' user-data.txt
    9
    ```

  - Here the `COUNT` variable will be incremented by `+1` for each line matching the regular expression `/./` . That is each line containing at least one character. Finally, the END block is used to display the final result once the entire file has been processed.
  - However, is this result correct? well, it depends on your definition of an "empty" line. If you consider only blank lines are empty, then this is correct. But may be would you prefer considering whitespace lines as empty too?

    ```
    bash-3.2$ awk 'NF {COUNT+=1} END {print COUNT}' user-data.txt
    8
    ```

  - Finally, if you are interested only in data lines, and given my particular input data file, I cluld write that instead:

    ```
    bash-3.2$ awk '+$1 {COUNT+=1} END {print COUNT}' FS=, user-data.txt
    7
    ```

  - It works because of AWK type conversion rules. The unary plus in the pattern forces the evaluation of $1 in a numerical context. In my file, data records contain a number in their first field. Non-data records contain text or nothing. All of then being equal to 0 when converted to numbers.

- ### Using Arrays in AWK

  - Arrays are powerful feature of AWK. All arrays in AWK are `associative arrays`, so they allow associating an arbitrary string with another value. If you are familiar with other programming languages, you may know then as hashes, associative tables, dictionaries or maps.

  9. **A simple example if AWK array.**

  - Lets imagine i want to know the total credit of all users. I can store an entry for each user in an associative array, and each time i encounter a record for that user, I increment the corresponding value stored in the array.

    ```
    bash-3.2$ awk '+$1 {CREDITS[$3]+=$1}  END {for (NAME in CREDITS) print NAME, CREDITS[NAME]}' FS=, OFS=, user-data.txt
    sylvain,109
    sonia,129
    abhishek,17
    öle,8
    ```

  - I admit this is no longer a one-liner. Mostly because of the for loop used to display the content of the array after the file has been processed.

  10. **Identifying duplicate lines using AWK.**
  - Arrays, just like other AWK variables, can be used both in action blocks as well as in patterns. By taking benefit of that, we can write a one-liner to print only duplicate lines:

    ```
    bash-3.2$ awk 'a[$0]++' user-data.txt 
    52,01    dec   2018,sonia,team
    
    ```
  - THe `++` operator is the post-increment operator inherited from C Language family. As its name implies that post-increment operator increments a variable, but only after its value has taken for the evaluation of the englobing expression.
  - In that case, `a[$0]` is evaluated to see if the record will be printed or not, and once the decision has been made, in call cases, the array entry is incremented.
  - So the first time a record is read, `a[$0]` is undefined, and thus equivalent to zero for AWK. So that first record is not written on the output.
  - THen that entry is changed from zero to one. The second time the same input record is read, `a[$0]` is now 1. THat is `true`. The line will be printed. However, before that, the array entry is updated from 1 to 2. And so on.

  11. **Removing Duplicate lines**
  - As a corollary of the previous one-liner, we may want to remove duplicate lines:

    ```
    bash-3.2$ awk '!a[$0]++' user-data.txt 
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01    dec   2018,sonia,team
    25,01    jan   2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12    jun   2018,öle,team:support

                    
    17,05 apr 2019,abhishek,guest
    ```
  - The only difference is the use of the logical, not operator (`!`) that reverses the truth value of the expression. What was false become true and what was true become false.
  - The logical not have absolutely no influence on the `++` post increment operator which works exactly as above.

- ### Filed and record separator magic

  12. **Changing the Field Separators**

      ```
      bash-3.2$ awk '$1=$1' FS=, OFS=';' user-data.txt
      CREDITS;EXPDATE;USER;GROUPS
      99;01 jun 2018;sylvain;team:::admin
      52;01    dec   2018;sonia;team
      52;01    dec   2018;sonia;team
      25;01    jan   2019;sonia;team
      10;01 jan 2019;sylvain;team:::admin
      8;12    jun   2018;öle;team:support
                      
      17;05 apr 2019;abhishek;guest
      ```
  - The above command sets the `FS` and `OFS` variable to use a coma as input field separator and a semicolon as the output filed separator. 
  - Since AWK does not change the output record as long as you did not change a field, the `$1=$1` trick is used to force AWK to break the record and reassemble it using the output field separator.
  - Remember here the default action block is `{ print }`. So you could rewrite that more explicitly as:
    
    ```
    bash-3.2$ awk '$1=$1 {print}' FS=, OFS=';' user-data.txt
    CREDITS;EXPDATE;USER;GROUPS
    99;01 jun 2018;sylvain;team:::admin
    52;01    dec   2018;sonia;team
    52;01    dec   2018;sonia;team
    25;01    jan   2019;sonia;team
    10;01 jan 2019;sylvain;team:::admin
    8;12    jun   2018;öle;team:support
                    
    17;05 apr 2019;abhishek;guest
    ```
  - YOu may have noticed both those examples are removing empty lines too. Why?, well, remember the AWK conversion riles: an empty string is "false". All other strings are "true". THe expression `$1=$1` is an affection that alters `$1`.
  - However, this is an expression too. Anf it evaluates to the value of `$1` - which is "false" for the empty string.
  - If you really want all the lines with empty lines, you may need to write the AWK command as follows

    ```
    bash-3.2$ awk '($1=$1) || 1 {print}' FS=, OFS=';' user-data.txt 
    CREDITS;EXPDATE;USER;GROUPS
    99;01 jun 2018;sylvain;team:::admin
    52;01    dec   2018;sonia;team
    52;01    dec   2018;sonia;team
    25;01    jan   2019;sonia;team
    10;01 jan 2019;sylvain;team:::admin
    8;12    jun   2018;öle;team:support

                    

    17;05 apr 2019;abhishek;guest
    ```

  13. **Removing multiple spaces**
  - This is almost the same program as the preceding one. However, I left the field separator to their default values.

    ```
    bash-3.2$ awk '$1=$1' user-data.txt 
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,sylvain,team:::admin
    52,01 dec 2018,sonia,team
    52,01 dec 2018,sonia,team
    25,01 jan 2019,sonia,team
    10,01 jan 2019,sylvain,team:::admin
    8,12 jun 2018,öle,team:support
    17,05 apr 2019,abhishek,guest
    ```

  - So, multiple whitespaces are used as the input field separator, but only one space is used as the output field separator. This has the nice side effect of coalescing *multiple whitespaces* into one space.

  14. **Joining lines using AWK**
  - We have already used `OFS`, the output field separator. As you ,ay have guesses, it has the `ORS` counterpart to specify the output record separator

    ```
    bash-3.2$ awk 'NF {print $3}' FS=, ORS=' ' user-data.txt 
    USER sylvain sonia sonia sonia sylvain öle  abhishek 
    ```

  - Here, I used a space after each record instead of a newline character. This one-liner is sufficient in some use cases, bit it still has some drawbacks.
  - Most obviously, it does not discard whitespace-only lines. So, I may end up using a plain regular expression instead.

    ```
    bash-3.2$ awk '/[^ ]/  { print $3 }' FS=, ORS=' ' user-data.txt ; echo
    USER sylvain sonia sonia sonia sylvain öle abhishek 
    ```

  - It is better now, but there is still a possible issue. It will be more obvious if we change the separator to something visible:

    ```
    bash-3.2$ awk '/[^ ]/  { print $3 }' FS=, ORS='+' user-data.txt ; echo
    USER+sylvain+sonia+sonia+sonia+sylvain+öle+abhishek+

    ```

  - There is an extra separator at the end of the line- because the field separator is written after each record including the last one.
  - To fix that, I will rewrite the program to display a custom separator before the record, starting from the second output record.

    ```
    bash-3.2$ awk '/[^ ]/ {print SEP $3; SEP="+"}' FS=, ORS=' ' user-data.txt ; echo
    USER +sylvain +sonia +sonia +sonia +sylvain +öle +abhishek

    bash-3.2$ awk '/[^ ]/ {print SEP $3; SEP="+"}' FS=, ORS='' user-data.txt ; echo
    USER+sylvain+sonia+sonia+sonia+sylvain+öle+abhishek

    bash-3.2$ awk '/[^ ]/ {print SEP $3; SEP=" "}' FS=, ORS='' user-data.txt ; echo
    USER sylvain sonia sonia sonia sylvain öle abhishek
    ```
  - Since I take care of adding the separator by myself, I also set the standard AWK output record separator to the empty string. However, when you start dealing yourself with separators or formatting, it may be the sign you should consider using the printf function instead of the print statement.

- ### Field Formatting
  - I have already mentioned the relationship between the AWK and C programming languages. Among other things, from the C language standard library AWK inherits the powerful `printf` function, allowing great control over the formatting of the text sent to the output.
  - The `printf` function takes a format as the first argument, containing both plain text that will be output verbatim and wildcards used to format different sections of the output.
  - The wildcards are identified by the `%` character. THe mist common being `%s`, `%d` and `%f`.

    ```
    bash-3.2$ awk '+$1 { printf("%s ", $3)}' FS=, user-data.txt 
    sylvain sonia sonia sonia sylvain öle abhishek 
    ```
  - You may notice, as the opposite if the `print` statement, the `printf` function does not use the `OFS` and `ORS` values. So, if you want some separator, you have to explicitly mention it as I did by adding a space character at the end of the format string. This is th price to pay for having full control of the output.
  - While not only at all a format specifier, this is an excellent occasion to introduce the `\n` notation which can be used in any AWK string to represent a newline character.

    ```
    bash-3.2$ awk '+$1 {printf("%s\n", $3)}' FS=, user-data.txt 
    sylvain
    sonia
    sonia
    sonia
    sylvain
    öle
    abhishek
    ```

  15. **Producing Tabular results**
  - AWK enforces a record/field data format based on delimiters. However, using the `printf` function, you can also produce fixed-width tabular output. Because each format specified in a `printf` statement can accept an optional width parameter.
  
    ```
    bash-3.2$ awk '+$1 { printf("%s | %d\n", $3,$1) }' FS=, user-data.txt 
    sylvain | 99
    sonia | 52
    sonia | 52
    sonia | 25
    sylvain | 10
    öle | 8
    abhishek | 17
    bash-3.2$ 

    bash-3.2$ awk '+$1 { printf("%10s | %4d\n", $3,$1) }' FS=, user-data.txt 
      sylvain |   99
        sonia |   52
        sonia |   52
        sonia |   25
      sylvain |   10
          öle |    8
      abhishek |   17
      
    bash-3.2$ awk '+$1 { printf("%-10s | %4d\n", $3,$1) }' FS=, user-data.txt 
    sylvain    |   99
    sonia      |   52
    sonia      |   52
    sonia      |   25
    sylvain    |   10
    öle       |    8
    abhishek   |   17

    bash-3.2$ awk '+$1 { printf("%-10s | %04d\n", $3,$1) }' FS=, user-data.txt 
    sylvain    | 0099
    sonia      | 0052
    sonia      | 0052
    sonia      | 0025
    sylvain    | 0010
    öle       | 0008
    abhishek   | 0017
    ```
  - As you can see, by specifying the width of each field, AWK pads them to the left with spaces. For text, it is usually preferable to pad on the right, something that can be achieved using a negative width number.
  - Also, for integers, we may like to pad fields with zero instead of spaces. This can be obtained by using an explicit 0 before the filed width.

  16. **Dealing with the floating point numbers**
  - The `%f` format does not deserve much explanations
    ```
    awk '+$1 {SUM+=$1; NUM+=1} END {printf("AVG:%f",SUM/NUM); } ' FS=, user-data.txt; echo
    AVG:37.571429
    ```
  - To explicitly set the field width and precision of the displayed result:

    ```
    awk '+$1 {SUM+=$1; NUM+=1} END {printf("AVG:%6.2f",SUM/NUM); } ' FS=, user-data.txt; echo
    AVG: 37.57
    ```

- ### Using String functions in AWK
  - In addition to the `printf` function, AWK contains few other nice string manipulation functions. In that domain, modern implementations like `Gawk` have a richer set of internal functions at the price of lower portability.

  17. **Converting text to uppercase**
  - This one, I use it a lot, because it handles internationalization issues nicely:

    ```
    awk '$3 {print toupper($0)}' user-data.txt 
    99,01 JUN 2018,SYLVAIN,TEAM:::ADMIN
    52,01    DEC   2018,SONIA,TEAM
    52,01    DEC   2018,SONIA,TEAM
    25,01    JAN   2019,SONIA,TEAM
    10,01 JAN 2019,SYLVAIN,TEAM:::ADMIN
    8,12    JUN   2018,ÖLE,TEAM:SUPPORT
    17,05 APR 2019,ABHISHEK,GUEST
    ```
  - As a matter of fact, This is probably the best and most portable solution to convert text to uppercase from the shell.

  18. **Changing part of string**
  - Using the `substr` command, you can split a string of characters at a given length. Here i use it to capitalize only the first character of the third field:

    ```
    bash-3.2$ awk '{$3 = toupper(substr($3,1,1)) substr($3,2)} $3' FS=, OFS=, user-data.txt 
    CREDITS,EXPDATE,USER,GROUPS
    99,01 jun 2018,Sylvain,team:::admin
    52,01    dec   2018,Sonia,team
    52,01    dec   2018,Sonia,team
    25,01    jan   2019,Sonia,team
    10,01 jan 2019,Sylvain,team:::admin
    8,12    jun   2018,Ole,team:support
    17,05 apr 2019,Abhishek,guest
    ```
  - The `substr($3,1,1)` will evaluate to the first character of `$3` and `substr($3,2)` to the remaining ones.

  19. **Splitting fields in sub-fields**

  - AWK record-field data model is really nice. However, sometimes you want to split fields themselves into several parts based on some internal separator:

    ```
    bash-3.2$ awk '+$1 { split($2, DATE, " "); print $1,$3, DATE[2], DATE[3] }' FS=, OFS=, user-data.txt 
    99,sylvain,jun,2018
    52,sonia,dec,2018
    52,sonia,dec,2018
    25,sonia,jan,2019
    10,sylvain,jan,2019
    8,ole,jun,2018
    17,abhishek,apr,2019
    ```
  
  - Somewhat surprisingly, this works even if some of my fields are separated by more than one whitespace. Mostly for historical reasons, when the separator is a single space, `split` will consider "The elements are separated by runs of whitespace". And not only by just one. The `FS` special variable follows the same convention.
  - However, in general case, one character string match one character. So, if you need something more complex, you gave to remember the field separator is an extended regular expression.

    ```
    bash-3.2$ awk '+$1 { split($4, GRP, ":"); print $3, GRP[1], GRP[2]}' FS=, user-data.txt 
    sylvain team 
    sonia team 
    sonia team 
    sonia team 
    sylvain team 
    ole team support
    abhishek guest 
    ```
  - Here, We would have expected to display up to two groups per user, it shows only one for most of them. That issue is caused by the multiple occurrences of the separator. So the solution is:

    ```
    bash-3.2$ awk '+$1 { split($4, GRP, /:+/); print $3, GRP[1], GRP[2]}' FS=, user-data.txt 
    sylvain team admin
    sonia team 
    sonia team 
    sonia team 
    sylvain team admin
    ole team support
    abhishek guest
    ```
  - The slashes instead of the quotes denote the literal as being a regular expression rather than a plain string, and the plus sign indicates this expression will match one or several occurrences of the previous character. So, in that case, each separator is made (of the longest sequence of) one or several consecutive colons.

  20. **Searching and replacing with AWK commands**
  - Speaking of regular expressions, sometimes you want to perform substitution like the sed `s///g` command, but only on one field. The `gsub` command is what you need in that case: 
    
    ```
    bash-3.2$ awk '+$1 {gsub(/ +/, "-", $2); print}' FS=, user-data.txt 
    99 01-jun-2018 sylvain team:::admin
    52 01-dec-2018 sonia team
    52 01-dec-2018 sonia team
    25 01-jan-2019 sonia team
    10 01-jan-2019 sylvain team:::admin
    8 12-jun-2018 ole team:support
    17 05-apr-2019 abhishek guest
    ```
  - The `gsub` function takes a regular expression to search, a replacement string and the variable containing the text to be modified in place.


- ### Working with external commands in AWK
- Another great feature of AWK is you can easily invoke external commands to process your data. There are basically two ways of doing it: using the `system` instruction to invoke a program and letting it intermixing its outputs in the AWK output stream. 
- Using a pipe so AWK can capture the output of the external program for finer control of the result.
  
  21. **Adding the date on top of a file**

      ```
      bash-3.2$ awk 'BEGIN {printf("UPDATED: "); system("date")} /^UPDATED:/ {next} 1' user-data.txt 
      UPDATED: Mon Apr 21 05:26:17 IST 2025
      CREDITS,EXPDATE,USER,GROUPS
      99,01 jun 2018,sylvain,team:::admin
      52,01    dec   2018,sonia,team
      52,01    dec   2018,sonia,team
      25,01    jan   2019,sonia,team
      10,01 jan 2019,sylvain,team:::admin
      8,12    jun   2018,ole,team:support

                      

      17,05 apr 2019,abhishek,guest
      ```
  - In the above AWK command, We started by displaying the work UPDATED. THenn the program invokes the external date command, which will send its result on the output right after the text produced by AWK at that stage.
  - The rest of the AWK program just remove an update statement eventually present in the file and print all the other lines.
  - Notice that `next` statement. It is used to abort the processing of the current record. It is a standard way of ignoring some records from the input file.

  22. **Modifying a field externally**
  
  - For more complex cases, you may need to consider the `| getline VARIABLE` idiom of AWK:

    ```
    bash-3.2$ awk '+$1 {CMD | getline $5; close(CMD); print}' CMD='uuid -v4' FS=, OFS=, user-data.txt 
    99,01 jun 2018,sylvain,team:::admin,388d450a-5bf7-4d7b-8e3c-609754a4d0ce
    52,01    dec   2018,sonia,team,57823df6-d05e-43d4-9a7e-b034e3db90a1
    52,01    dec   2018,sonia,team,9e912d66-5d28-4bbf-ba7b-87cba6fe2788
    25,01    jan   2019,sonia,team,b915b3cc-3280-4fc4-a96c-5ee4d9b3bcfd
    10,01 jan 2019,sylvain,team:::admin,03655922-9360-4999-b015-af5fb6c0127f
    8,12    jun   2018,ole,team:support,4c5d48a1-967e-40d5-82e6-08f20b6403e8
    17,05 apr 2019,abhishek,guest,611855a8-00be-4ad9-98b2-0a350f065b01
    ```
  
  - This will run the command stored in the `CMD` variable, read the first line of the output of that command, and store it in the variable `$5`.
  - Pay special attention to the close statement, critical here as we want AWK to create a new instance if the external command each time it executes the `CMD | getline` statement. without the close statement, AWK would instead try to read several lines of output from the same command instance.

  23. **Invoking dynamically generated commands**

  - Commands in AWK are just plain strings without anything special. It its the pipe operator that triggers external programs execution. SO, if you need, you can dynamically construct arbitrary complex commands by using AWK string manipulation functions and operators.

    ```
    bash-3.2$ awk '+$1 { cmd = sprintf(FMT, $2); cmd | getline $2; close(cmd); print }' FMT='date -I'  FS=, user-data.txt 
    99 2025-04-21 sylvain team:::admin
    52 2025-04-21 sonia team
    52 2025-04-21 sonia team
    25 2025-04-21 sonia team
    10 2025-04-21 sylvain team:::admin
    8 2025-04-21 ole team:support
    17 2025-04-21 abhishek guest
    ```
