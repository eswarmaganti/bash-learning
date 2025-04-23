# Grep: Searching Text Patterns

- The grep command in Unix/Linux ia  a powerful tool for searching and manipulating text patterns within files. Its name is derived form the ed (editor) command g/re/p (global search for regular expression and print matching lines), which reflects its core functionality.

- Syntax of Grep Command
  - `grep [options] pattern [files]`
  - here, `[options]`: these are commandline flags that modify the behavior of grep.
  - `pattern`: This is the regular expression you want to search for.
  - `[file]`: This is the name of the file(s) you want to search within. You can specify multiple files simultaneous search.
- Options available in grep

| Option | Description |
| ------ | ----------- |
| -c | This prints only the count of the lines tht match a pattern | 
| -h | Display the matched lines but do not display the file names |
| -i | ignore case for matching | 
| -l | Displays list of file names only |
| -n | Display the matched lines and their line numbers |
| -v | This prints out all the lines that don't matches the pattern |
| -e exp | specifies expression with this option. can use multiple times |
| -f file | Takes patterns from file, one per line |
| -E | Treats patterns as extended regular expressions |
| -w | match whole word | 
| -o | prints only the matched parts of the matching line, with each such part on a separate output line |
| -A n | prints searched line and n lines after the result. |
| -B n | prints searched line and n line before the result |
| -C n | Prints searched line and n lines after before the results |


- Practical Examples:
  1. Case insensitive search
    - The -i option enables to search for a string case insensitively in the given file. It matches the words like "Unix", "unix", "UNIX"..
        ```
        bash-3.2$ cat my-data.txt 
        unix is great os. unix was developed in Bell labs.


        learn operating system.


        Unix linux which one you choose.


        uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
        bash-3.2$ 
        bash-3.2$ grep -i unix my-data.txt 
        unix is great os. unix was developed in Bell labs.
        Unix linux which one you choose.
        uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
        bash-3.2$ 
        ```
  2. Displaying the count of number of matches
    - We can find the number of lines that matches the given string/pattern using `-c` option
        ```
        bash-3.2$ grep -c unix my-data.txt 
        2
        ```
  3. Display the file names that matches the patten using grep
    - We can just display the files that contains the given string/pattern using `-l` option.
        ```
        bash-3.2$ grep -l "unix" *
        my-data.txt
        my-data3.txt
        my-data4.txt
        bash-3.2$ 
        ```
  4. Checking the whole words in a file using grep.
    - By default, grep matches the given string/pattern even if its found as a substring in a file. The -w option to grep makes it match only the whole words.
        ```
        bash-3.2$ grep -w 'Python' my-data2.txt 
        Python is one of the popular programming languages.
        Python is widely used in AI/ML Application.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ 
        ```
  5. Displaying only the matched patterns using grep.
    - By default, grep displays the entire line which has the matched string. We can make the grep to display only the matched sting by using the `-o` option.

        ```
        bash-3.2$ grep -o 'Python' my-data2.txt 
        Python
        Python
        Python
        bash-3.2$ 
        ```
  6. Show line number while displaying the output using grep.
    - To show the line numbers of file with the line matched.
        ```
        bash-3.2$ grep -n 'Python' my-data2.txt 
        1:Python is one of the popular programming languages.
        2:Python is widely used in AI/ML Application.
        3:Python is also widely preferred for developing the backend application for web.
        ```
  7. Invert the pattern matching using grep
    - You can display the line that are not matched with the specified search string pattern using the -v option.
        ```
        # without using -v option
        bash-3.2$ ps -ef |  grep python
        501  1986  1911   0 Thu10AM ??         0:00.04 /Applications/Box.app/Contents/MacOS/python -B -c from multiprocessing.resource_tracker import main;main(29)
        501 12288  1537   0 Fri02PM ??         0:06.14 /Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Plugin).app/Contents/MacOS/Code Helper (Plugin) /Users/eswarkrishnamaganti/.vscode/extensions/ms-python.vscode-pylance-2025.4.1/dist/server.bundle.js --cancellationReceive=file:bfd621c4aff5dfa3f9f622e02160901a1b91092bf2 --node-ipc --clientProcessId=1537
        501 83689  9445   0  1:14PM ttys004    0:00.01 grep --color=auto python
        bash-3.2$ 

        # with using -v option
        bash-3.2$ ps -ef | grep -v grep | grep python
        501  1986  1911   0 Thu10AM ??         0:00.04 /Applications/Box.app/Contents/MacOS/python -B -c from multiprocessing.resource_tracker import main;main(29)
        501 12288  1537   0 Fri02PM ??         0:06.15 /Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Plugin).app/Contents/MacOS/Code Helper (Plugin) /Users/eswarkrishnamaganti/.vscode/extensions/ms-python.vscode-pylance-2025.4.1/dist/server.bundle.js --cancellationReceive=file:bfd621c4aff5dfa3f9f622e02160901a1b91092bf2 --node-ipc --clientProcessId=1537
        bash-3.2$ 
        ```

  8. Matching the lines that starts with the given string or pattern.
    - the `^` regular expression pattern specifies the start of a line. This can be used in a grep to match the lines which start with the given string or pattern.
        ```
        bash-3.2$ cat my-data2.txt 
        Python is one of the popular programming languages.

        Today many AI/ML Applications are developed using Python.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ 
        bash-3.2$ grep '^Python' my-data2.txt 
        Python is one of the popular programming languages.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ 
        ```
  9. Matching the lines that ends with a string using grep.
    - The regular expression pattern `$` specifies the end of a line. This can be used in grep to match the lines end with the given string or pattern.
        ```
        bash-3.2$ cat my-data2.txt 
        Python is one of the popular programming languages.

        Today many AI/ML Applications are developed using Python.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ grep 'Python.$' my-data2.txt 
        Today many AI/ML Applications are developed using Python.
        bash-3.2$ 
        ```
  10. Matching multiple words or patterns using grep.
    - we can use -e/-E option to match multiple words or patterns as shown below.
        ```
        bash-3.2$ cat my-data2.txt 
        Python is one of the popular programming languages.
        bash-3.2$
        Today many AI/ML Applications are developed using Python.
        Python is also widely preferred for developing the backend application for web.
            bash-3.2$ grep -e 'Python' -e 'popular' my-data2.txt 
        Python is one of the popular programming languages.
        Today many AI/ML Applications are developed using Python.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ 
        bash-3.2$ grep -E 'Python|popular' my-data2.txt 
        Python is one of the popular programming languages.
        Today many AI/ML Applications are developed using Python.
        Python is also widely preferred for developing the backend application for web.
        bash-3.2$ 
        ```
  11. Input the patterns from a file using -f option.
    - We can provide all the patterns as an input in the form of a file using the flag `-f`.

      ```
      bash-3.2$ cat patterns.txt 
      Python
      popular
      backend
      bash-3.2$ 
      bash-3.2$ grep -f patterns.txt my-data2.txt 
      Python is one of the popular programming languages.
      Today many AI/ML Applications are developed using Python.
      Python is also widely preferred for developing the backend application for web.
      bash-3.2$ 
      ```    
  12. Print n specific lines from a file using grep
    - `-A` option prints the searched line and the n lines after the result. `-B` prints the searched line and n lines before the result, and `-C` prints the searched line and n lines after and before the result.

      ```
      bash-3.2$ grep -f patterns.txt my-data2.txt 
      Python is one of the popular programming languages.
      Today many AI/ML Applications are developed using Python.
      Python is also widely preferred for developing the backend application for web.
      bash-3.2$ 
      bash-3.2$ grep -A1 'backend' my-data2.txt 
      Python is also widely preferred for developing the backend application for web.
      bash-3.2$ grep -B1 'backend' my-data2.txt 
      Today many AI/ML Applications are developed using Python.
      Python is also widely preferred for developing the backend application for web.
      bash-3.2$ grep -C1 'backend' my-data2.txt 
      Today many AI/ML Applications are developed using Python.
      Python is also widely preferred for developing the backend application for web.
      bash-3.2$ 
      ```
  13. Search recursively for a pattern in the directory.
    - `-R` option prints the searched pattern in the given directory recursively in all the files.
      ```
      bash-3.2$ grep -REi 'unix|python' 
      ./my-data4.txt:unix is great os. unix was developed in Bell labs.
      ./my-data4.txt:Unix linux which one you choose.
      ./my-data4.txt:uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
      ./my-data3.txt:unix is great os. unix was developed in Bell labs.
      ./my-data3.txt:Unix linux which one you choose.
      ./my-data3.txt:uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
      ./my-data2.txt:Python is one of the popular programming languages.
      ./my-data2.txt:Today many AI/ML Applications are developed using Python.
      ./my-data2.txt:Python is also widely preferred for developing the backend application for web.
      ./my-data.txt:unix is great os. unix was developed in Bell labs.
      ./my-data.txt:Unix linux which one you choose.
      ./my-data.txt:uNix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
      ./patterns.txt:Python
      bash-3.2$ 
      ```    

