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
    Validation pending; no captured output is available.

```bash
# Edit the sudoers policy safely
sudo visudo /etc/sudoers
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add a limited sudoers command rule
ubuntu ALL=(ALL) : /usr/bin/command
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add a password-free sudoers command rule
ubuntu ALL=(ALL) NOPASSWD: /usr/bin/command arg1 arg2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the students group
sudo addgroup students
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the group entry
grep students /etc/group
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create labuser with students as its primary group
sudo adduser --ingroup students --disabled-password labuser
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the passwd entry
grep labuser /etc/passwd
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect the shadow entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set the labuser password
sudo passwd labuser
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Reinspect the shadow entry
sudo grep labuser /etc/shadow
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add labuser to the sudo group
sudo adduser labuser sudo
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify supplementary group membership
grep labuser /etc/group
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Start a login shell as labuser
sudo su - labuser
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the labuser home directory
echo $HOME
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Leave the labuser shell
exit
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove labuser and its home directory
sudo userdel -r labuser
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Start a root login shell
sudo -i
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Leave the root shell
exit
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect a detailed directory listing
ls -l
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Change a file owner and group
chown username:group filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove group write access
chmod g-w filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove other write access
chmod o-w filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set mode 755
chmod 755 filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set the default creation mask
umask 037
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Grant full access with numeric mode
chmod 777 filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Grant full access with symbolic mode
chmod uog+rwx filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set a permissive creation mask
umask 000 filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Restrict access to the owner
chmod 700 filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove group and other access
chmod og-rwx filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set an owner-only creation mask
umask 077 filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add write access for all classes
chmod ugo+w filename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create an empty file
touch file01.txt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a directory
mkdir test01
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect the initial permissions
ls -l
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Restrict default permissions to the owner
umask 077
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a second empty file
touch file02.txt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a second directory
mkdir test02
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Compare the resulting permissions
ls -l
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Match file02 permissions to file01
chmod 664 file02.txt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Match test02 permissions to test01
chmod 775 test02
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the permission changes
ls -l
```
??? example "Expected result"
    Validation pending; no captured output is available.
