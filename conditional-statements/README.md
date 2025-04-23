# Conditional Statements

## The basic syntax of `if..then` statement
- `if <condition>; then <command> fi`
- The condition is depending on its type, surrounded by chain brackets [].
- We can add the commands to be executed when the condition is false using the *else* keyword, or we can use *elif* to check execute other conditions.

## The basic rule of BASH conditions
- When you start writing and using your own conditions, there are some rules you should know to prevent getting errors that are hard to trace.

1. **Always keep spaces between the brackets and actual check/ comparison.** The following won't work:
`if [$foo -ge 3]; then`
Bash will complain about a "missing `]".
    
2. **Always terminate the line before putting a new keyword like "then". **
 - The words *if*, *then*, *else*, *elif* and *fi* are shell keywords, meaning that they cannot share the same line. Put a ";" between the previous statement and the keyword or place the keyword on the start of a new line.
3. It is a good habit to quote string variables if you use them in conditions. because otherwise, they are likely to give trouble if they contain spaces and/or newlines.
   - `if [ "$stringvar" == "tux" ]; then ` 
4. You can invert a condition by putting an "!" in front of it.
   - `if [ ! -f regularfile ]; then `
5. You can combine conditions by using certain operators. For single-bracket syntax that we've been using so far, you can use "-a" for and "-o" for or.
   - `if [ $foo -ge 3 -a $foo -lt 10 ]; then`

## Different condition syntaxes
- Bash features different syntaxes for conditions.
1. `Signle-bracket syntax`
   - *File-based conditions*
     - Allows different kinds of checks on a file. Example
     - `if [ -L symboliclink ]; then`
     - The above condition is true if the file 'symboliclink' exists and is a symbolic link. 
   - *String-based conditions*
     - Allow checks on a string and comparing strings
     - Ex1 : `if [ -z "$emptystring" ]; then` => this condition will be true if $emptystring is an empty string or an uninitialized variable
     - Ex2: `if [ "$stringvar1" == "cheese' ]; then`
   - *Arithmetic (number-based) conditions*
     - Allows comparing integer numbers.
     - Ex: `if [ $num -lt 1 ]; then`
2. **Double-backet Syntax**
   - You may have encountered conditions enclosed in double square brackets already. which looks like this
   - `if [[ "$stringvar" == *string* ]]; then`
   - The double-bracket syntax serves as an enhanced version of the single-bracket syntax; it mainly has the same features, but also some important differences with it.
   1. When comparing strings, the double-bracket syntax features shell globbing. This means that an asterisk ("*") will expand to literally anything, just as you probably know from normal command-line usage. Therefore, if $stringvar contains the phrase "string" anywhere, the condition will be returned true. The globbing will not work if you quote the right string Example: `if [[ "$stringvar" == *[sS]tring* ]]; then`
   2. The word splitting is prevented. Therefore, you could omit placing quotes around string variables and use a condition like following without problems: `if [[ $stringvarwithspaces != foo ]]; then`
   3. Not expanding filenames. In double quote syntax, the filenames will not be expanded.
    consider the below example
    `if [ -a *.sh ]; then` => this condition will return true if one single file in the working directory that has a .sh extension. If there is none, it will return false. If there are several .sh files bash will throw an error ans stop executing the script
     `if [[ -a *.sh ]]; then` => this will only return true if there is file named "*.sh" in current working directory no matter what other .sh files exists.
   4. Combining expressions, the && and || operators, we can combine multiple conditions as follows in double-bracket syntax
   `if [[ $num -gt 5 && $num -lt 100 || "$name" == eswar ]]; then`
   5. The double-bracket syntax allows regex pattern matching using the "=~" operator.
3. **Double-parenthesis syntax**
   - There is also another syntax for arithmetic conditions, most likely adopted from the Korn shell
   - `if (( $num <= 5 )); then`
   - It features all the normal operators, like "==", "<", ">", ">=", "<=" and "||", "&&" to combine conditions.
   
   
## Table of Conditions
### File Based Conditions

| Condition                        | True If                                                                         | Example / Explenation                                                                                                                                                                                                                                  |
----------------------------------|---------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `[ -a existingfile ]`            | file `existingfile` exists                                                      | `if [ -a tmp.tmp ]; then rm --f tmp.tmp fi`                                                                                                                                                                                                            |
| `[ -b blockspecialfile ]`        | file `blovkspecialfile` exists and is a block special                           | Block special files are special kernel files found in /dev, mainly used for ATA devices like hard disks, cd-roms and floppy discks. `if [ -b /dev/fd0 ]; then ddif=floppy.img of=/dev/fd0 # write an image to floppy fi;`                              |
| `[ -c ] characterspecialfile`    | file `characterspecialfile` exists and is character specila                     | Charccter special files are kernel files found in /dev, used for all kinds of purposes. `if [ -c /dev/dsp ]; then cat raw.wav > dev.dsp fi`                                                                                                            | 
| `[ -d direcory ]`                | file `direcory` exists and is a direcotry                                       | In unix-style, direcotires are special kinds of files. `if [ -d ~/.kde ]; then echo "You seem to be a kde user" fi`                                                                                                                                    |
| `-e existingfile`                | file `existingfile` exists                                                      | (same as -a)                                                                                                                                                                                                                                           |
| `-f regularfile`                 | file `regularfile` exists and is a reguar file                                  | A regular file is neither a block or character special file nor a directory. `if [ -f ~/.bashrc ]; then source ~/.bashrc fi`                                                                                                                           |
| `-g sgidfile`                    | file `sgidfile` exists and is set-group-ID                                      | When the SGID-bit is set on a directory, all files created in that directory will inherit the group of the direotory. `if [ -g . ]; then echo "Created files are inheriting the group $(ls -ld \| awk 'print $4') from the working direcory"`          |
| `-G filesownedbyeffectivegroup`  | file `fileownedbyeffectivegroup` exists and is owned by the effective group ID  | The effective group is id the primary gorup id of the user. `if [ ! -G file ]; then chgrp $(id -g) file # change the group if its not the effective one fi`                                                                                            |
| `-h symboliclink`                | file `symboliclink` exists and it's a symbolic link                             | `if [ -h $pathtofile ]; then pathtofile=$(readlink -e $pathtofile) # making sure that pathtoffile contauns the actual file path fi`                                                                                                                    |
| `[ -k stickyfile ]`              | file `stickyfile` exists and has its sticky bit set.                            | The sticky bit has got a quite a history, but is now used to prevent world-wriable directories from having their contents deletable by anyone. `if [ ! -k /tmp ]; then echo "Warning anyone can delete and/or rename your files in /tmp directory" fi` |
| `[ -L symboliclink ]`            | file `symboliclink` exists and is a symbolic link                               | same as -h option                                                                                                                                                                                                                                      |
| `[ -N modifiedsincelastread ]`   | file `modifiedsincelastread` exists and was modified since last read            | `if [ -N /etc/crontab ]; then killall -HUP crond # SIGHUP makes crond reread all crontabs fi`                                                                                                                                                          |
| `[ -O fileownedbyeffectiveuser]` | file `fileownedbyeffectiveuser` exists and is owned by the user executing the script | `if [ -O file]; then chmod 600 file # make the file private fi`                                                                                                                                                                                        |
| `[ -p namedpipe ]`               | file `namedpipe` exists and is a named pipe                                     | A named pipe is a file in /dev/fd/ that can be read just once. <br/>`if [ -p file ]; >then cp $file tmp.tmp <br/>read file="tmp.tmp" <br/>fi`                                                                                                          |
| `[ -r readabalefile]`            | file `readablefile` exists and is readable to the script                        | `if [ -r file ]; then content=$(cat file) fi`                                                                                                                                                                                                          |
| `[ -s nonemptyfile ]` | file `nonemptyfile` exists and has a size of morethan 0 bytes                   | `if [ -s logfile ]; then gzip logfile # backup the existing logfile touch logile # create a new logfile fi`                                                                                                                                            |
| `[ -S socket]` | file `socket` exists and is a socket file                                       | A socket file is used for inter process communication, and features an interface similar to a network connection. `if [ -S /var/lib/mysql/mysql.sock ]; then mysql -socket=/var/lib/mysql/mysql.sock fi`                                               |
| `[ -t openterminal ]` | file descriptor open terminal exists and refers to an openterminal              | Visually everything is done using files on Linux, and the terminal is no exception. `if [ -t /dev/pts/3 ]; then echo -e "Hello there message from terminal $(tty) to you" ? /dev/pts/3 # anyone who using  the terminal see this message fi`           |
| `[ -u sudofile ]` | file `sudofile` exists an is set-user-ID                                        | Setting the suid-bit on a dile causes exception of that file to be done with the credentials of the owner of the file, not of the executing user. `if [ -u executable]; then then echo "Running program as user $(ls -l executable \| awk '{print $3}' )" fi`     |
| `[-w writablefile]` | file `writablefile` exists and is writable to the script                        | `if [ -w /dev/hda ]; then grub-install /dev/hda fi` |
| `[ -x ececutable ]` |file `executablefile` exists and is executable foe the script                    | NOTE: the execute permissions on a direcotry means that it's searchable`if [ -x /root ]; then echo "You can view the contents of the roor direcotry" fi ` |
| `[ newfile -nt olderfile ]` | file `newfile` was changed more recently than `olderfile` or if `newfile` exists and `olderfile` doesn't | `if [ story1.txt -nt story.txt ]; then echo "The story1.txt is a newer than story.txt" fi` |
| `[ olderfile -ot newerfile ]` | file `olderfile` changed a long ago than `newerfile`, or if `newerfile` exists and `olderfile` doesn't | `if [ /mnt/remote/remotefile -ot localfile ]; then cp -f localfile /mnt/remote/remotefile fi` |
| `[ same -ef file ]` | file `same` and file `file` refer to the same device/inode number | `if [ /dev/cdrom -ef /dev/dvd ]; then echo "Your primary cd drive appears to read dvd's too" fi ` |

### String based conditions
| Condition                | True if | Example / Explenation                                                                                                                                                                                                                               |
|--------------------------| ------- |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `[ string1 == string2 ]` | string1 is equal to string2 | `if [ $1 == "moo" ]; then echo $cow fi` you can also use `=` to check the equality between strings                                                                                                                                                  |
| `[ STRING1 != STRING2 ]` | STRING1 is not equal to STRING2 | `if [ $userinput != $password ]; then echo "Access Denied! Wrong Passwprd" exit 1 fi`                                                                                                                                                               |
| `[ STRING1 > STRING2 ]` | STRING1 sorts after STRING2 in the current locale | Used to compare strings                                                                                                                                                                                                                             |
| `[ -n NONEMPTYSTRING ]` | NONEMPTYSTRING has a length of more than zero | This condition only accepts valid strings, so be sure to quote anything you gave to it. `if [ -n "$userinput" ]; then input=parse($userinput) # only parse if user have given some input. fi` NOTE: If the -n is omitted, this will behave the same |
| `[ -z EMPTYSTRING ]` | EMPTYSTRING is an empty string | This condition also accepts non-string input, like an uninitialized variable. `if [ -z $uninitializedvar ]; then uninitializedvar="initialized" fi `                                                                                                |
| Doubrl-bracket syntax only `[[ STRING1 =~ REGEXPATTERN ]]` | STRING macthed REGEXPATTERN | we can use this condition to perform regex matching. `if [[ "$email" +~ "b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}b" ]]; then echo "$email" is balid fi`                                                                                      |

### Arithmetic Conditions
| Condition           | True If                               | Example / Explenation |
|---------------------|---------------------------------------| ----------------------|
| `[ NUM1 -eq NUM2 ]` | NUM1 is equal to NUM2                 | These conditions only accept integer numbers, Strings will be converted to interger numbers. |
| `[ NUM1 -ne NUM2 ]` | NUM1 is not equal to NUM2             | |
| `[ NUM1 -gt NUM2 ]` | NUM1 is greater to NUM2               | |
| `[ NUM1 -lt NUM2 ]` | NUM1 is less than to NUM2             | |
| `[ NUM1 -ge NUM2 ]` | NUM1 is greater than or equal to NUM2 | |
| `[ NUM1 -le NUM2 ]` | NUM1 is less than or equal to NUM2    | |
