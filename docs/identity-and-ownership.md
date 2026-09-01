# 4. Identity and Ownership

!!! abstract
    Manage users, groups, privilege delegation, ownership, and permissions.

!!! note
    Command output varies between systems and over time. Account and group IDs, timestamps, ownership, and directory entries depend on the state of the system when each command runs.

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
    ```shell
    /etc/sudoers: parsed OK
    /etc/sudoers.d/90-cloud-init-users: parsed OK
    /etc/sudoers.d/README: parsed OK
    ```

`sudo su - labuser` starts a login shell as `labuser`; `sudo -i` starts a root login shell. Use `exit` to return to the original administrative session.

### :material-application-edit-outline: 4.2.1 User Management and Privileges Lab

```bash
# Create the students group
sudo addgroup students
```
??? example "Expected result"
    ```shell
    info: Selecting GID from range 1000 to 59999 ...
    info: Adding group `students' (GID 1001) ...
    ```

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
    ```shell
    info: Adding user `labuser' ...
    info: Selecting UID from range 1000 to 59999 ...
    info: Adding new user `labuser' (1001) with group `students (1001)' ...
    info: Creating home directory `/home/labuser' ...
    info: Copying files from `/etc/skel' ...
    Changing the user information for labuser
    Enter the new value, or press ENTER for the default
    Full Name []:
    Room Number []:
    Work Phone []:
    Home Phone []:
    Other []:
    Is the information correct? [Y/n] Y
    info: Adding new user `labuser' to supplemental / extra groups `users' ...
    info: Adding user `labuser' to group `users' ...
    ```

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
    `labuser:!:20697:0:99999:7:::`

```bash
# Set the labuser password
sudo passwd labuser
```
??? example "Expected result"
    ```shell
    New password:
    Retype new password:
    passwd: password updated successfully
    ```

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
    ```shell
    info: Adding user `labuser' to group `sudo' ...
    ```

```bash
# Verify supplementary group membership
grep labuser /etc/group
```
??? example "Expected result"
    ```shell
    sudo:x:27:ubuntu,labuser
    users:x:100:labuser
    ```

```bash
# Start a login shell as labuser
sudo su - labuser
```
??? example "Expected result"
    ```shell
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.
    ```

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
    `logout`

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
    No output.

```bash
# Leave the root shell
exit
```
??? example "Expected result"
    `logout`

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
    ```shell
    total 4
    -rw------- 1 ubuntu ubuntu    0 Sep  1 07:15 file01.txt
    drwx------ 2 ubuntu ubuntu 4096 Sep  1 07:15 test01
    ```

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
    ```shell
    total 8
    -rw------- 1 ubuntu ubuntu    0 Sep  1 07:15 file01.txt
    -rw------- 1 ubuntu ubuntu    0 Sep  1 07:15 file02.txt
    drwx------ 2 ubuntu ubuntu 4096 Sep  1 07:15 test01
    drwx------ 2 ubuntu ubuntu 4096 Sep  1 07:15 test02
    ```

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
    ```shell
    total 8
    -rw------- 1 ubuntu ubuntu    0 Sep  1 07:15 file01.txt
    -rw-rw-r-- 1 ubuntu ubuntu    0 Sep  1 07:15 file02.txt
    drwx------ 2 ubuntu ubuntu 4096 Sep  1 07:15 test01
    drwxrwxr-x 2 ubuntu ubuntu 4096 Sep  1 07:15 test02
    ```
