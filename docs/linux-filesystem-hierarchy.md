# 3. Linux Filesystem Hierarchy

!!! abstract "Goals"
    Define the Linux Filesystem Hierarchy Standard, explain the Ubuntu filesystem hierarchy, and identify Linux file types.

!!! note
    Command validation remains pending.

## :material-book-open-page-variant-outline: 3.1 The Filesystem Hierarchy Standard

### :material-application-edit-outline: Directory Structure

The Filesystem Hierarchy Standard (FHS), maintained by the Linux Foundation, defines directory structure and contents for Unix and Unix-like operating systems. It is currently used only by Linux distributions. Under the FHS, all files and directories appear below the root directory `/`, even when stored on different physical or virtual devices.

The root filesystem must be adequate to boot, restore, recover, or repair the system. It should be as small as reasonably possible because it can be mounted from small media, is less prone to corruption after a system crash, and must not contain application-created or application-required files and subdirectories.

To boot, the root filesystem must contain enough software and data to mount other filesystems, including utilities, boot-loader configuration, and essential start-up data. To recover or repair a system, it must provide utilities for an experienced maintainer to diagnose and repair issues and reconstruct a damaged system. To restore a system, it must provide backup restoration utilities.

### :material-application-edit-outline: The `cd` Command

The `cd` command changes the current directory. Its syntax is:

```bash
# Show the cd command syntax.
cd [option] [directory]
```

??? example "Expected result"
    This syntax form is shown for reference; square-bracketed items are optional. Running it literally attempts to change to a directory named `[directory]`.

Without a directory name, `cd` returns the user to the previous current directory, which can toggle between two directories. With a directory name, it changes to that directory. The name can be an absolute pathname, relative to `/`, or a local pathname, relative to the current directory.

Examples using absolute paths:

```bash
# Change to the root directory.
cd /
```

??? example "Expected result"
    No output. The current directory becomes `/`.

```bash
# Change to the /usr/sbin directory.
cd /usr/sbin
```

??? example "Expected result"
    No output. The current directory becomes `/usr/sbin`.

To change from the current directory into a subdirectory, use `cd` followed by its name:

```bash
# Change to gconf from within etc.
cd gconf
```

??? example "Expected result"
    No output when `gconf` exists in the current directory; otherwise Bash reports that the directory does not exist.

The current directory is represented by `.`, and its parent directory by `..`.

```bash
# Change to the parent directory.
cd ..
```

??? example "Expected result"
    No output. The current directory becomes its parent.

A tilde returns to the home directory, where a user's personal files, directories, and programs are found.

```bash
# Change to the home directory.
cd ~
```

??? example "Expected result"
    No output. The current directory becomes the current user's home directory.

Other options:

```bash
# Move to the previous directory.
cd -
```

??? example "Expected result"
    The previous directory path is printed and becomes the current directory.

```bash
# Move two directories up from the current directory.
cd ../../
```

??? example "Expected result"
    No output. The current directory moves two levels toward `/`.

## :material-book-open-page-variant-outline: 3.2 Required Root Filesystem Directories

![Filesystem hierarchy diagram](assets/fs.png)

The following directories, or symbolic links to directories, are required in `/`:

```text
/bin     - essential command binaries
/dev     - device files
/etc     - host-specific system configuration
/sbin    - essential system binaries
/usr     - secondary hierarchy
/var     - variable data hierarchy
/boot    - static files of the boot loader
/lib     - essential shared libraries and kernel modules
/media   - mount point for removable media
/mnt     - mount point for mounting a filesystem temporarily
/tmp     - temporary files
```

Modern Linux distributions also include:

```text
/sys     - Kernel system information virtual filesystem
/proc    - Kernel process information virtual filesystem
```

Optional root filesystem directories include:

```text
/home                - User home directories
/lib64 or /lib32     - Essential system libraries
/root                - Home directory for the root user
```

### :material-application-edit-outline: The `/usr` Hierarchy

The second major filesystem section is shareable and should contain only read-only data. Required subdirectories are:

```text
/usr/bin       - Most user commands
/usr/lib       - Libraries
/usr/local     - Local hierarchy
/usr/sbin      - Non-vital system binaries
/usr/share     - Architecture independent data
```

Optional subdirectories include:

```text
/usr/games                  - Games and educational binaries
/usr/include                - Header files included by C programs
/usr/libexec                - Binaries run by other programs
/usr/lib64 or /usr/lib32    - Alternate format libraries
/usr/src                    - Source code
```

### :material-application-edit-outline: The `/var` Hierarchy

The `/var` directory is designed for files that vary in size:

- Spool directories and files
- Administrative and logging data
- Transient files
- Temporary files

Required subdirectories are:

```text
/var/cache     - Application cache data
/var/lib       - Variable state information
/var/local     - Variable data for /usr/local
/var/lock      - Lock files
/var/log       - Log files and directories
/var/opt       - Variable data for /opt
/var/run       - Data relevant to running processes
/var/spool     - Application spool data
/var/tmp       - Temporary files preserved between system reboots
```

### :material-application-edit-outline: The `/etc` Hierarchy

The `/etc` directory maintains many files, including:

```text
/etc/passwd - user database with user information such as username and home directory
/etc/shadow - encrypted file that holds user passwords
/etc/fstab - lists filesystems mounted automatically at startup by mount -a
/etc/group - similar to /etc/passwd, but describes groups instead of users
/etc/inittab - configuration file for init
/etc/mtab - list of currently mounted filesystems
/etc/profile, /etc/bash.rc - files executed by BASH at login or startup
```

### :material-application-edit-outline: 3.2.1 Directory Structure Lab

This lab examines filesystem directories and their contents.

1. Check the current directory, then change to the root directory.

```bash
# Print the current working directory.
pwd
```

??? example "Expected result"
    ```text
    /home/ubuntu
    ```

```bash
# Change to the root directory.
cd /
```

??? example "Expected result"
    No output. The current directory becomes `/`.

2. List the root directory contents and compare them with the preceding directory list.

```bash
# List the root directory contents.
ls
```

??? example "Expected result"
    Root-level entries are listed. The exact directories and symbolic links vary by system.

3. Change into `/usr`.

```bash
# Change to the /usr directory.
cd /usr
```

??? example "Expected result"
    No output. The current directory becomes `/usr`.

4. Inspect the listed `usr` subdirectories.

```bash
# List the /usr/lib directory contents.
ls lib
```

??? example "Expected result"
    Entries in `/usr/lib` are listed; content varies by installed packages and architecture.

```bash
# List the /usr/games directory contents.
ls games
```

??? example "Expected result"
    Entries in `/usr/games` are listed, or no entries are shown when the directory is empty.

```bash
# List the /usr/local directory contents.
ls local
```

??? example "Expected result"
    Entries in `/usr/local` are listed; content varies by system.

5. Change back to `/`, then change to `/var`.

```bash
# Change to the root directory.
cd /
```

??? example "Expected result"
    No output. The current directory becomes `/`.

```bash
# Change to the /var directory.
cd /var
```

??? example "Expected result"
    No output. The current directory becomes `/var`.

6. Inspect the `var` subdirectory listed on the preceding page.

```bash
# List the /var/cache directory contents.
ls cache
```

??? example "Expected result"
    Entries in `/var/cache` are listed; content varies by installed software.

7. Change to the `cache` subdirectory, then move two directories up.

```bash
# Change to the cache subdirectory.
cd cache
```

??? example "Expected result"
    No output. The current directory becomes `/var/cache`.

```bash
# Move two directories up from the current directory.
cd ../../
```

??? example "Expected result"
    No output. From `/var/cache`, the current directory becomes `/`.

8. Change to the home directory.

```bash
# Change to the current user's home directory.
cd ~
```

??? example "Expected result"
    No output. The current directory becomes the current user's home directory.

9. Install `tree`, then run it from the home directory.

```bash
# Install the tree package without an interactive confirmation prompt.
sudo apt install tree -y
```

??? example "Expected result"
    APT reports package installation progress and successful installation. Package versions and download details vary.

```bash
# Change to the current user's home directory.
cd ~
```

??? example "Expected result"
    No output. The current directory becomes the current user's home directory.

```bash
# Display the home directory in a tree-like format.
tree
```

??? example "Expected result"
    A tree-like listing of the home directory is displayed. Entries vary.

10. List `/` with `tree` and inspect it.

```bash
# Display one level of the root directory tree.
tree -L 1 /
```

??? example "Expected result"
    The root directory and its immediate entries are displayed in a tree-like format. Entries vary.

11. Go one level deeper and inspect it.

```bash
# Display two levels of the root directory tree.
tree -L 2 /
```

??? example "Expected result"
    Two levels of the root directory tree are displayed. Entries vary.

> End of the lab. Do not continue with the next topic.

## :material-book-open-page-variant-outline: 3.3 Linux File Types

### :material-application-edit-outline: Determining File Types

Use `ls` to determine a file type.

```bash
# List detailed information for /etc/hosts.
ls -l /etc/hosts
```

??? example "Expected result"
    ```text
    -rw-r--r-- 1 root root 8 Mar 12 2018 /etc/hostname
    ```

The first character in the output, `-` in this example, indicates the file type. Linux file types are:

| Type | Symbol | Description |
| --- | :---: | --- |
| regular | `-` | Any file that is not a directory or special file type. |
| directory | `d` | The second-most common file type. |
| socket | `s` | Provides inter-process communication. |
| block | `b` | A device file that communicates with a driver in the kernel. |
| link | `l` | A pointer to another file; can be a soft or hard link. |
| named pipe | `p` | Similar to sockets; provides IPC without network sockets. |
| character | `c` | A device file that communicates with a driver in the kernel. |

A `regular file` is not a directory or special file type. Regular files include binaries or libraries, configuration files, image files, audio or video files, data files, and tar files.

A `directory` is the second-most common file type. It organizes other file types and is essentially a file that lists other files.

A `socket` provides inter-process communication. When it has a filename, it can be accessed through the filesystem. TCP/IP sockets can be accessed over the network.

A `block file` communicates with a kernel driver, which usually communicates with hardware. Data flow is buffered. Block files are used with block storage devices such as disks or memory. Examples include `/dev/sda` and `/dev/ram0`.

A `pipe` is similar to a socket and lets processes communicate without network socket semantics; the processes do not need to be designed to work together.

A `character` file communicates with a kernel driver, which usually communicates with hardware. Data flow is unbuffered: each character is consumed when written and read when provided. Keyboard and mouse files are examples. Character special files include `/dev/ttyS0` and `/dev/console`.

### :material-application-edit-outline: 3.3.1 File Types Lab

This lab examines file types.

1. Run the following commands and identify the file types.

```bash
# List detailed information for the /etc directory.
ls -ld /etc
```

??? example "Expected result"
    A long listing beginning with `d` is displayed, identifying `/etc` as a directory. Permissions and timestamps vary.

```bash
# List detailed information for /etc/hosts.
ls -l /etc/hosts
```

??? example "Expected result"
    A long listing beginning with `-` is displayed, identifying `/etc/hosts` as a regular file. Details vary.

```bash
# List detailed information for the controlling terminal.
ls -l /dev/tty
```

??? example "Expected result"
    A long listing beginning with `c` is displayed, identifying `/dev/tty` as a character device. Details vary.

```bash
# List detailed information for the vda block device.
ls -l /dev/vda
```

??? example "Expected result"
    A long listing beginning with `b` is displayed when `/dev/vda` exists, identifying it as a block device. Device availability varies.

2. Inspect the many file types in `/dev`.

```bash
# List detailed information for device files.
ls -l /dev/
```

??? example "Expected result"
    Device entries are listed, commonly including character devices, block devices, symbolic links, and sockets. Entries vary.

3. Create a file and inspect its type.

```bash
# Create an empty regular file.
touch file1.txt
```

??? example "Expected result"
    No output. An empty file named `file1.txt` is created or its timestamp is updated.

```bash
# List detailed information for the new file.
ls -l file1.txt
```

??? example "Expected result"
    ```text
    -rw-rw-r-- 1 ubuntu ubuntu 0 Feb 12 12:41 file1.tx
    ```

4. Create a directory and inspect it.

```bash
# Create a directory named dirone.
mkdir dirone
```

??? example "Expected result"
    No output. A directory named `dirone` is created.

```bash
# List the dirone directory entry.
ls -l | grep dirone
```

??? example "Expected result"
    ```text
    drwxrwxr-x 2 ubuntu ubuntu 4096 Feb 12 12:43 dirone
    ```

5. Remove the file and directory.

```bash
# Remove the empty dirone directory.
rmdir dirone/
```

??? example "Expected result"
    No output. The empty `dirone` directory is removed.

```bash
# Remove the file1.txt file.
rm file1.txt
```

??? example "Expected result"
    No output. The `file1.txt` file is removed.

> End of the lab. Do not continue with the next topic.
