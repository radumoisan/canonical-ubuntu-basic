# 9. Backup and Recovery

!!! note
    Sections 9.1 and 9.2 are validated. Later sections remain pending validation.

!!! abstract
    Use compression, tar archives, rsync, and backup recovery procedures.

## :material-book-open-page-variant-outline: 9.1 Using Archiving and Compression Utilities

Compression reduces file size. Backups and archives are commonly stored in compressed form. On Linux, an archive commonly means a tar file that groups files and directories for distribution, storage, backup, or manipulation.

### :material-application-edit-outline: gzip compression

gzip is fast, memory-efficient, and widely compatible.

```bash
# Compress a file with gzip.
gzip myfile
```
??? example "Expected result"
    No output.

```bash
# Decompress a gzip file.
gzip -d myfile.gz
```
??? example "Expected result"
    No output.

```bash
# Display gzip file statistics.
gzip -l myfile.gz
```
??? example "Expected result"
    ```shell
             compressed        uncompressed  ratio uncompressed_name
                     45                  18 -11.1% myfile
    ```

### :material-application-edit-outline: bzip2 compression

bzip2 provides better compression than gzip but usually takes longer and uses more memory while compressing.

```bash
# Compress a file with bzip2.
bzip2 myfile
```
??? example "Expected result"
    No output.

```bash
# Decompress a bzip2 file.
bzip2 -d myfile.bz2
```
??? example "Expected result"
    No output.

```bash
# Compress a file at compression level 1.
bzip2 -1 myfile
```
??? example "Expected result"
    No output.

### :material-application-edit-outline: xz compression

xz uses LZMA2. It provides a higher compression ratio but can take significantly longer and use more memory than gzip or bzip2; decompression is faster than bzip2.

```bash
# Compress a file with xz.
xz myfile
```
??? example "Expected result"
    No output.

```bash
# Decompress an xz file.
xz -d myfile.xz
```
??? example "Expected result"
    No output.

```bash
# Compress with xz at maximum extreme compression.
xz -e -9 myfile
```
??? example "Expected result"
    No output.

```bash
# Display xz file statistics.
xz -l myfile.xz
```
??? example "Expected result"
    ```shell
    Strms  Blocks   Compressed Uncompressed  Ratio  Check   Filename
        1       1         76 B         18 B  4.222  CRC64   myfile.xz
    ```

## :material-book-open-page-variant-outline: 9.2 Tar Archiving

`tar` means tape archiving. A tar archive gathers files into one file without compression; a tarball is a common name for such an archive.

```bash
# Create an archive from two files.
tar cvf myfiles.tar myfile1 myfile2
```
??? example "Expected result"
    ```shell
    myfile1
    myfile2
    ```

`c` creates an archive, `v` lists processed files verbosely, and `f` precedes the archive filename.

```bash
# Extract an archive.
tar xvf myfiles.tar
```
??? example "Expected result"
    ```shell
    myfile1
    myfile2
    ```

```bash
# List archive contents.
tar tvf myfiles.tar
```
??? example "Expected result"
    ```shell
    -rw-rw-r-- ubuntu/ubuntu    20 2026-08-30 08:51 myfile1
    -rw-rw-r-- ubuntu/ubuntu    20 2026-08-30 08:51 myfile2
    ```

Source reference: `tar xvf /mnt/mydir.tar -C /home/alex/temp`. The validated isolated-path equivalent is:

```bash
# Extract an archive into an isolated destination directory.
tar xvf isolated-path-source/mydir.tar -C isolated-path-destination
```
??? example "Expected result"
    ```shell
    mydir-file
    ```

### :material-application-edit-outline: Tar with gzip

Use `-z` with tar for gzip compression.

```bash
# Create a gzip-compressed tar archive.
tar czvf myfile.tar.gz myfile
```
??? example "Expected result"
    ```shell
    myfile
    ```

```bash
# List a gzip-compressed tar archive.
tar tzvf myfile.tar.gz
```
??? example "Expected result"
    ```shell
    -rw-rw-r-- ubuntu/ubuntu    24 2026-08-30 08:51 myfile
    ```

```bash
# Extract a gzip-compressed tar archive.
tar xzvf myfile.tar.gz
```
??? example "Expected result"
    ```shell
    myfile
    ```

### :material-application-edit-outline: Tar with bzip2

Use `-j` with tar for bzip2 compression.

```bash
# Create a bzip2-compressed tar archive.
tar cjvf myfile.tar.bz2 myfile
```
??? example "Expected result"
    ```shell
    myfile
    ```

```bash
# List a bzip2-compressed tar archive.
tar tjvf myfile.tar.bz2
```
??? example "Expected result"
    ```shell
    -rw-rw-r-- ubuntu/ubuntu    24 2026-08-30 08:51 myfile
    ```

```bash
# Extract a bzip2-compressed tar archive.
tar xjvf myfile.tar.bz2
```
??? example "Expected result"
    ```shell
    myfile
    ```

### :material-application-edit-outline: Tar with xz

Use `-J` with tar for xz compression.

```bash
# Create an xz-compressed tar archive.
tar cJvf myfile.tar.xz myfile
```
??? example "Expected result"
    ```shell
    myfile
    ```

```bash
# List an xz-compressed tar archive.
tar tJvf myfile.tar.xz
```
??? example "Expected result"
    ```shell
    -rw-rw-r-- ubuntu/ubuntu    24 2026-08-30 08:51 myfile
    ```

```bash
# Extract an xz-compressed tar archive.
tar xJvf myfile.tar.xz
```
??? example "Expected result"
    ```shell
    myfile
    ```

## :material-book-open-page-variant-outline: 9.3 Using rsync

rsync copies and synchronizes files and directories locally or remotely, across directories, disks, and networks. It supports copying links, devices, owners, groups, and permissions, and can compress data during transfer.

```bash
# Reference syntax only; replace the placeholders before execution.
rsync options SOURCE DESTINATION
```
??? example "Expected result"
    Validation pending; no captured output is available.

Common options are `-v` for verbose output, `-r` for recursive copying, `-a` for archive mode, `-z` to compress data, and `-P` to show progress.

Source reference: `rsync -avP file.tar /path-to/backups/`. The validated isolated-path equivalent is:

```bash
# Synchronize an isolated local file to its backup directory.
rsync -avP ~/chapter9-validation/rsync-local-20260830/file-source/file.tar ~/chapter9-validation/rsync-local-20260830/file-backups/
```
??? example "Expected result"
    ```shell
    sending incremental file list
    file.tar
    total size is 22  speedup is 0.13
    ```

Source reference: `rsync -avP /home/user/ /path-to/backups/`. The validated isolated-path equivalent retains the trailing slash, so rsync copies the directory contents:

```bash
# Synchronize isolated directory contents to a backup directory.
rsync -avP ~/chapter9-validation/rsync-local-20260830/directory-source/ ~/chapter9-validation/rsync-local-20260830/directory-backups/
```
??? example "Expected result"
    ```shell
    sending incremental file list
    ./
    one.txt
    nested/
    nested/two.txt
    total size is 43  speedup is 0.10
    ```

Source reference: `rsync -avP --delete /home/user/ /path-to/backups/`. The validated isolated-path equivalent is:

```bash
# Synchronize isolated directory contents and delete destination-only files.
rsync -avP --delete ~/chapter9-validation/rsync-local-20260830/delete-source/ ~/chapter9-validation/rsync-local-20260830/delete-backups/
```
??? example "Expected result"
    ```shell
    sending incremental file list
    deleting destination-only.txt
    retained.txt
    total size is 24  speedup is 0.11
    ```

!!! warning
    `--delete` removes destination files that are absent from the source. Confirm the source and destination before running it.

!!! note
    The remote-transfer examples below await an authorized second endpoint, as directed. Their source commands are retained and their expected results remain pending.

```bash
# Synchronize a local directory to a remote server.
rsync -azvP /home/user/ user@10.10.10.10:/pathto/backup/
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Synchronize a remote directory to a local directory.
rsync -azvP user@10.10.10.10:/path-to/backup/ /tmp/local/
```
??? example "Expected result"
    Validation pending; no captured output is available.

Use `-z` to compress data during network transfer. `--compress-level=NUM` sets an explicit compression level.

### :material-application-edit-outline: Using rsync with SSH

Use `-e ssh` to transfer data through SSH.

```bash
# Copy a remote file locally through SSH.
rsync -azvPe ssh user@10.10.10.10:/path-to/file.txt /tmp/
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Copy a local file to a remote location through SSH.
rsync -azvPe ssh file.txt user@10.10.10.10:/pathto/backups/
```
??? example "Expected result"
    Validation pending; no captured output is available.

### :material-application-edit-outline: Include, exclude, and transfer limits

```bash
# Include names beginning with A and exclude all other names.
rsync -azvPe ssh --include 'A*' --exclude '*' user@10.10.10.10:/path-to/files /tmp
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Transfer files no larger than 500k from a remote log directory.
rsync -azvPe ssh --max-size='500k' 10.10.10.10:/var/log/ /tmp/
```
??? example "Expected result"
    Validation pending; no captured output is available.

Source reference: `rsync -azvP --remove-source-files file.txt /tmp/`. The validated isolated-path equivalent is:

```bash
# Remove an isolated source file after a successful local transfer.
rsync -azvP --remove-source-files ~/chapter9-validation/rsync-local-20260830/remove-source/file.txt ~/chapter9-validation/rsync-local-20260830/remove-backups/
```
??? example "Expected result"
    ```shell
    sending incremental file list
    file.txt
    total size is 22  speedup is 0.11
    ```

!!! warning
    `--remove-source-files` deletes source files after transfer. Confirm the destination before running it.

Source reference: `rsync -azvP --dry-run file.txt /tmp/`. The validated isolated-path equivalent is:

```bash
# Preview an isolated rsync transfer without changing files.
rsync -azvP --dry-run ~/chapter9-validation/rsync-local-20260830/dry-run-source/file.txt ~/chapter9-validation/rsync-local-20260830/dry-run-backups/
```
??? example "Expected result"
    ```shell
    sending incremental file list
    file.txt

    sent 67 bytes  received 19 bytes  172.00 bytes/sec
    total size is 23  speedup is 0.27 (DRY RUN)
    ```

```bash
# Limit an SSH rsync transfer to 100 KBytes per second.
rsync --bwlimit=100 -azvPe ssh /path-to/files/ user@10.10.10.10:/path-to/backup/
```
??? example "Expected result"
    Validation pending; no captured output is available.

## :material-book-open-page-variant-outline: 9.4 Backup and Recovery Lab

This lab uses tar to create, list, update, delete, extract, and gzip-compress archives.

Source reference: archive `/etc` as `/tmp/myetc.tar`. The validated equivalent uses the minimal synthetic `etc/hostname` fixture in `~/chapter9-validation`; no live system configuration is archived or extracted.

```bash
# Render the tar manual noninteractively.
LC_ALL=C MANPAGER=cat man tar 2>/dev/null | col -b | grep -m 1 'TAR'
```
??? example "Expected result"
    ```shell
    TAR(1)				GNU TAR Manual				TAR(1)
    ```

```bash
# Create an archive from the synthetic etc fixture.
tar cf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/source etc
```
??? example "Expected result"
    No output.

```bash
# List the archive contents.
tar tf ~/chapter9-validation/myetc.tar
```
??? example "Expected result"
    ```shell
    etc/
    etc/hostname
    ```

```bash
# Add the root-owned synthetic bashrc to the archive.
sudo tar uvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/source root/.bashrc
```
??? example "Expected result"
    ```shell
    root/.bashrc
    ```

```bash
# Verify root's bashrc is in the archive.
tar tf ~/chapter9-validation/myetc.tar | grep root/.bashrc
```
??? example "Expected result"
    ```shell
    root/.bashrc
    ```

!!! danger
    The next command deletes an entry from the archive. Confirm the archive and entry name before running it.

```bash
# Delete root's bashrc from the archive.
sudo tar --delete -f ~/chapter9-validation/myetc.tar root/.bashrc
```
??? example "Expected result"
    No output.

```bash
# Verify root's bashrc is absent, accepting grep's expected no-match status.
if tar tf ~/chapter9-validation/myetc.tar | grep -q root/.bashrc; then exit 1; else [ "${PIPESTATUS[1]}" -eq 1 ]; fi
```
??? example "Expected result"
    No output. `grep` returned its expected status 1 for no match and the command accepted it.

```bash
# Change to the disposable workspace.
cd ~/chapter9-validation
```
??? example "Expected result"
    No output.

```bash
# Extract only the synthetic hostname fixture.
tar xvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/selective etc/hostname
```
??? example "Expected result"
    ```shell
    etc/hostname
    ```

```bash
# Create the full-extraction directory.
mkdir ~/chapter9-validation/full
```
??? example "Expected result"
    No output.

```bash
# Extract all synthetic archive contents.
tar xvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/full
```
??? example "Expected result"
    ```shell
    etc/
    etc/hostname
    ```

```bash
# Return to the disposable workspace.
cd ~/chapter9-validation
```
??? example "Expected result"
    No output.

```bash
# Compress the tar archive with gzip.
gzip ~/chapter9-validation/myetc.tar
```
??? example "Expected result"
    No output.

```bash
# Create a gzip-compressed archive of the synthetic etc fixture.
tar czvf ~/chapter9-validation/myetc2.tgz -C ~/chapter9-validation/source etc
```
??? example "Expected result"
    ```shell
    etc/
    etc/hostname
    ```

```bash
# Create the gzip extraction directory.
mkdir ~/chapter9-validation/tgz
```
??? example "Expected result"
    No output.

```bash
# Extract the gzip-compressed archive.
tar xzvf ~/chapter9-validation/myetc2.tgz -C ~/chapter9-validation/tgz
```
??? example "Expected result"
    ```shell
    etc/
    etc/hostname
    ```

```bash
# Return to the disposable workspace.
cd ~/chapter9-validation
```
??? example "Expected result"
    No output.

!!! danger
    The next command recursively removes the listed files and directories from `/tmp`.

```bash
# Remove the owned disposable workspace and all synthetic fixtures.
sudo rm -rf ~/chapter9-validation
```
??? example "Expected result"
    No output.

```bash
# Return to the home directory.
cd ~
```
??? example "Expected result"
    No output.

> End of the lab. Do not continue to the next topic.
