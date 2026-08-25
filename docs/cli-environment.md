# 2. CLI Environment

!!! note
    This page is structured from the source material and is pending command validation.

!!! abstract
    Define the shell, use CLI commands and help, work with variables and streams, chain commands, and edit files with nano.

The shell is a command-language interpreter for interacting with the operating system. It receives typed commands and sends them to the operating system for execution. Ubuntu Server installs `bash` and `dash` by default; `bash` is the default shell. System scripts declare the shell they use.

- `bash`: Bourne Again Shell
- `dash`: Debian Almquist Shell

The user's default shell is defined in `/etc/passwd`. The distribution-agnostic command-line interface (CLI) provides more control and options than a graphical user interface. A terminal emulator provides access to the shell and normally displays a prompt containing the username, host name, and a dollar sign.

![Shell](assets/shell.png)

Commands can be executable programs, shell built-ins such as `cd`, shell functions, or aliases. Terminal text can be copied with the mouse by highlighting it, then using the middle mouse button or the paste option in the terminal.

## :material-book-open-page-variant-outline: 2.1 Secure Shell

Secure Shell (SSH) connects to remote computers and allows interactive program execution. SSH is the common method for secure remote Linux-server access: it encrypts the session and supports authentication, allowing one PC to manage multiple computers.

Use `ssh remote_host` when the remote username matches the local user, or `ssh user@remote_host` when it differs. Use `exit` to end an SSH session. To run a command remotely, use `ssh remote_host command_to_run`. These are generic connection forms, not executable lab commands.

## :material-book-open-page-variant-outline: 2.2 CLI Commands

Common CLI commands can also be used in scripts to automate tasks.

**Navigating the filesystem:** `cd` changes directory, `ls` lists files, `mkdir` creates a directory, `pwd` prints the working directory, and `rmdir` removes a directory.

**Manipulating the filesystem:** `chgrp` changes group ownership, `chmod` changes file mode bits, `chown` changes file owner and group, `df` reports filesystem space use, and `du` estimates file space use.

**Searching the filesystem:** `find` searches for files matching a pattern, `locate` finds files by name, and `which` locates a command.

**Searching file contents:** `file` determines file type, `grep` prints matching lines, and `less` and `more` view content.

**Manipulating file contents:** `cp` copies, `ln` creates a symbolic link, `mv` moves or renames, `rm` removes, and `touch` changes timestamps.

**Text processing:** `cat` concatenates files, `gawk` scans and processes patterns, `head` displays the first part of output, `tail` displays the last part, and `tee` writes input to standard output and a file.

### :material-application-edit-outline: 2.2.1 CLI Commands Lab

1. Use `man` to identify four `ls` options.

```bash
# Open the ls manual page
man ls
```
??? example "Expected result"
    `man` opened the `ls` page and exited normally after `q`.

    ```text
    man: can't set the locale; make sure $LC_* and $LANG are correct
    ```

`-a, --all` includes entries beginning with `.`, `-h, --human-readable` prints readable sizes with `-l` or `-s`, `-l` uses long format, and `-t` sorts by newest modification time first.

2. Create `mydir1`, enter it, create and enter `mydir2`, return to its parent, then remove `mydir2`.

```bash
# Create mydir1
mkdir mydir1
```
??? example "Expected result"
    No output.

```bash
# Enter mydir1
cd mydir1
```
??? example "Expected result"
    No output.

```bash
# Create mydir2
mkdir mydir2
```
??? example "Expected result"
    No output.

```bash
# Enter mydir2
cd mydir2
```
??? example "Expected result"
    No output.

```bash
# Return to the parent of mydir2
cd ..
```
??? example "Expected result"
    No output.

```bash
# Remove the empty mydir2 directory
rmdir mydir2
```
??? example "Expected result"
    No output.

3. Create `file1`, copy it to `file2`, return to the parent of `mydir1`, create `mynewdir`, and copy `mydir1` contents into it.

```bash
# Create file1
touch file1
```
??? example "Expected result"
    No output.

```bash
# Copy file1 to file2
cp file1 file2
```
??? example "Expected result"
    No output.

```bash
# Return to the parent directory
cd ..
```
??? example "Expected result"
    No output.

```bash
# Create mynewdir
mkdir mynewdir
```
??? example "Expected result"
    No output.

```bash
# Copy mydir1 contents into mynewdir
cp -a mydir1/* mynewdir
```
??? example "Expected result"
    No output.

4. Type `ls my` and press Tab twice to inspect shell completion choices.

```bash
# Begin a listing command for tab completion
ls my*
```
??? example "Expected result"
    ```text
    mydir1:
    file1  file2

    mynewdir:
    file1  file2
    ```

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.3 Getting Help

`man` is the system manual pager. Its argument identifies a program, utility, or function page. A page can occur in multiple sections; by default, the first matching section in a predefined order is displayed. `man man` documents sections, display options, exit status, environment variables, and the `SEE ALSO` section.

Manual-page sections are: 1 executable programs or shell commands; 2 system calls; 3 library calls; 4 special files, usually in `/dev`; 5 file formats and conventions; 6 games; 7 miscellaneous material; 8 system-administration commands; and 9 non-standard kernel routines.

Use Enter for one line down, Space for one page down, `g` for the top, `G` for the bottom, `h` or `H` for help, `q` to quit, or arrow keys to move through a manual page.

### :material-application-edit-outline: 2.3.1 Getting Help Lab

At the prompt, try `man`, then `man man`; scroll through the page, use the listed navigation commands, and press `h` while viewing a page.

```bash
# Run man without a page argument
man
```
??? example "Expected result"
    ```text
    man: can't set the locale; make sure $LC_* and $LANG are correct
    What manual page do you want?
    For example, try 'man man'.
    ```

```bash
# Open the man manual page
man man
```
??? example "Expected result"
    The page was opened in the terminal and the help interaction was attempted before normal exit.

    ```text
    man: can't set the locale; make sure $LC_* and $LANG are correct
    man: can't resolve man7/groff_man.7
    ```

```bash
# Open the ls manual page
man ls
```
??? example "Expected result"
    `man` opened the page in the terminal and exited normally after the requested navigation keys.

    ```text
    man: can't set the locale; make sure $LC_* and $LANG are correct
    ```

Then find the `rsync -p` option.

```bash
# Open the rsync manual page
man rsync
```
??? example "Expected result"
    `man` opened the page in the terminal and exited normally after `q`.

    ```text
    man: can't set the locale; make sure $LC_* and $LANG are correct
    ```

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.4 Shell Environment Variables

A shell environment variable is a named character string that stores information such as numbers, text, filenames, devices, or credentials. `PATH` tells the shell which directories to search for executable files. Use `env` or `printenv` to list defined environment variables. Common variables are `SHELL` for the default shell, `USER` for the logged-in user, `PWD` for the current directory, and `HOME` for the current user's home directory.

To run a command outside `PATH`, precede it with a relative or full path, such as `. /mycommand.sh` or `/home/myuser/mycommand.sh`. Replace the example paths with a known script before running either form.

### :material-application-edit-outline: Naming Variables

By convention, variable names are uppercase. They can use letters, numbers, and underscores, but cannot begin with a number.

```bash
# Export a terminal-type variable
export TERM=xterm-256color
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: Setting and Unsetting Variables

Define variables with `name=value`; they are local until the shell exits. Use `unset` or an empty value to undefine them. Use `export` to make a variable available to child processes.

```bash
# Set local variables
NAME=Marvin
```
??? example "Expected result"
    No output.

```bash
# Set a variable containing multiple values
NAMES="Marvin Ford Arthur Trillian"
```
??? example "Expected result"
    No output.

```bash
# Unset NAME
unset NAME
```
??? example "Expected result"
    No output.

```bash
# Set NAME to an empty value
NAME=
```
??? example "Expected result"
    No output.

```bash
# Export NAME to child processes
export NAME=Marvin
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: Manipulating Variables

```bash
# Display NAME
echo $NAME
```
??? example "Expected result"
    ```text
    Marvin
    ```

```bash
# Append a value to NAMES
NAMES="$NAMES Zaphod"
```
??? example "Expected result"
    No output.

```bash
# Mark NAMES as read-only
readonly NAMES
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: Special Variables

Special variables can be referenced but not assigned. `$?` is the exit status of the last command, `$$` is the PID of the current shell, and `$!` is the PID of the last background command. Use them as part of another command, for example `echo $?`; entering a parameter token alone makes the expanded value a command name.

### :material-application-edit-outline: 2.4.1 Shell Environment and Variables Lab

1. View `PATH` and environment variables.

```bash
# Display the PATH variable
echo $PATH
```
??? example "Expected result"
    ```text
    /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
    ```

```bash
# List environment variables
env
```
??? example "Expected result"
    ```text
    SHELL=/bin/bash
    NAME=Marvin
    PWD=/home/ubuntu
    HOME=/home/ubuntu
    TERM=xterm-256color
    USER=ubuntu
    ```

    The environment also includes session-specific variables and locale assignments.

2. Consider the purpose of `SHELL`. Set and view `MYNAME`.

```bash
# Set MYNAME
MYNAME="john"
```
??? example "Expected result"
    No output.

```bash
# Display MYNAME
echo $MYNAME
```
??? example "Expected result"
    ```text
    john
    ```

3. Set `PART1` and `PART2`, then display both.

```bash
# Set the first name fragment
PART1="My name is"
```
??? example "Expected result"
    No output.

```bash
# Set the second name fragment
PART2="john"
```
??? example "Expected result"
    No output.

```bash
# Display the first fragment
echo $PART1
```
??? example "Expected result"
    ```text
    My name is
    ```

```bash
# Display the second fragment
echo $PART2
```
??? example "Expected result"
    ```text
    john
    ```

4. Combine the variables into `STUDENTNAME` and display it.

```bash
# Combine the name fragments
STUDENTNAME=$PART1$PART2
```
??? example "Expected result"
    No output.

```bash
# Display STUDENTNAME
echo $STUDENTNAME
```
??? example "Expected result"
    ```text
    My name isjohn
    ```

5. Undefine the variables, then confirm they are empty.

```bash
# Unset PART1
unset PART1
```
??? example "Expected result"
    No output.

```bash
# Unset PART2
unset PART2
```
??? example "Expected result"
    No output.

```bash
# Unset STUDENTNAME
unset STUDENTNAME
```
??? example "Expected result"
    No output.

```bash
# Confirm PART1 is undefined
echo $PART1
```
??? example "Expected result"
    No output.

```bash
# Confirm PART2 is undefined
echo $PART2
```
??? example "Expected result"
    No output.

```bash
# Confirm STUDENTNAME is undefined
echo $STUDENTNAME
```
??? example "Expected result"
    No output.

6. Set an unexported variable, create a subshell, and inspect it.

```bash
# Set x in the current shell
x=5
```
??? example "Expected result"
    No output.

```bash
# Display x in the current shell
echo $x
```
??? example "Expected result"
    ```text
    5
    ```

```bash
# Create a subshell
bash
```
??? example "Expected result"
    ```text
    ubuntu@ubuntu:~$
    ```

```bash
# Display x in the subshell
echo $x
```
??? example "Expected result"
    No output.

```bash
# Exit back to the original shell
exit
```
??? example "Expected result"
    No output.

7. Export `x` and inspect it in a subshell.

```bash
# Export x
export x=5
```
??? example "Expected result"
    No output.

```bash
# Display exported x
echo $x
```
??? example "Expected result"
    ```text
    5
    ```

```bash
# Create a subshell
bash
```
??? example "Expected result"
    ```text
    ubuntu@ubuntu:~$ exit
    ```

```bash
# Display x in the subshell
echo $x
```
??? example "Expected result"
    ```text
    5
    ```

```bash
# Exit the subshell
exit
```
??? example "Expected result"
    No output.

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.5 Standard Streams

![Standard streams](assets/streams.png)

In computer programming, standard streams are preconnected input and output communication channels between a computer program and its environment when it begins execution. The three I/O connections are standard input (STDIN), standard output (STDOUT), and standard error (STDERR).

### :material-application-edit-outline: Redirection

Commands normally take input from the terminal or STDIN through the keyboard. Commands normally send output back to the terminal or STDOUT through the screen. I/O redirection allows commands to receive input from other files or commands, and to send output to files or other commands.

#### Output Redirection

The output of a command can be sent to a file with `>` followed by a filename. If the filename does not exist, it is created. If it exists, it is overwritten. Use two greater-than characters (`>>`) followed by a filename to append command output to an existing file.

```bash
# Write a detailed listing to a file
ls -al > ~/all_files.txt
```
??? example "Expected result"
    No output.

```bash
# Append a /tmp listing to a file
ls -al /tmp >> ~/all_files.txt
```
??? example "Expected result"
    No output.

```bash
# Combine file contents into one file
cat file1.txt file2.txt file3.txt > combined-file.txt
```
??? example "Expected result"
    ```text
    cat: file1.txt: No such file or directory
    cat: file2.txt: No such file or directory
    cat: file3.txt: No such file or directory
    ```

```bash
# Discard ping output
ping -c 2 www.xxx.yyy.zzz > /dev/null
```
??? example "Expected result"
    ```text
    ping: www.xxx.yyy.zzz: Name or service not known
    ```

#### Input Redirection

A command can receive input from a file with `<` followed by a filename. When two less-than characters (`<<`) are used, a delimiter must be defined immediately after `<<`. For example, `wc -l << EOF` starts a here-document; the shell reads input until it reaches a line containing that delimiter.

```bash
# Count lines from the passwd file
wc -l < /etc/passwd
```
??? example "Expected result"
    ```text
    33
    ```

This counts lines one at a time until it reaches the `EOF` delimiter.

#### Piped Redirection

The output of one command can be sent directly to another command as input with `|`. This is called a pipe or piping.

```bash
# Page through a detailed listing
ls -al | less
```
??? example "Expected result"
    ```text
    -rw-rw-r--  1 ubuntu ubuntu 387636 Aug 25 07:23 all_files.txt
    -rw-rw-r--  1 ubuntu ubuntu      0 Aug 25 07:23 combined-file.txt
    drwxrwxr-x  2 ubuntu ubuntu   4096 Aug 25 07:10 mydir1
    ```

```bash
# Filter a detailed listing
ls -al | grep string
```
??? example "Expected result"
    No output.

#### Advanced Redirection

The three I/O types have their own identifiers, called file descriptors:

- `0`: Standard Input (STDIN), data fed into the program.
- `1`: Standard Output (STDOUT), data printed by the program, which defaults to the terminal.
- `2`: Standard Error (STDERR), error messages, which default to the terminal.

These descriptors can redirect a data stream from its normal destination.

```bash
# Write normal output and errors to separate files
ls -al /r* > /tmp/list.txt 2>/tmp/errors.txt
```
??? example "Expected result"
    No output.

```bash
# Write normal output and errors to one file
ls -al /r* > /tmp/list.txt 2>&1
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: 2.5.1 Redirection Lab

```bash
# Save a directory listing to mylist
ls > mylist
```
??? example "Expected result"
    No output.

```bash
# Display the fifth item in /usr/bin listing order
ls /usr/bin | head -5 | tail -1
```
??? example "Expected result"
    ```text
    aa-exec
    ```

```bash
# Find list entries in mylist
grep list mylist
```
??? example "Expected result"
    ```text
    mylist
    ```

```bash
# Display the newest entries in /usr/bin
ls -lt /usr/bin | head
```
??? example "Expected result"
    ```text
    total 118296
    -rwxr-xr-x 1 root root        1622 Jul 31 20:56 acpidbg
    -rwxr-xr-x 1 root root        1622 Jul 31 20:56 cpupower
    ```

```bash
# Display the largest directory sizes
du | sort -nr | head
```
??? example "Expected result"
    ```text
    1016	.
    16	./.local
    12	./.local/share
    ```

```bash
# Create redirection.txt with a here-document
cat >redirection.txt <<EOF
Hello world!
EOF
```
??? example "Expected result"
    No output.

```bash
# Find examine references in less help
less --help | grep -i examine
```
??? example "Expected result"
    ```text
      :e [_file]            Examine a new file.
      :n                *  Examine the (N-th) next file from the command line.
    ```

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.6 Command Chaining

Command chaining combines commands on one command line. Operators include `&` for background execution, `;` for sequential execution, `&&` for execution after success, `||` for execution after failure, `!` for negation, `|` for piping, `{}` for grouping, `()` for precedence, and `\` to continue a command or escape special characters.

```bash
# Run three commands sequentially
ls; pwd; whoami
```
??? example "Expected result"
    ```text
    2014-00   Dp-4.txt  Hi-7.txt  Lc-0.txt  Ov-3.txt  So-6.txt  Wh-9.txt
    2014-01   Dp-5.txt  Hi-8.txt  Lc-1.txt  Ov-4.txt  So-7.txt  Wi-0.txt
    2014-02   Dp-6.txt  Hi-9.txt  Lc-2.txt  Ov-5.txt  So-8.txt  Wi-1.txt
    2014-03   Dp-7.txt  Hj-0.txt  Lc-3.txt  Ov-6.txt  So-9.txt  Wi-2.txt
    2014-04   Dp-8.txt  Hj-1.txt  Lc-4.txt  Ov-7.txt  Sp-0.txt  Wi-3.txt
    2014-05   Dp-9.txt  Hj-2.txt  Lc-5.txt  Ov-8.txt  Sp-1.txt  Wi-4.txt
    2014-06   Dq-0.txt  Hj-3.txt  Lc-6.txt  Ov-9.txt  Sp-2.txt  Wi-5.txt
    2014-07   Dq-1.txt  Hj-4.txt  Lc-7.txt  Ow-0.txt  Sp-3.txt  Wi-6.txt
    ```

    The complete listing is long and changes as lab files are created; it was followed by `/home/ubuntu` and `ubuntu`.

```bash
# Report whether a host can be pinged
ping -c1 google.com && echo "That's good, able to ping google.com" || \
echo "That's bad unable to ping google.com"
```
??? example "Expected result"
    ```text
    PING google.com (142.251.110.139) 56(84) bytes of data.
    1 packets transmitted, 1 received, 0% packet loss, time 0ms
    That's good, able to ping google.com
    ```

## :material-book-open-page-variant-outline: 2.7 Return Values and Expansion

Successful commands return exit code `0`; unsuccessful commands should return a non-zero code. `$?` stores the last command's exit status. The shell resolves tokens through expansions, including brace, tilde, parameter, command, arithmetic, and wildcard expansion.

### :material-application-edit-outline: Brace Expansion

Brace expansion generates strings from comma-separated values or ranges and can be nested.

```bash
# Demonstrate brace expansion
echo sp{el,il,al}
```
??? example "Expected result"
    ```text
    spel spil spal
    ```

```bash
# Create directories using brace ranges
mkdir {2014..2016}-0{0..9} {2014..2016}-{10..12}
```
??? example "Expected result"
    ```text
    mkdir: cannot create directory '2014-00': File exists
    mkdir: cannot create directory '2014-01': File exists
    mkdir: cannot create directory '2014-02': File exists
    ```

    The remaining requested directories already existed and produced the same error.

```bash
# Create files using brace ranges
touch file-{A..Z}{a..z}-{0..9}
```
??? example "Expected result"
    No output.

```bash
# Create text files using brace ranges
touch {A..Z}{a..z}-{0..9}.txt
```
??? example "Expected result"
    No output.

```bash
# Remove files with selected extensions
rm filename.{pl,sh,py,c}
```
??? example "Expected result"
    ```text
    rm: cannot remove 'filename.pl': No such file or directory
    rm: cannot remove 'filename.sh': No such file or directory
    rm: cannot remove 'filename.py': No such file or directory
    rm: cannot remove 'filename.c': No such file or directory
    ```

### :material-application-edit-outline: Tilde Expansion

Tilde expansion can resolve home directories, the current working directory, and the previous working directory. It occurs only at the beginning of a word or as a separate word.

```bash
# Change to the current user's home directory
cd ~
```
??? example "Expected result"
    No output.

```bash
# Change to ubuntu's home directory
cd ~ubuntu
```
??? example "Expected result"
    No output.

```bash
# Create hello.txt in the current user's home directory
echo hello >~/hello.txt
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: Shell Parameter and Variable Expansion

`$` introduces parameter expansion, command substitution, or arithmetic expansion. Braces protect a variable name from adjacent characters. `${!name}` performs indirect expansion, and a default can be assigned while expanding an unset variable.

```bash
# Display the configured shell
echo $SHELL
```
??? example "Expected result"
    ```text
    /bin/bash
    ```

```bash
# Store the current date in D
D=`date`
```
??? example "Expected result"
    No output.

```bash
# Display D
echo $D
```
??? example "Expected result"
    ```text
    Tue Aug 25 07:29:19 UTC 2026
    ```

```bash
# Compare braced and unbraced variable expansion
echo ${D}d vs echo $Dd
```
??? example "Expected result"
    ```text
    Tue Aug 25 07:29:19 UTC 2026d vs echo
    ```

The environment-dependent pattern `echo ${!LC*} vs echo $LC*` compares variable names selected by indirect expansion with their expanded locale values. Its result depends on the session locale configuration.

```bash
# Set TODAY during expansion when it is unset
echo ${TODAY:=`date +%A`}
```
??? example "Expected result"
    ```text
    Tuesday
    ```

### :material-application-edit-outline: Command Substitution

Command substitution replaces a command with its standard output. The forms are `$(command)` and backticks; trailing newlines are removed.

```bash
# Display the date using command substitution
echo "The date and time is: $(date)"
```
??? example "Expected result"
    ```text
    The date and time is: Tue Aug 25 07:32:38 UTC 2026
    ```

```bash
# Display the date using backticks
echo "The date and time is `date`"
```
??? example "Expected result"
    ```text
    The date and time is Tue Aug 25 07:32:38 UTC 2026
    ```

```bash
# Display locale environment assignments
echo $(env | grep ^LC_)
```
??? example "Expected result"
    ```text
    LC_ADDRESS=ro_RO.UTF-8 LC_NAME=ro_RO.UTF-8 LC_MONETARY=ro_RO.UTF-8 LC_PAPER=ro_RO.UTF-8 LC_IDENTIFICATION=ro_RO.UTF-8 LC_TELEPHONE=ro_RO.UTF-8 LC_MEASUREMENT=ro_RO.UTF-8 LC_NUMERIC=ro_RO.UTF-8
    ```

```bash
# Display locale assignments one per line
printf "%s\n" $(env | grep ^LC_)
```
??? example "Expected result"
    ```text
    LC_ADDRESS=ro_RO.UTF-8
    LC_NAME=ro_RO.UTF-8
    LC_MONETARY=ro_RO.UTF-8
    LC_PAPER=ro_RO.UTF-8
    LC_IDENTIFICATION=ro_RO.UTF-8
    LC_TELEPHONE=ro_RO.UTF-8
    LC_MEASUREMENT=ro_RO.UTF-8
    LC_NUMERIC=ro_RO.UTF-8
    ```

### :material-application-edit-outline: Arithmetic Expansion

Arithmetic expansion evaluates an arithmetic expression and substitutes the result. It works with integers. All tokens in the expression undergo parameter expansion, command substitution, and quote removal. Variables within arithmetic expansion can, in some cases, be used with or without `$`.

| Operator | Meaning |
| --- | --- |
| `+` | Addition |
| `-` | Subtraction |
| `++` | Increment by 1 |
| `--` | Decrement by 1 |
| `+=` | Addition assignment |
| `-=` | Subtraction assignment |
| `*` | Multiplication |
| `/` | Division |
| `*=` | Multiplication assignment |
| `/=` | Division assignment |
| `%=` | Remainder assignment |
| `%` | Remainder |
| `!=` | Inequality evaluation |
| `==` | Equality evaluation |
| `>` | Greater-than comparison |
| `<` | Less-than comparison |
| `>=` | Greater-than or equal comparison |
| `<=` | Less-than or equal comparison |
| `,` | Expression separator |
| `**` | Exponentiation |

### :material-application-edit-outline: Wildcard Expansion

The shell provides special characters to specify groups of filenames. These characters are called wildcards. Wildcards select filenames or directories based on character patterns and can be used with any command that accepts filename arguments.

| Wildcard | Meaning |
| --- | --- |
| `*` | Matches any one or more characters |
| `?` | Matches any single character |
| `[...]` | Matches any one of the enclosed characters |
| `[[:alnum:]]` | Matches any alphanumeric character |
| `[[:alpha:]]` | Matches any alphabetic character |
| `[[:digit:]]` | Matches any numeric character |
| `[[:upper:]]` | Matches any uppercase alpha character |
| `[[:lower:]]` | Matches any lowercase alpha character |
| `[![:alnum:]]` | Matches any non-alphanumeric character |
| `[![:alpha:]]` | Matches any non-alphabetic character |
| `[![:digit:]]` | Matches any non-numeric character |
| `[![:upper:]]` | Matches any non-uppercase alpha character |
| `[![:lower:]]` | Matches any non-lowercase alpha character |

Wildcard listing forms demonstrate pattern syntax. Run them only in a directory with a manageable set of files:

- `ls -ld *` lists metadata for all entries.
- `ls -ld *.log` lists metadata for log files.
- `ls -ld [abc]*` lists metadata for names starting with `a`, `b`, or `c`.
- `ls -ld *.??` lists names with a two-character suffix.
- `ls -ld *.log.[[:digit:]]` lists log names ending with a digit extension.
- `ls -ld *.[[:digit:]].??` lists names with digit and two-character extensions.
- `ls -ld *[![:alnum:]]` lists names ending in a non-alphanumeric character.

### :material-application-edit-outline: 2.7.1 Chaining and Expansion Lab

Try these chaining examples in `/tmp`; the fallback examples demonstrate `||`.

```bash
# Change to /tmp, then list it
cd /tmp; ls -al
```
??? example "Expected result"
    ```text
    total 64
    drwxrwxrwt 14 root root 4096 Aug 25 07:29 .
    drwxrwxr-x  2 ubuntu ubuntu 4096 Aug 25 07:05 chapter2-validation
    ```

```bash
# List /tmp only after changing to it
cd /tmp && ls -al
```
??? example "Expected result"
    ```text
    total 64
    drwxrwxrwt 14 root root 4096 Aug 25 07:29 .
    ```

```bash
# Report a failed directory change
cd /tmp || echo "Could not change to /tmp"
```
??? example "Expected result"
    No output.

```bash
# List /tmp or report failure
cd /tmp && ls -al || echo "Could not change to /tmp"
```
??? example "Expected result"
    ```text
    total 64
    drwxrwxrwt 14 root root 4096 Aug 25 07:29 .
    ```

```bash
# Return home after a failed directory change
cd /tmp && ls -al || { echo "Could not change to /tmp. Going home instead"; cd ~; pwd; }
```
??? example "Expected result"
    ```text
    total 64
    drwxrwxrwt 14 root root 4096 Aug 25 07:29 .
    ```

```bash
# List /tmp or count entries in /tmp
(cd /tmp && ls -al) || (cd /tmp && { ls -al | wc -l; })
```
??? example "Expected result"
    ```text
    total 64
    drwxrwxrwt 14 root root 4096 Aug 25 07:29 .
    ```

The extglob form `ls -ld /var/log/!(*.gz)` lists uncompressed log files when extended globbing is enabled. Its output varies by host log retention.

```bash
# List the last ten entries in /etc sort order
ls -ltr /etc | tail
```
??? example "Expected result"
    ```text
    -rw-r--r-- 1 root root       1716 Feb 19  2025 passwd
    -rw-r--r-- 1 root root      22103 Aug 25 06:14 ld.so.cache
    ```

```bash
# Find ls commands in shell history
history | grep ls
```
??? example "Expected result"
    No output.

```bash
# Set a filename variable
file=data.txt
```
??? example "Expected result"
    No output.

```bash
# Remove the shortest suffix beginning with a period
echo ${file%.*}
```
??? example "Expected result"
    ```text
    data
    ```

```bash
# Remove the shortest prefix ending with a period
echo ${file#*.}
```
??? example "Expected result"
    ```text
    txt
    ```

```bash
# Set X for arithmetic examples
X=5
```
??? example "Expected result"
    No output.

```bash
# Add one to X
echo $((X+1))
```
??? example "Expected result"
    ```text
    6
    ```

```bash
# Add one to X with an explicit variable expansion
echo $(($X+1))
```
??? example "Expected result"
    ```text
    6
    ```

```bash
# Compare X with 15
echo $((X>15))
```
??? example "Expected result"
    ```text
    0
    ```

```bash
# Change to the command-binary directory
cd /usr/bin
```
??? example "Expected result"
    No output.

The glob forms `ls m*` and `ls *.???` demonstrate prefix and fixed-length-suffix matching in `/usr/bin`; their results vary with installed packages.

```bash
# Return to the home directory
cd ~
```
??? example "Expected result"
    No output.

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.8 Introduction to nano

`nano` is a small, easy-to-learn text editor with interactive search and replace, go-to line and column, auto-indentation, feature toggles, internationalization, and filename tab completion. It is installed by default in Ubuntu and works with `sudo`.

```bash
# Start nano for a new file
nano
```
??? example "Expected result"
    ```text
    GNU nano 7.2                    New Buffer
    [ Welcome to nano.  For basic help, type Ctrl+G. ]
    ^G Help  ^O Write Out  ^W Where Is  ^X Exit
    ```

To edit an existing file, replace the placeholder in `nano /path/filename` with its actual path.

Nano displays commands in its editor window. Press `Ctrl+g` for additional commands.

### :material-application-edit-outline: 2.8.1 nano Lab

Create and edit files with nano, reviewing the commands available in the editor.

```bash
# Change to the home directory
cd ~
```
??? example "Expected result"
    No output.

```bash
# Create and edit fileone.txt
nano fileone.txt
```
??? example "Expected result"
    ```text
    GNU nano 7.2                    fileone.txt
    [ New File ]
    ^G Help  ^O Write Out  ^W Where Is  ^X Exit
    ```

Type `The quick brown fox jumped over the lazy dog.`. Copy and paste it ten times using the nano shortcuts:

```text
Ctrl+K
Ctrl+U
```

Practice moving through the file, then save and close it:

```text
Ctrl+X
```

Create `shells.txt`:

```bash
# Create and edit shells.txt
nano shells.txt
```
??? example "Expected result"
    ```text
    GNU nano 7.2                    shells.txt
    [ New File ]
    ^G Help  ^O Write Out  ^W Where Is  ^X Exit
    ```

Add `She sells seashells down by the seashore.`, copy and paste the line three times, then save and close the file. Open the original file, indent the first three lines, and replace `fox` with `rabbit`:

```text
Ctrl+\\
```

Move forward one word:

```text
Ctrl+Space
```

Delete a line:

```text
Ctrl+K
```

Save and exit:

```text
Ctrl+X
```

> End of the lab. Do not continue to the next topic.
