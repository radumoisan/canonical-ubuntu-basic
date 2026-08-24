# 4. Identity and Ownership

!!! note
    Structured from the source material. Command validation is pending.

!!! abstract
    Manage users, groups, privilege delegation, ownership, and permissions.

## :material-book-open-page-variant-outline: 4.1 User Management

User accounts control system access through a unique login and password, permissions, and logging. Account information is stored in `/etc/passwd` and `/etc/shadow`; encrypted passwords cannot be read directly.

| Command | Purpose |
| --- | --- |
| `adduser` | Create a user account. |
| `usermod` | Modify a user account. |
| `passwd` | Change a password. |
| `deluser` | Delete a user account. |

Permissions on files and directories provide read, write, and execute access to users or groups.

```bash
# Inspect file permissions
ls -l file.txt
```
??? example "Expected result"
    `-rwxrwxr-x 1 student01 ststrain ... file.txt`

Groups contain one or more accounts and simplify access management. For example, adding a user to a project group gives that user the shared directory permissions of the group.

| Command | Purpose |
| --- | --- |
| `addgroup` | Create a group. |
| `groupmod` | Modify a group. |
| `delgroup` | Delete a group. |
| `adduser` | Add a user to a group. |
| `deluser` | Remove a user from a group. |

## :material-book-open-page-variant-outline: 4.2 Privilege Delegation

Regular accounts have limited access to prevent changes to system files. Superusers can access or change any file, including files owned by other users. Ubuntu uses the `sudo` group to delegate temporary administrative privileges; `sudo` prompts for the user's password.

!!! warning
    Editing sudo policy changes administrative access. Use `visudo`, which prevents concurrent edits and checks syntax before saving.

```bash
# Edit the sudoers policy safely
sudo visudo /etc/sudoers
```
??? example "Expected result"
    The sudoers file opens in the configured editor. If another edit is active, `visudo` asks you to try again later.

To allow `ubuntu` to run `/usr/bin/command`, add this sudoers entry:

```bash
# Add a limited sudoers command rule
ubuntu ALL=(ALL) : /usr/bin/command
```
??? example "Expected result"
    No output. This is a sudoers configuration entry.

Multiple commands, permitted arguments, and password-free access can be limited in the rule:

```bash
# Add a password-free sudoers command rule
ubuntu ALL=(ALL) NOPASSWD: /usr/bin/command arg1 arg2
```
??? example "Expected result"
    No output. This is a sudoers configuration entry.

`sudo -i` starts a root shell with root's environment. `sudo -s` starts a root shell with the invoking user's environment and home directory. `sudo -u user` runs a command as another user. Compare them with `cd ~`, `pwd`, and `$PATH`.

### :material-application-edit-outline: 4.2.1 User Management & Privileges Lab

```bash
# Create the students group
sudo addgroup students
```
??? example "Expected result"
    The `students` group is created.

```bash
# Verify the group entry
grep students /etc/group
```
??? example "Expected result"
    A `students` entry is displayed.

```bash
# Create labuser with students as its primary group
sudo adduser --ingroup students --disabled-password labuser
```
??? example "Expected result"
    Adding user `labuser` ...
    Adding new user `labuser` (1004) with group `students` ...
    Creating home directory `/home/labuser` ...
    Copying files from `/etc/skel` ...
    The user-information prompts appear; press ENTER for defaults.

```bash
# Verify the passwd entry
grep labuser /etc/passwd
```
??? example "Expected result"
    `labuser:x:1001:1001:,,,:/home/labuser:/bin/bash`

The entry format is `username:password:userID:groupID:userInfo:homeDirectory:shell`. An `x` password field means the encrypted password is in `/etc/shadow`.

```bash
# Inspect the shadow entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    A `labuser` shadow entry is displayed.

```bash
# Set the labuser password
sudo passwd labuser
```
??? example "Expected result"
    The command prompts to enter and confirm a new password.

```bash
# Reinspect the shadow entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    A `labuser` shadow entry is displayed with a password hash.

```bash
# Add labuser to the sudo group
sudo adduser labuser sudo
```
??? example "Expected result"
    The user is added to the `sudo` group.

```bash
# Verify supplementary group membership
grep labuser /etc/group
```
??? example "Expected result"
    Group entries containing `labuser` are displayed.

```bash
# Start a login shell as labuser
sudo su - labuser
```
??? example "Expected result"
    The prompt changes to the `labuser` login shell.

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
    Returns to the previous shell.

```bash
# Remove labuser and its home directory
sudo userdel -r labuser
```
??? example "Expected result"
    The `labuser` account and home directory are removed.

```bash
# Start a root login shell
sudo -i
```
??? example "Expected result"
    The prompt changes to a root login shell.

```bash
# Leave the root shell
exit
```
??? example "Expected result"
    Returns to the previous shell.

## :material-book-open-page-variant-outline: 4.3 Permissions

Every filesystem object, including directories and devices, has access permissions for owner, group, and other. Read permits viewing, write permits modification or deletion, and execute permits execution. Execute permission is required to change into a directory.

```bash
# Inspect a detailed directory listing
ls -l
```
??? example "Expected result"
    `-rwxr-xr-x 1 owner group 1088 Jan 21 201 6 backup.sh`

The first character is the file type: `-` for a regular file, `d` for a directory, `c` for a character device, and `b` for a block device. The next nine characters describe owner, group, and other permissions.

The creator owns a new file and its primary group is the default group. Use `groups` to show group membership and `chown` to change ownership.

```bash
# Change a file owner and group
chown username:group filename
```
??? example "Expected result"
    No output on success.

`umask` controls defaults for future files; `chmod` changes existing permissions. Symbolic modes use `u`, `g`, `o`, `r`, `w`, and `x`; use `+` to add and `-` to remove.

```bash
# Remove group write access
chmod g-w filename
```
??? example "Expected result"
    No output on success.

```bash
# Remove other write access
chmod o-w filename
```
??? example "Expected result"
    No output on success.

Numeric modes sum read (`4`), write (`2`), and execute (`1`) for user, group, and other. `755` is `rwxr-xr-x`; `644` is `rw-r--r--`.

```bash
# Set mode 755
chmod 755 filename
```
??? example "Expected result"
    No output on success.

The user file-creation mode mask (`umask`) determines file permissions and controls the default permissions for new files. It is a three- or four-digit octal number that is the opposite of the permission value. The octal notations are:

| umask | Meaning | Permission |
| --- | --- | --- |
| `0` | read, write, and execute | `7` |
| `1` | read and write | `6` |
| `2` | read and execute | `5` |
| `3` | read only | `4` |
| `4` | write and execute | `3` |
| `5` | write only | `2` |
| `6` | execute only | `1` |
| `7` | no permissions | `0` |

`umask` has the permissions subtracted from `777`. To have all files created with `777` permission, use `umask 000`. The default `umask` is `022`; by default, file permissions would be `755`. To change the default to `740`, so the owner has full permissions, group has read access, and other has none, use:

```bash
# Set the default creation mask
umask 037
```
??? example "Expected result"
    No output. Future files use the resulting default permissions.

```bash
# Grant full access with numeric mode
chmod 777 filename
```
??? example "Expected result"
    No output on success.

```bash
# Grant full access with symbolic mode
chmod uog+rwx filename
```
??? example "Expected result"
    No output on success.

```bash
# Set a permissive creation mask
umask 000 filename
```
??? example "Expected result"
    No output. This source example sets the mask in the current shell.

```bash
# Restrict access to the owner
chmod 700 filename
```
??? example "Expected result"
    No output on success.

```bash
# Remove group and other access
chmod og-rwx filename
```
??? example "Expected result"
    No output on success.

```bash
# Set an owner-only creation mask
umask 077 filename
```
??? example "Expected result"
    No output. This source example sets the mask in the current shell.

```bash
# Add write access for all classes
chmod ugo+w filename
```
??? example "Expected result"
    No output on success.

Owners can change permissions on their files. Other users may need administrative privileges, depending on group membership and existing permissions.

### :material-application-edit-outline: 4.3.1 Permissions Lab

```bash
# Create an empty file
touch file01.txt
```
??? example "Expected result"
    No output. `file01.txt` is created.

```bash
# Create a directory
mkdir test01
```
??? example "Expected result"
    No output. `test01` is created.

```bash
# Inspect the initial permissions
ls -l
```
??? example "Expected result"
    Output varies with the current umask; the source example shows `-rw-rw-r-- file01.txt` and `drwxrwxr-x test01`.

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
    No output. `file02.txt` is created.

```bash
# Create a second directory
mkdir test02
```
??? example "Expected result"
    No output. `test02` is created.

```bash
# Compare the resulting permissions
ls -l
```
??? example "Expected result"
    The source example shows `file02.txt` as `-rw-------` and `test02` as `drwx------`.

```bash
# Match file02 permissions to file01
chmod 664 file02.txt
```
??? example "Expected result"
    No output on success.

```bash
# Match test02 permissions to test01
chmod 775 test02
```
??? example "Expected result"
    No output on success.

```bash
# Verify the permission changes
ls -l
```
??? example "Expected result"
    The listing shows the updated modes for `file02.txt` and `test02`.
