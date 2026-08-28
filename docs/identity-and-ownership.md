# 4. Identity and Ownership

!!! abstract
    Manage users, groups, privilege delegation, ownership, and permissions.

!!! note
    The shown environment-specific results were captured on the replacement `LABVM` during validation. Account IDs, timestamps, ownership, and other directory entries can vary.

## :material-book-open-page-variant-outline: 4.1 User Management

User accounts control access through a login name, password, permissions, and logging. Account records are stored in `/etc/passwd` and `/etc/shadow`; password hashes cannot be read as passwords.

`adduser` creates an account, `usermod` changes an account, `passwd` changes a password, and `deluser` deletes an account. Groups simplify shared access.

The syntax `ls -l file.txt`, `chown username:group filename`, and the `chmod` examples below are reference forms. Replace the placeholders with real names before use.

## :material-book-open-page-variant-outline: 4.2 Privilege Delegation

Members of Ubuntu's `sudo` group can run administrative commands. Sudoers entries such as `ubuntu ALL=(ALL) : /usr/bin/command` and `ubuntu ALL=(ALL) NOPASSWD: /usr/bin/command arg1 arg2` are policy examples, not commands to run in a shell.

Use this non-mutating syntax check instead of opening the policy editor during this exercise.

```bash
# Check sudoers syntax without changing policy
sudo visudo -c
```
??? example "Expected result"
    `/etc/sudoers: parsed OK` and the two active included sudoers files parsed successfully.

`sudo su - labuser` starts a login shell as `labuser`; `sudo -i` starts a root login shell. Use `exit` to return to the original administrative session.

### :material-application-edit-outline: 4.2.1 User Management and Privileges Lab

```bash
# Create the students group
sudo addgroup students
```
??? example "Expected result"
    `info: Adding group \`students' (GID 1001) ...`

```bash
# Verify the group entry
grep students /etc/group
```
??? example "Expected result"
    `students:x:1001:`

```bash
# Create labuser with students as its primary group
sudo adduser --ingroup students --disabled-password labuser
```
??? example "Expected result"
    `info: Adding user \`labuser' ...` and `info: Creating home directory \`/home/labuser' ...`

```bash
# Verify the passwd entry
grep labuser /etc/passwd
```
??? example "Expected result"
    `labuser:x:1001:1001:,,,:/home/labuser:/bin/bash`

```bash
# Inspect the disabled password entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    `labuser:!:`

```bash
# Set the labuser password
sudo passwd labuser
```
??? example "Expected result"
    `passwd: password updated successfully`

```bash
# Reinspect the password entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    `labuser:$y$`

```bash
# Add labuser to the sudo group
sudo adduser labuser sudo
```
??? example "Expected result"
    `info: Adding user \`labuser' to group \`sudo' ...`

```bash
# Verify supplementary group membership
grep labuser /etc/group
```
??? example "Expected result"
    `sudo:x:27:ubuntu,labuser` and `users:x:100:labuser`

```bash
# Start a login shell as labuser
sudo su - labuser
```
??? example "Expected result"
    No output.

```bash
# Show the labuser home directory
echo $HOME
```
??? example "Expected result"
    `/home/labuser`

```bash
# Leave the labuser shell
exit
```
??? example "Expected result"
    No output.

```bash
# Remove labuser and its home directory
sudo userdel -r labuser
```
??? example "Expected result"
    `userdel: labuser mail spool (/var/mail/labuser) not found`

```bash
# Start a root login shell
sudo -i
```
??? example "Expected result"
    Root login-shell transition verified with operator-only identity check.

```bash
# Leave the root shell
exit
```
??? example "Expected result"
    No output.

## :material-book-open-page-variant-outline: 4.3 Permissions

`r`, `w`, and `x` mean read, write, and execute. They apply separately to the owner (`u`), group (`g`), and other users (`o`). Numeric modes such as `755` and symbolic modes such as `g-w` are reference syntax for existing files.

`umask` affects future files in the current shell. The source forms `umask 000 filename` and `umask 077 filename` accept the mask but do not apply it to `filename`; use the mask alone.

```bash
# Set a permissive creation mask for this shell
umask 000
```
??? example "Expected result"
    No output.

```bash
# Set an owner-only creation mask for this shell
umask 077
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: 4.3.1 Permissions Lab

```bash
# Create an empty file
touch file01.txt
```
??? example "Expected result"
    No output.

```bash
# Create a directory
mkdir test01
```
??? example "Expected result"
    No output.

```bash
# Inspect the initial permissions
ls -l
```
??? example "Expected result"
    `-rw-rw-r-- 1 ubuntu ubuntu    0 Aug 28 03:55 file01.txt`
    `drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 28 03:55 test01`

```bash
# Restrict default permissions to the owner
umask 077
```
??? example "Expected result"
    No output.

```bash
# Create a second empty file
touch file02.txt
```
??? example "Expected result"
    No output.

```bash
# Create a second directory
mkdir test02
```
??? example "Expected result"
    No output.

```bash
# Compare the resulting permissions
ls -l
```
??? example "Expected result"
    `-rw-rw-r-- 1 ubuntu ubuntu    0 Aug 28 03:55 file01.txt`
    `-rw------- 1 ubuntu ubuntu    0 Aug 28 03:55 file02.txt`
    `drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 28 03:55 test01`
    `drwx------ 2 ubuntu ubuntu 4096 Aug 28 03:55 test02`

```bash
# Match file02 permissions to file01
chmod 664 file02.txt
```
??? example "Expected result"
    No output.

```bash
# Match test02 permissions to test01
chmod 775 test02
```
??? example "Expected result"
    No output.

```bash
# Verify the permission changes
ls -l
```
??? example "Expected result"
    `-rw-rw-r-- 1 ubuntu ubuntu    0 Aug 28 03:55 file01.txt`
    `-rw-rw-r-- 1 ubuntu ubuntu    0 Aug 28 03:55 file02.txt`
    `drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 28 03:55 test01`
    `drwxrwxr-x 2 ubuntu ubuntu 4096 Aug 28 03:55 test02`
