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

```bash
# Connect when the remote username matches the local username
ssh remote_host
```
??? example "Expected result"
    Connects to `remote_host` and prompts for authentication as required.

```bash
# Connect with a specified remote username
ssh user@remote_host
```
??? example "Expected result"
    Connects to `remote_host` as `user` and prompts for authentication as required.

```bash
# End the current SSH session
exit
```
??? example "Expected result"
    Ends the current shell or SSH session.

```bash
# Run one command on a remote host
ssh remote_host command_to_run
```
??? example "Expected result"
    Authenticates as needed, runs `command_to_run` remotely, and returns its output.

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
    Opens the `ls` manual page. Useful options include `-a`, `-h`, `-l`, and `-t`.

`-a, --all` includes entries beginning with `.`, `-h, --human-readable` prints readable sizes with `-l` or `-s`, `-l` uses long format, and `-t` sorts by newest modification time first.

2. Create `mydir1`, enter it, create and enter `mydir2`, return to its parent, then remove `mydir2`.

```bash
# Create mydir1
mkdir mydir1
```
??? example "Expected result"
    No output; creates `mydir1`.

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
    No output; creates `mydir2`.

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
    No output; removes `mydir2`.

3. Create `file1`, copy it to `file2`, return to the parent of `mydir1`, create `mynewdir`, and copy `mydir1` contents into it.

```bash
# Create file1
touch file1
```
??? example "Expected result"
    No output; creates `file1`.

```bash
# Copy file1 to file2
cp file1 file2
```
??? example "Expected result"
    No output; creates `file2`.

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
    No output; creates `mynewdir`.

```bash
# Copy mydir1 contents into mynewdir
cp -a mydir1/* mynewdir
```
??? example "Expected result"
    No output; copies `file1` and `file2` with attributes.

4. Type `ls my` and press Tab twice to inspect shell completion choices.

```bash
# Begin a listing command for tab completion
ls my
```
??? example "Expected result"
    Press Tab twice after `my`; the shell displays or completes matching entries such as `mydir1` and `mynewdir`.

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
    Displays a usage message because no manual-page name was supplied.

```bash
# Open the man manual page
man man
```
??? example "Expected result"
    Opens the manual page for `man`.

```bash
# Open the ls manual page
man ls
```
??? example "Expected result"
    Opens the manual page for `ls`.

Then find the `rsync -p` option.

```bash
# Open the rsync manual page
man rsync
```
??? example "Expected result"
    Opens the `rsync` manual page. Search for `-p` to find its description.

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.4 Shell Environment Variables

A shell environment variable is a named character string that stores information such as numbers, text, filenames, devices, or credentials. `PATH` tells the shell which directories to search for executable files. Use `env` or `printenv` to list defined environment variables. Common variables are `SHELL` for the default shell, `USER` for the logged-in user, `PWD` for the current directory, and `HOME` for the current user's home directory.

To run a command outside `PATH`, precede it with a relative or full path.

```bash
# Run a command using a relative path
. /mycommand.sh
```
??? example "Expected result"
    Runs commands from `mycommand.sh` in the current shell when the file exists and is readable.

```bash
# Run a command using its full path
/home/myuser/mycommand.sh
```
??? example "Expected result"
    Runs the specified script when the path exists and the script is executable.

### :material-application-edit-outline: Naming Variables

By convention, variable names are uppercase. They can use letters, numbers, and underscores, but cannot begin with a number.

```bash
# Export terminal-type variables
export TERM=ansi TERM=xterm-256color
```
??? example "Expected result"
    No output; exports `TERM` with the final assigned value `xterm-256color`.

### :material-application-edit-outline: Setting and Unsetting Variables

Define variables with `name=value`; they are local until the shell exits. Use `unset` or an empty value to undefine them. Use `export` to make a variable available to child processes.

```bash
# Set local variables
NAME=Marvin
```
??? example "Expected result"
    No output; sets `NAME` in the current shell.

```bash
# Set a variable containing multiple values
NAMES="Marvin Ford Arthur Trillian"
```
??? example "Expected result"
    No output; sets `NAMES` in the current shell.

```bash
# Unset NAME
unset NAME
```
??? example "Expected result"
    No output; removes `NAME` from the current shell.

```bash
# Set NAME to an empty value
NAME=
```
??? example "Expected result"
    No output; `NAME` expands to an empty value.

```bash
# Export NAME to child processes
export NAME=Marvin
```
??? example "Expected result"
    No output; sets and exports `NAME`.

### :material-application-edit-outline: Manipulating Variables

```bash
# Display NAME
echo $NAME
```
??? example "Expected result"
    Prints the current value of `NAME`, such as `Marvin` when set above.

```bash
# Append a value to NAMES
NAMES="$NAMES Zaphod"
```
??? example "Expected result"
    No output; appends `Zaphod` to the current value.

```bash
# Mark NAMES as read-only
readonly NAMES
```
??? example "Expected result"
    No output; later attempts to modify `NAMES` fail in the current shell.

### :material-application-edit-outline: Special Variables

Special variables can be referenced but not assigned. `$?` is the exit status of the last command, `$$` is the PID of the current shell, and `$!` is the PID of the last background command.

```bash
# Reference the last command's exit status
$?
```
??? example "Expected result"
    The source presents the special variable for reference. Its value is `0` after a successful command and non-zero after failure.

```bash
# Reference the current shell process ID
$$$
```
??? example "Expected result"
    The source presents the shell PID special-variable form. The PID varies by shell.

```bash
# Reference the last background command's process ID
$!
```
??? example "Expected result"
    The source presents the special-variable form for the most recent background command PID.

### :material-application-edit-outline: 2.4.1 Shell Environment and Variables Lab

1. View `PATH` and environment variables.

```bash
# Display the PATH variable
echo $PATH
```
??? example "Expected result"
    Displays a colon-separated directory list; the current directory is not normally included.

```bash
# List environment variables
env
```
??? example "Expected result"
    Displays environment-variable assignments. Values vary by session.

2. Consider the purpose of `SHELL`. Set and view `MYNAME`.

```bash
# Set MYNAME
MYNAME="john"
```
??? example "Expected result"
    No output; sets `MYNAME` to `john`.

```bash
# Display MYNAME
echo $MYNAME
```
??? example "Expected result"
    `john`

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
    `My name is`

```bash
# Display the second fragment
echo $PART2
```
??? example "Expected result"
    `john`

4. Combine the variables into `STUDENTNAME` and display it.

```bash
# Combine the name fragments
STUDENTNAME=$PART1$PART2
```
??? example "Expected result"
    No output; creates a combined value without an additional separator.

```bash
# Display STUDENTNAME
echo $STUDENTNAME
```
??? example "Expected result"
    `My name isjohn`

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
    Prints an empty line.

```bash
# Confirm PART2 is undefined
echo $PART2
```
??? example "Expected result"
    Prints an empty line.

```bash
# Confirm STUDENTNAME is undefined
echo $STUDENTNAME
```
??? example "Expected result"
    Prints an empty line.

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
    `5`

```bash
# Create a subshell
bash
```
??? example "Expected result"
    Starts a child shell.

```bash
# Display x in the subshell
echo $x
```
??? example "Expected result"
    Prints an empty line because `x` was not exported.

```bash
# Exit back to the original shell
exit
```
??? example "Expected result"
    Returns to the original shell.

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
    `5`

```bash
# Create a subshell
bash
```
??? example "Expected result"
    Starts a child shell.

```bash
# Display x in the subshell
echo $x
```
??? example "Expected result"
    `5`

```bash
# Exit the subshell
exit
```
??? example "Expected result"
    Returns to the original shell.

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
    No terminal output; writes the listing to `~/all_files.txt`.

```bash
# Append a /tmp listing to a file
ls -al /tmp >> ~/all_files.txt
```
??? example "Expected result"
    No terminal output; appends the listing to `~/all_files.txt`.

```bash
# Combine file contents into one file
cat file1.txt file2.txt file3.txt > combined-file.txt
```
??? example "Expected result"
    No terminal output; writes combined content when all source files exist.

```bash
# Discard ping output
ping -c 2 www.xxx.yyy.zzz > /dev/null
```
??? example "Expected result"
    Suppresses standard output; success depends on DNS and network availability.

#### Input Redirection

A command can receive input from a file with `<` followed by a filename. When two less-than characters (`<<`) are used, a delimiter must be defined immediately after `<<`. The shell reads input until it reaches a line containing that delimiter.

```bash
# Count lines from the passwd file
wc -l < /etc/passwd
```
??? example "Expected result"
    Prints the number of lines in `/etc/passwd`; the count varies.

```bash
# Begin a here-document for wc
wc -l << EOF
```
??? example "Expected result"
    Reads lines until `EOF` is entered, then prints the line count.

This counts lines one at a time until it reaches the `EOF` delimiter.

#### Piped Redirection

The output of one command can be sent directly to another command as input with `|`. This is called a pipe or piping.

```bash
# Page through a detailed listing
ls -al | less
```
??? example "Expected result"
    Opens the listing in the `less` pager.

```bash
# Filter a detailed listing
ls -al | grep string
```
??? example "Expected result"
    Displays listing lines that contain `string`.

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
    Writes standard output to `/tmp/list.txt` and standard error to `/tmp/errors.txt`.

```bash
# Write normal output and errors to one file
ls -al /r* > /tmp/list.txt 2>&1
```
??? example "Expected result"
    Writes both standard output and standard error to `/tmp/list.txt`.

### :material-application-edit-outline: 2.5.1 Redirection Lab

```bash
# Save a directory listing to mylist
ls > mylist
```
??? example "Expected result"
    No terminal output; `mylist` contains the directory listing.

```bash
# Display the fifth item in /usr/bin listing order
ls /usr/bin | head -5 | tail -1
```
??? example "Expected result"
    Prints one entry from `/usr/bin`; the entry varies.

```bash
# Find list entries in mylist
grep list mylist
```
??? example "Expected result"
    Prints lines in `mylist` containing `list`, if any.

```bash
# Display the newest entries in /usr/bin
ls -lt /usr/bin | head
```
??? example "Expected result"
    Displays a header and the first entries sorted by modification time; output varies.

```bash
# Display the largest directory sizes
du | sort -nr | head
```
??? example "Expected result"
    Displays the ten largest `du` entries in the current tree; values vary.

```bash
# Create redirection.txt with a here-document
cat >redirection.txt <<EOF
Hello world!
EOF
```
??? example "Expected result"
    No terminal output; creates `redirection.txt` containing `Hello world!`.

```bash
# Find examine references in less help
less --help | grep -i examine
```
??? example "Expected result"
    Displays case-insensitive help lines containing `examine`, if present.

> End of the lab. Do not continue to the next topic.

## :material-book-open-page-variant-outline: 2.6 Command Chaining

Command chaining combines commands on one command line. Operators include `&` for background execution, `;` for sequential execution, `&&` for execution after success, `||` for execution after failure, `!` for negation, `|` for piping, `{}` for grouping, `()` for precedence, and `\` to continue a command or escape special characters.

```bash
# Run three commands sequentially
ls; pwd; whoami
```
??? example "Expected result"
    Displays a listing, the current directory, and the current username.

```bash
# Report whether a host can be pinged
ping -c1 google.com && echo "That's good, able to ping google.com" || \
echo "That's bad unable to ping google.com"
```
??? example "Expected result"
    Prints the success message if ping succeeds; otherwise prints the failure message. Network availability varies.

## :material-book-open-page-variant-outline: 2.7 Return Values and Expansion

Successful commands return exit code `0`; unsuccessful commands should return a non-zero code. `$?` stores the last command's exit status. The shell resolves tokens through expansions, including brace, tilde, parameter, command, arithmetic, and wildcard expansion.

### :material-application-edit-outline: Brace Expansion

Brace expansion generates strings from comma-separated values or ranges and can be nested.

```bash
# Demonstrate brace expansion
echo sp{el,il,al}
```
??? example "Expected result"
    `spel spil spal`

```bash
# Create directories using brace ranges
mkdir {2014..2016}-0{0..9} {2014..2016}-{10..12}
```
??? example "Expected result"
    Creates directories for the expanded names, unless names already exist.

```bash
# Create files using brace ranges
touch file-{A..Z}{a..z}-{0..9}
```
??? example "Expected result"
    Creates files for the expanded names.

```bash
# Create text files using brace ranges
touch {A..Z}{a..z}-{0..9}.txt
```
??? example "Expected result"
    Creates `.txt` files for the expanded names.

```bash
# Remove files with selected extensions
rm filename.{pl,sh,py,c}
```
??? example "Expected result"
    Removes each named file when it exists.

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
    Changes directory when the `ubuntu` account exists.

```bash
# Create hello.txt in the current user's home directory
echo hello >~/hello.txt
```
??? example "Expected result"
    No terminal output; writes `hello` to `~/hello.txt`.

### :material-application-edit-outline: Shell Parameter and Variable Expansion

`$` introduces parameter expansion, command substitution, or arithmetic expansion. Braces protect a variable name from adjacent characters. `${!name}` performs indirect expansion, and a default can be assigned while expanding an unset variable.

```bash
# Display the configured shell
echo $SHELL
```
??? example "Expected result"
    Displays the shell path, such as `/bin/bash`; it varies by session.

```bash
# Store the current date in D
D=`date`
```
??? example "Expected result"
    No output; assigns the current date string to `D`.

```bash
# Display D
echo $D
```
??? example "Expected result"
    Displays the date string assigned to `D`.

```bash
# Compare braced and unbraced variable expansion
echo ${D}d vs echo $Dd
```
??? example "Expected result"
    Expands `${D}` followed by `d`; `$Dd` refers to variable `Dd`.

```bash
# Compare indirect-style variable-name patterns
echo ${!LC*} vs echo $LC*
```
??? example "Expected result"
    `${!LC*}` expands names beginning with `LC`; the unbraced form expands `LC` then appends `*`.

```bash
# Set TODAY during expansion when it is unset
echo ${TODAY:=`date+%A`}
```
??? example "Expected result"
    Displays and sets `TODAY` to the current weekday when it was unset.

### :material-application-edit-outline: Command Substitution

Command substitution replaces a command with its standard output. The forms are `$(command)` and backticks; trailing newlines are removed.

```bash
# Display the date using command substitution
echo "The date and time is: $(date)"
```
??? example "Expected result"
    Displays `The date and time is:` followed by the current date and time.

```bash
# Display the date using backticks
echo "The date and time is `date`"
```
??? example "Expected result"
    Displays `The date and time is:` followed by the current date and time.

```bash
# Display locale environment assignments
echo $(env | grep ^LC_)
```
??? example "Expected result"
    Displays matching locale assignments on one line, if any.

```bash
# Display locale assignments one per line
printf "%s\n" $(env | grep ^LC_)
```
??? example "Expected result"
    Displays matching locale assignments one per line, if any.

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

```bash
# List metadata for all entries
ls -ld *
```
??? example "Expected result"
    Displays metadata for entries in the current directory.

```bash
# List metadata for log files
ls -ld *.log
```
??? example "Expected result"
    Displays matching `.log` files; errors if none match under default shell settings.

```bash
# List metadata for names starting with a, b, or c
ls -ld [abc]*
```
??? example "Expected result"
    Displays matching entries, if any.

```bash
# List names with a two-character suffix
ls -ld *.??
```
??? example "Expected result"
    Displays matching entries, if any.

```bash
# List log names ending with a digit extension
ls -ld *.log.[[:digit:]]
```
??? example "Expected result"
    Displays matching entries, if any.

```bash
# List names with digit and two-character extensions
ls -ld *.[[:digit:]].??
```
??? example "Expected result"
    Displays matching entries, if any.

```bash
# List names ending in a non-alphanumeric character
ls -ld *[![:alnum:]]
```
??? example "Expected result"
    Displays matching entries, if any.

### :material-application-edit-outline: 2.7.1 Chaining and Expansion Lab

Try these chaining examples. `/temp` may not exist; the fallback examples demonstrate `||`.

```bash
# Change to /temp, then list it
cd /temp; ls -al
```
??? example "Expected result"
    Runs `ls -al` even if `cd /temp` fails.

```bash
# List /temp only after changing to it
cd /temp && ls -al
```
??? example "Expected result"
    Lists `/temp` only if the directory change succeeds.

```bash
# Report a failed directory change
cd /temp || echo "Could not change to /temp"
```
??? example "Expected result"
    Prints the message if `/temp` cannot be entered.

```bash
# List /temp or report failure
cd /temp && ls -al || echo "Could not change to /temp"
```
??? example "Expected result"
    Lists on success; otherwise prints the failure message.

```bash
# Return home after a failed directory change
cd /temp && ls -al || { echo "Could not change to /temp. Going home instead"; cd ~; pwd; }
```
??? example "Expected result"
    On failure, prints the message and then the home-directory path.

```bash
# List /temp or count entries in /tmp
(cd /temp && ls -al) || (cd /tmp && { ls -al | wc -l; })
```
??? example "Expected result"
    Lists `/temp` on success; otherwise prints the `/tmp` listing line count.

```bash
# List uncompressed files in /var/log using extglob
ls -ld /var/log/!(*.gz)
```
??? example "Expected result"
    Requires Bash extended globbing to be enabled; otherwise Bash reports a syntax error.

```bash
# List the last ten entries in /etc sort order
ls -ltr /etc | tail
```
??? example "Expected result"
    Displays the final ten lines of the listing; entries vary.

```bash
# Find ls commands in shell history
history | grep ls
```
??? example "Expected result"
    Displays history entries containing `ls`; history varies by session.

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
    `data`

```bash
# Remove the shortest prefix ending with a period
echo ${file#*.}
```
??? example "Expected result"
    `txt`

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
    `6`

```bash
# Add one to X with an explicit variable expansion
echo $(($X+1))
```
??? example "Expected result"
    `6`

```bash
# Compare X with 15
echo $((X>15))
```
??? example "Expected result"
    `0`

```bash
# Change to the command-binary directory
cd /usr/bin
```
??? example "Expected result"
    No output.

```bash
# List entries beginning with m
ls m*
```
??? example "Expected result"
    Displays matching `/usr/bin` entries.

```bash
# List entries ending with a three-character extension
ls *.???
```
??? example "Expected result"
    Displays matching `/usr/bin` entries, if any.

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
    Opens the nano editor.

```bash
# Edit an existing file with nano
nano /path/filename
```
??? example "Expected result"
    Opens the specified file, or offers to create it when the path is valid.

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
    Opens `fileone.txt` in nano.

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
    Opens `shells.txt` in nano.

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
