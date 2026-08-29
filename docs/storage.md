# 6. Storage

!!! note
    Replacement-LABVM validation is complete. All page commands have captured results.

!!! abstract
    Partition block devices, create and mount ext4 filesystems, and use LVM.

!!! danger
    Partitioning, formatting, and LVM commands can destroy data. The source lab reserves the first block device for the host operating system; do not use it for lab activity.

## :material-book-open-page-variant-outline: 6.1 Partitioning

A partition is space on a block device allocated to a filesystem. A device can have one partition spanning the device or multiple partitions. The partition table describes the layout and is read before other device data. Linux uses MBR and GPT partition-table schemes.

MBR supports older hardware, up to four primary partitions, and disks or partitions no larger than 2 TiB. It requires legacy mode with grub-pc and stores GRUB in the MBR. GPT supports more primary partitions, larger disks and partitions, and a redundant partition-information copy for recovery. `parted` can create, destroy, resize, move, and copy partitions.

### :material-application-edit-outline: 6.1.1 Partitioning Lab

```bash
# List block devices
sudo lsblk
```
??? example "Expected result"
    ```text
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
    vda     253:0    0  3.5G  0 disk
    |-vda1  253:1    0  2.5G  0 part /
    |-vda14 253:14   0    4M  0 part
    |-vda15 253:15   0  106M  0 part /boot/efi
    `-vda16 259:0    0  913M  0 part /boot
    vdb     253:16   0   10G  0 disk
    `-vdb1  253:17   0   10G  0 part
    vdc     253:32   0   10G  0 disk
    ```

```bash
# Inspect partition tables
sudo fdisk -l
```
??? example "Expected result"
    ```text
    Disk /dev/vdb: 10 GiB, 10737418240 bytes, 20971520 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt

    Device     Start      End  Sectors Size Type
    /dev/vdb1   2048 20969471 20967424  10G Linux filesystem

    Disk /dev/vdc: 10 GiB, 10737418240 bytes, 20971520 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    ```
    The complete listing also includes the system disk and its partitions.

```bash
# Create a GPT table on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    ```text
    Warning: The existing disk label on /dev/vdb will be destroyed and all data on
    this disk will be lost. Do you want to continue?
    Yes/No? Yes
    Information: You may need to update /etc/fstab.
    ```

```bash
# Verify the vdb partition table
sudo fdisk -l /dev/vdb
```
??? example "Expected result"
    ```text
    Disk /dev/vdb: 10 GiB, 10737418240 bytes, 20971520 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    ```
    The disk identifier varies.

```bash
# Create a partition spanning vdb
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Show vdb partition details
sudo parted /dev/vdb print
```
??? example "Expected result"
    ```text
    Model: Virtio Block Device (virtblk)
    Disk /dev/vdb: 10.7GB
    Sector size (logical/physical): 512B/512B
    Partition Table: gpt
    Disk Flags:

    Number  Start   End     Size    File system  Name     Flags
     1      1049kB  10.7GB  10.7GB  ext4         primary
    ```

```bash
# Create an MBR table on vdc
sudo parted /dev/vdc mklabel msdos
```
??? example "Expected result"
    ```text
    Warning: The existing disk label on /dev/vdc will be destroyed and all data on
    this disk will be lost. Do you want to continue?
    Yes/No? Yes
    Information: You may need to update /etc/fstab.
    ```

```bash
# Create a partition spanning vdc
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Show vdc partition details
sudo parted /dev/vdc print
```
??? example "Expected result"
    ```text
    Model: Virtio Block Device (virtblk)
    Disk /dev/vdc: 10.7GB
    Sector size (logical/physical): 512B/512B
    Partition Table: msdos
    Disk Flags:

    Number  Start   End     Size    Type     File system  Flags
     1      1049kB  10.7GB  10.7GB  primary
    ```

```bash
# Remove the vdc partition
sudo parted /dev/vdc rm 1
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Create an ext4 filesystem on vdb1
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    ```text
    mke2fs 1.47.0 (5-Feb-2023)
    /dev/vdb1 contains a ext4 file system
            created on Sat Aug 29 11:59:39 2026
    Proceed anyway? (y,N) Creating filesystem with 2620928 4k blocks and 655360 inodes
    Filesystem UUID: 95bb1fbc-b01f-4e0f-9be3-fa6390c059a1
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

    Creating journal (16384 blocks): done
    ```
    The creation time and filesystem UUID vary.

```bash
# Enable the ext4 ACL mount option
sudo tune2fs -o acl /dev/vdb1
```
??? example "Expected result"
    ```text
    tune2fs 1.47.0 (5-Feb-2023)
    ```

```bash
# Create the mount point
sudo mkdir /mnt/mymount
```
??? example "Expected result"
    No output.

```bash
# Mount vdb1 at the mount point
sudo mount /dev/vdb1 /mnt/mymount
```
??? example "Expected result"
    No output.

!!! warning
    The later filesystem lab reformats `/dev/vdb1`. Unmount this earlier illustrative mount first; formatting a mounted filesystem is unsafe.

```bash
# Unmount vdb1 before the later reformat
sudo umount /dev/vdb1
```
??? example "Expected result"
    No output.

The following are reference `/etc/fstab` entry formats, not shell commands. The `/dev/vdb2` example is not created in this lab.

```text
/dev/vdb2 /boot ext4 defaults 0 2
UUID=1ea4363f-f9ab-45d8-af48-067b05d202b2 /boot ext4 defaults 0 2
LABEL=mystuff /mystuff ext4 noauto,user 0 0
```

## :material-book-open-page-variant-outline: 6.2 File Systems

### :material-application-edit-outline: 6.2.1 Filesystems Lab

```bash
# List block devices
sudo lsblk
```
??? example "Expected result"
    ```text
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
    vda     253:0    0  3.5G  0 disk
    |-vda1  253:1    0  2.5G  0 part /
    |-vda14 253:14   0    4M  0 part
    |-vda15 253:15   0  106M  0 part /boot/efi
    `-vda16 259:0    0  913M  0 part /boot
    vdb     253:16   0   10G  0 disk
    `-vdb1  253:17   0   10G  0 part
    vdc     253:32   0   10G  0 disk
    ```

```bash
# Format vdb1 as ext4
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    ```text
    mke2fs 1.47.0 (5-Feb-2023)
    Creating filesystem with 2620928 4k blocks and 655360 inodes
    Filesystem UUID: 56ffbefb-9acb-4be2-bcf5-e012a082d0e7
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

    Creating journal (16384 blocks): done
    ```
    The filesystem UUID varies.

```bash
# Create the ext4 mount point
sudo mkdir /mnt/myext4fs
```
??? example "Expected result"
    No output.

```bash
# Mount vdb1
sudo mount /dev/vdb1 /mnt/myext4fs
```
??? example "Expected result"
    No output.

```bash
# Verify the vdb mount
mount | grep vdb
```
??? example "Expected result"
    ```text
    /dev/vdb1 on /mnt/myext4fs type ext4 (rw,relatime)
    ```

```bash
# Display available filesystem space
df -h
```
??? example "Expected result"
    ```text
    Filesystem      Size  Used Avail Use% Mounted on
    tmpfs           392M  980K  391M   1% /run
    /dev/vda1       2.4G  2.2G  216M  91% /
    tmpfs           2.0G     0  2.0G   0% /dev/shm
    tmpfs           5.0M     0  5.0M   0% /run/lock
    /dev/vda16      881M  117M  703M  15% /boot
    /dev/vda15      105M  6.1M   99M   6% /boot/efi
    tmpfs           392M   12K  392M   1% /run/user/1000
    /dev/vdb1       9.8G   24K  9.3G   1% /mnt/myext4fs
    ```
    Capacity and use values vary.

To persist this filesystem, add an `/etc/fstab` entry with an editor such as `sudo nano /etc/fstab`, then validate the configuration with `sudo mount -a` before rebooting. For example:

```text
/dev/vdb1   /mnt/myext4fs   ext4    defaults    0 0
```

This sequential LAB workflow deliberately does not retain that entry: `/dev/vdb` is repurposed and wiped in the following LVM lab, so retaining an entry for `/dev/vdb1` would leave an invalid boot-time mount configuration.

```bash
# Unmount the filesystem
sudo umount /dev/vdb1
```
??? example "Expected result"
    No output.

## :material-book-open-page-variant-outline: 6.3 LVM

### :material-application-edit-outline: 6.3.1 LVM Lab

The earlier command-line examples are reference syntax only. Do not apply their `/dev/vda3` or `/dev/vda4` examples to the LABVM system disk. The following LVM lab instead uses its dedicated 10 GB `/dev/vdb` and `/dev/vdc` devices.

```bash
# Find 10 GB block devices
sudo lsblk -a -p -o name,size | grep 10G
```
??? example "Expected result"
    ```text
    /dev/vdb       10G
    `-/dev/vdb1    10G
    /dev/vdc       10G
    ```

```bash
# Overwrite vdb with zeros
sudo dd if=/dev/zero of=/dev/vdb bs=4096
```
??? example "Expected result"
    ```text
    dd: error writing '/dev/vdb': No space left on device
    2621441+0 records in
    2621440+0 records out
    10737418240 bytes (11 GB, 10 GiB) copied, 37.6842 s, 285 MB/s
    ```
    The duration and transfer rate vary.

```bash
# Overwrite vdc with zeros
sudo dd if=/dev/zero of=/dev/vdc bs=4096
```
??? example "Expected result"
    ```text
    dd: error writing '/dev/vdc': No space left on device
    2621441+0 records in
    2621440+0 records out
    10737418240 bytes (11 GB, 10 GiB) copied, 37.9567 s, 283 MB/s
    ```
    The duration and transfer rate vary.

```bash
# Create a GPT label on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Create a GPT label on vdc
sudo parted /dev/vdc mklabel gpt
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Create a full vdb partition
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Create a full vdc partition
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    ```text
    Information: You may need to update /etc/fstab.
    ```

```bash
# Install LVM tools
sudo apt install -y lvm2
```
??? example "Expected result"
    ```text
    WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

    Reading package lists...
    Building dependency tree...
    Reading state information...
    6 upgraded, 0 newly installed, 0 to remove and 93 not upgraded.
    Setting up lvm2 (2.03.16-3ubuntu3.2) ...
    ```

```bash
# Scan existing volume groups
sudo vgscan
```
??? example "Expected result"
    No output.

```bash
# Create LVM physical volumes
sudo pvcreate /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    ```text
    Physical volume "/dev/vdb1" successfully created.
    Physical volume "/dev/vdc1" successfully created.
    ```

```bash
# List physical volumes
sudo pvs
```
??? example "Expected result"
    ```text
    PV         VG Fmt  Attr PSize   PFree
    /dev/vdb1     lvm2 ---  <10.00g <10.00g
    /dev/vdc1     lvm2 ---  <10.00g <10.00g
    ```

```bash
# Create the ubuntu-vg volume group
sudo vgcreate ubuntu-vg /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    ```text
    Volume group "ubuntu-vg" successfully created
    ```

```bash
# List volume groups
sudo vgs
```
??? example "Expected result"
    ```text
    VG        #PV #LV #SN Attr   VSize  VFree
    ubuntu-vg   2   0   0 wz--n- 19.99g 19.99g
    ```

```bash
# Create the lvmdata logical volume
sudo lvcreate -l 100%VG -n lvmdata ubuntu-vg
```
??? example "Expected result"
    ```text
    Logical volume "lvmdata" created.
    ```

```bash
# List logical volumes
sudo lvs
```
??? example "Expected result"
    ```text
    LV      VG        Attr       LSize
    lvmdata ubuntu-vg -wi-a----- 19.99g
    ```

```bash
# Display logical volume details
sudo lvdisplay
```
??? example "Expected result"
    ```text
    --- Logical volume ---
    LV Path                /dev/ubuntu-vg/lvmdata
    LV Name                lvmdata
    VG Name                ubuntu-vg
    LV Write Access        read/write
    LV Status              available
    # open                 0
    LV Size                19.99 GiB
    Current LE             5118
    Segments               2
    ```

```bash
# Format the logical volume as ext4
sudo mkfs.ext4 /dev/ubuntu-vg/lvmdata
```
??? example "Expected result"
    ```text
    mke2fs 1.47.0 (5-Feb-2023)
    Creating filesystem with 5240832 4k blocks and 1310720 inodes
    Superblock backups stored on blocks:
            32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
            4096000

    Creating journal (32768 blocks): done
    ```

```bash
# Create the LVM mount point
sudo mkdir /lvmdata
```
??? example "Expected result"
    No output.

```bash
# Mount the logical volume
sudo mount /dev/ubuntu-vg/lvmdata /lvmdata
```
??? example "Expected result"
    No output.

```bash
# Show mounted logical-volume space
df -h /lvmdata
```
??? example "Expected result"
    ```text
    Filesystem                      Size  Used Avail Use% Mounted on
    /dev/mapper/ubuntu--vg-lvmdata   20G   24K   19G   1% /lvmdata
    ```
