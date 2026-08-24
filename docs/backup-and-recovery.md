# 9. Backup and Recovery

!!! note
    This page is structured from the source material. Commands are pending validation.

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
    `myfile` is replaced by `myfile.gz`.

```bash
# Decompress a gzip file.
gzip -d myfile.gz
```
??? example "Expected result"
    `myfile.gz` is decompressed to `myfile`.

```bash
# Display gzip file statistics.
gzip -l myfile.gz
```
??? example "Expected result"
    Compression statistics for `myfile.gz` are displayed.

### :material-application-edit-outline: bzip2 compression

bzip2 provides better compression than gzip but usually takes longer and uses more memory while compressing.

```bash
# Compress a file with bzip2.
bzip2 myfile
```
??? example "Expected result"
    `myfile` is replaced by `myfile.bz2`.

```bash
# Decompress a bzip2 file.
bzip2 -d myfile.bz2
```
??? example "Expected result"
    `myfile.bz2` is decompressed to `myfile`.

```bash
# Compress a file at compression level 1.
bzip2 -1 myfile
```
??? example "Expected result"
    `myfile` is compressed using the lower compression setting.

### :material-application-edit-outline: xz compression

xz uses LZMA2. It provides a higher compression ratio but can take significantly longer and use more memory than gzip or bzip2; decompression is faster than bzip2.

```bash
# Compress a file with xz.
xz myfile
```
??? example "Expected result"
    A file named `myfile.xz` is created.

```bash
# Decompress an xz file.
xz -d myfile.xz
```
??? example "Expected result"
    `myfile.xz` is decompressed to `myfile`.

```bash
# Compress with xz at maximum extreme compression.
xz -e -9 myfile
```
??? example "Expected result"
    `myfile` is compressed using the requested xz settings.

```bash
# Display xz file statistics.
xz -l myfile.xz
```
??? example "Expected result"
    Compression statistics for `myfile.xz` are displayed.

## :material-book-open-page-variant-outline: 9.2 Tar Archiving

`tar` means tape archiving. A tar archive gathers files into one file without compression; a tarball is a common name for such an archive.

```bash
# Create an archive from two files.
tar cvf myfiles.tar myfile1 myfile2
```
??? example "Expected result"
    `myfiles.tar` is created and processed files are listed.

`c` creates an archive, `v` lists processed files verbosely, and `f` precedes the archive filename.

```bash
# Extract an archive.
tar xvf myfiles.tar
```
??? example "Expected result"
    Archive contents are extracted and listed.

```bash
# List archive contents.
tar tvf myfiles.tar
```
??? example "Expected result"
    Files stored in `myfiles.tar` are listed.

```bash
# Extract an archive into another directory.
tar xvf /mnt/mydir.tar -C /home/alex/temp
```
??? example "Expected result"
    Archive contents are extracted into `/home/alex/temp`.

### :material-application-edit-outline: Tar with gzip

Use `-z` with tar for gzip compression.

```bash
# Create a gzip-compressed tar archive.
tar czvf myfile.tar.gz myfile
```
??? example "Expected result"
    `myfile.tar.gz` is created and the archived file is listed.

```bash
# List a gzip-compressed tar archive.
tar tzvf myfile.tar.gz
```
??? example "Expected result"
    Files in `myfile.tar.gz` are listed.

```bash
# Extract a gzip-compressed tar archive.
tar xzvf myfile.tar.gz
```
??? example "Expected result"
    Archive contents are extracted and listed.

### :material-application-edit-outline: Tar with bzip2

Use `-j` with tar for bzip2 compression.

```bash
# Create a bzip2-compressed tar archive.
tar cjvf myfile.tar.bz2 myfile
```
??? example "Expected result"
    `myfile.tar.bz2` is created and the archived file is listed.

```bash
# List a bzip2-compressed tar archive.
tar tjvf myfile.tar.bz2
```
??? example "Expected result"
    Files in `myfile.tar.bz2` are listed.

```bash
# Extract a bzip2-compressed tar archive.
tar xjvf myfile.tar.bz2
```
??? example "Expected result"
    Archive contents are extracted and listed.

### :material-application-edit-outline: Tar with xz

Use `-J` with tar for xz compression.

```bash
# Create an xz-compressed tar archive.
tar cJvf myfile.tar.xz myfile
```
??? example "Expected result"
    `myfile.tar.xz` is created and the archived file is listed.

```bash
# List an xz-compressed tar archive.
tar tJvf myfile.tar.xz
```
??? example "Expected result"
    Files in `myfile.tar.xz` are listed.

```bash
# Extract an xz-compressed tar archive.
tar xJvf myfile.tar.xz
```
??? example "Expected result"
    Archive contents are extracted and listed.

## :material-book-open-page-variant-outline: 9.3 Using rsync

rsync copies and synchronizes files and directories locally or remotely, across directories, disks, and networks. It supports copying links, devices, owners, groups, and permissions, and can compress data during transfer.

```bash
# Use the general rsync syntax.
rsync options SOURCE DESTINATION
```
??? example "Expected result"
    Files are synchronized according to the supplied options and paths.

Common options are `-v` for verbose output, `-r` for recursive copying, `-a` for archive mode, `-z` to compress data, and `-P` to show progress.

```bash
# Synchronize a local file to a backup directory.
rsync -avP file.tar /path-to/backups/
```
??? example "Expected result"
    `file.tar` is copied to the destination with progress output.

```bash
# Synchronize a local directory to a backup directory.
rsync -avP /home/user/ /path-to/backups/
```
??? example "Expected result"
    Directory contents are synchronized to the destination.

```bash
# Synchronize a local directory and delete destination-only files.
rsync -avP --delete /home/user/ /path-to/backups/
```
??? example "Expected result"
    The destination is synchronized with the source, including deletion of destination-only files.

!!! warning
    `--delete` removes destination files that are absent from the source. Confirm the source and destination before running it.

```bash
# Synchronize a local directory to a remote server.
rsync -azvP /home/user/ user@10.10.10.10:/pathto/backup/
```
??? example "Expected result"
    Directory contents are transferred to the specified remote destination.

```bash
# Synchronize a remote directory to a local directory.
rsync -azvP user@10.10.10.10:/path-to/backup/ /tmp/local/
```
??? example "Expected result"
    Remote directory contents are transferred to `/tmp/local/`.

Use `-z` to compress data during network transfer. `--compress-level=NUM` sets an explicit compression level.

### :material-application-edit-outline: Using rsync with SSH

Use `-e ssh` to transfer data through SSH.

```bash
# Copy a remote file locally through SSH.
rsync -azvPe ssh user@10.10.10.10:/path-to/file.txt /tmp/
```
??? example "Expected result"
    The specified remote file is copied to `/tmp/`.

```bash
# Copy a local file to a remote location through SSH.
rsync -azvPe ssh file.txt user@10.10.10.10:/pathto/backups/
```
??? example "Expected result"
    `file.txt` is copied to the specified remote destination.

### :material-application-edit-outline: Include, exclude, and transfer limits

```bash
# Include names beginning with A and exclude all other names.
rsync -azvPe ssh --include 'A*' --exclude '*' user@10.10.10.10:/path-to/files /tmp
```
??? example "Expected result"
    Only matching files and directories are transferred to `/tmp`.

```bash
# Transfer files no larger than 500k from a remote log directory.
rsync -azvPe ssh --max-size='500k' 10.10.10.10:/var/log/ /tmp/
```
??? example "Expected result"
    Eligible files of 500k or smaller are transferred to `/tmp/`.

```bash
# Remove source files after successful local transfer.
rsync -azvP --remove-source-files file.txt /tmp/
```
??? example "Expected result"
    `file.txt` is transferred and removed from the source after success.

!!! warning
    `--remove-source-files` deletes source files after transfer. Confirm the destination before running it.

```bash
# Preview an rsync transfer without changing files.
rsync -azvP --dry-run file.txt /tmp/
```
??? example "Expected result"
    Planned transfer actions are listed without changing files.

```bash
# Limit an SSH rsync transfer to 100 KBytes per second.
rsync --bwlimit=100 -azvPe ssh /path-to/files/ user@10.10.10.10:/path-to/backup/
```
??? example "Expected result"
    Files are transferred with the configured bandwidth limit.

## :material-book-open-page-variant-outline: 9.4 Backup and Recovery Lab

This lab uses tar to create, list, update, delete, extract, and gzip-compress archives.

```bash
# Open the tar manual.
man tar
```
??? example "Expected result"
    The `tar` manual opens. Press `q` to exit.

```bash
# Create a tar archive of /etc.
sudo tar cf /tmp/myetc.tar /etc
```
??? example "Expected result"
    `/tmp/myetc.tar` is created.

```bash
# List the archive contents.
tar tf /tmp/myetc.tar
```
??? example "Expected result"
    Files stored in `/tmp/myetc.tar` are listed.

```bash
# Add root's bashrc to the archive.
sudo tar uvf /tmp/myetc.tar /root/.bashrc
```
??? example "Expected result"
    `/root/.bashrc` is added to the archive.

```bash
# Verify root's bashrc is in the archive.
tar tf /tmp/myetc.tar | grep root/.bashrc
```
??? example "Expected result"
    ```text
    root/.bashrc
    ```

!!! danger
    The next command deletes an entry from the archive. Confirm the archive and entry name before running it.

```bash
# Delete root's bashrc from the archive.
sudo tar --delete -f /tmp/myetc.tar root/.bashrc
```
??? example "Expected result"
    `root/.bashrc` is removed from `/tmp/myetc.tar`.

```bash
# Verify root's bashrc is no longer in the archive.
tar tf /tmp/myetc.tar | grep root/.bashrc
```
??? example "Expected result"
    No output.

```bash
# Change to the temporary directory.
cd /tmp
```
??? example "Expected result"
    No output.

```bash
# Extract etc/hostname from the archive.
tar xvf myetc.tar etc/hostname
```
??? example "Expected result"
    ```text
    etc/hostname
    ```

```bash
# Create an extraction directory and enter it.
mkdir /tmp/tar && cd /tmp/tar
```
??? example "Expected result"
    No output.

```bash
# Extract all archive contents.
tar xvf /tmp/myetc.tar
```
??? example "Expected result"
    Archive contents are extracted and listed.

```bash
# Return to the temporary directory.
cd /tmp
```
??? example "Expected result"
    No output.

```bash
# Compress the tar archive with gzip.
sudo gzip myetc.tar
```
??? example "Expected result"
    `/tmp/myetc.tar.gz` is created.

```bash
# Create a gzip-compressed archive of /etc.
sudo tar czvf /tmp/myetc2.tgz /etc
```
??? example "Expected result"
    `/tmp/myetc2.tgz` is created and archived paths are listed.

```bash
# Create a gzip extraction directory and enter it.
mkdir /tmp/tgz && cd /tmp/tgz
```
??? example "Expected result"
    No output.

```bash
# Extract the gzip-compressed archive.
tar xzvf /tmp/myetc2.tgz
```
??? example "Expected result"
    Archive contents are extracted and listed.

```bash
# Return to the temporary directory.
cd /tmp
```
??? example "Expected result"
    No output.

!!! danger
    The next command recursively removes the listed files and directories from `/tmp`.

```bash
# Remove the temporary files and directories created by this lab.
sudo rm -rf tar tgz etc myetc.tar.gz myetc2.tgz
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
