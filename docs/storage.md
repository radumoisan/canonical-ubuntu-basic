# 6. Storage

!!! note
    Structured from the source material. Command validation is pending.

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
    Block devices and partitions are listed. Device names vary.

```bash
# Inspect partition tables
sudo fdisk -l
```
??? example "Expected result"
    Disk and partition-table details are displayed.

```bash
# Create a GPT table on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    No output on success.

```bash
# Verify the vdb partition table
sudo fdisk -l /dev/vdb
```
??? example "Expected result"
    The output includes `Disklabel type: gpt`.

```bash
# Create a partition spanning vdb
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    No output on success.

```bash
# Show vdb partition details
sudo parted /dev/vdb print
```
??? example "Expected result"
    The partition table and the new partition are displayed.

```bash
# Create an MBR table on vdc
sudo parted /dev/vdc mklabel msdos
```
??? example "Expected result"
    No output on success.

```bash
# Create a partition spanning vdc
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    No output on success.

```bash
# Show vdc partition details
sudo parted /dev/vdc print
```
??? example "Expected result"
    The partition table and the new partition are displayed.

```bash
# Remove the vdc partition
sudo parted /dev/vdc rm 1
```
??? example "Expected result"
    No output on success. Partition 1 is removed.

## :material-book-open-page-variant-outline: 6.2 File Systems

A filesystem provides the methods and data structures used to organize files on a partition. Creating a filesystem initializes the bookkeeping structures. Common concepts include the superblock, inode, data block, directory block, and indirect block.

This course uses ext4, a journaled filesystem included since kernel 2.6.28 and the default root filesystem format through Ubuntu 24.04. It supports filesystems up to 1 exabyte and files up to 16 TB, is backward-compatible with ext2 and ext3, and supports preallocation, delayed allocation, and multiblock allocation.

```bash
# Create an ext4 filesystem on vdb1
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    Filesystem creation details are displayed.

```bash
# Enable the ext4 ACL mount option
sudo tune2fs -o acl /dev/vdb1
```
??? example "Expected result"
    Filesystem tuning details are displayed.

```bash
# Mount vdb1 at the mount point
sudo mount /dev/vdb1 /mnt/mymount
```
??? example "Expected result"
    No output on success. The mount point must already exist.

```bash
# Create the mount point
sudo mkdir /mnt/mymount
```
??? example "Expected result"
    No output. `/mnt/mymount` is created.

`/etc/fstab` automates mounting at startup and may be used by non-root users. Its fields are `<file system> <mount point> <type> <options> <dump> <pass>`. Filesystems can be identified by partition, UUID, label, or LVM volume. `/etc/mtab` lists mounted partitions, including manual mounts.

```bash
# Define an fstab entry by device
/dev/vdb2 /boot ext4 defaults 0 2
```
??? example "Expected result"
    No output. This is an `/etc/fstab` configuration entry.

```bash
# Define an fstab entry by UUID
UUID=1ea4363f-f9ab-45d8-af48-067b05d202b2 /boot ext4 defaults 0 2
```
??? example "Expected result"
    No output. This is an `/etc/fstab` configuration entry.

```bash
# Define a user-mountable fstab entry by label
LABEL=mystuff /mystuff ext4 noauto,user 0 0
```
??? example "Expected result"
    No output. This is an `/etc/fstab` configuration entry.

### :material-application-edit-outline: 6.2.1 Filesystems Lab

```bash
# List block devices
sudo lsblk
```
??? example "Expected result"
    Block devices and partitions are listed. Do not use the host operating-system device.

```bash
# Format vdb1 as ext4
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    Filesystem creation details are displayed.

```bash
# Create the ext4 mount point
sudo mkdir /mnt/myext4fs
```
??? example "Expected result"
    No output. `/mnt/myext4fs` is created if absent.

```bash
# Mount vdb1
sudo mount /dev/vdb1 /mnt/myext4fs
```
??? example "Expected result"
    No output on success.

```bash
# Verify the vdb mount
mount | grep vdb
```
??? example "Expected result"
    A mounted `vdb` filesystem entry is displayed.

```bash
# Display available filesystem space
df -h
```
??? example "Expected result"
    Human-readable filesystem usage is displayed.

```bash
# Edit fstab
sudo nano /etc/fstab
```
??? example "Expected result"
    `/etc/fstab` opens in nano.

Add this line at the end of the file:

```bash
# Add the vdb1 fstab entry
/dev/vdb1   /mnt/myext4fs   ext4    defaults    0 0
```
??? example "Expected result"
    No output. This is an `/etc/fstab` configuration entry.

```bash
# Unmount vdb1
sudo umount /dev/vdb1
```
??? example "Expected result"
    No output on success.

```bash
# Mount all fstab filesystems
sudo mount -a
```
??? example "Expected result"
    No output on success.

```bash
# Confirm the fstab mount
mount | grep vdb
```
??? example "Expected result"
    A mounted `vdb` filesystem entry is displayed.

```bash
# Unmount the filesystem
sudo umount /dev/vdb1
```
??? example "Expected result"
    No output on success.

## :material-book-open-page-variant-outline: 6.3 LVM

Logical Volume Management is more flexible than fixed disk partitions. LVM needs at least one volume group built from one or more physical volumes. Logical volumes are named, can span disks, and need not be physically contiguous. Leave unused space in a volume group so logical volumes can be enlarged later.

Use `fdisk`, `pvcreate`, `vgcreate`, and `lvcreate` to create logical volumes.

```bash
# Partition vdb for LVM
fdisk /dev/vdb
```
??? example "Expected result"
    The interactive `fdisk` prompt opens.

```bash
# Create physical volumes
pvcreate /dev/vda3 /dev/vda4
```
??? example "Expected result"
    Physical volume creation results are displayed.

```bash
# Create a volume group
vgcreate ubuntu-vg /dev/vda3 /dev/vda4
```
??? example "Expected result"
    Volume group creation results are displayed.

```bash
# Create a logical volume
lvcreate -L 100G -n UB2 ubuntu-vg
```
??? example "Expected result"
    Logical volume creation results are displayed.

### :material-application-edit-outline: 6.3.1 LVM Lab

```bash
# Find 10 GB block devices
sudo lsblk -a -p -o name,size | grep 10G
```
??? example "Expected result"
    Matching 10 GB device paths are displayed.

!!! danger
    The next two commands overwrite all data on the specified devices.

```bash
# Overwrite vdb with zeros
sudo dd if=/dev/zero of=/dev/vdb bs=4096
```
??? example "Expected result"
    `dd` reports bytes copied when interrupted or complete.

```bash
# Overwrite vdc with zeros
sudo dd if=/dev/zero of=/dev/vdc bs=4096
```
??? example "Expected result"
    `dd` reports bytes copied when interrupted or complete.

```bash
# Create a GPT label on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    No output on success.

```bash
# Create a GPT label on vdc
sudo parted /dev/vdc mklabel gpt
```
??? example "Expected result"
    No output on success.

```bash
# Create a full vdb partition
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    No output on success.

```bash
# Create a full vdc partition
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    No output on success.

```bash
# Install LVM tools
sudo apt install -y lvm2
```
??? example "Expected result"
    Package installation completes successfully.

```bash
# Scan existing volume groups
sudo vgscan
```
??? example "Expected result"
    Existing volume groups are reported.

```bash
# Create LVM physical volumes
sudo pvcreate /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    Physical volume creation is reported.

```bash
# List physical volumes
sudo pvs
```
??? example "Expected result"
    `vdb1` and `vdc1` appear as physical volumes.

```bash
# Create the ubuntu-vg volume group
sudo vgcreate ubuntu-vg /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    Volume group creation is reported.

```bash
# List volume groups
sudo vgs
```
??? example "Expected result"
    `ubuntu-vg` is displayed.

```bash
# Create the lvmdata logical volume
sudo lvcreate -l 100%VG -n lvmdata ubuntu-vg
```
??? example "Expected result"
    Logical volume creation is reported.

```bash
# List logical volumes
sudo lvs
```
??? example "Expected result"
    `lvmdata` is displayed.

```bash
# Display logical volume details
sudo lvdisplay
```
??? example "Expected result"
    Details include the logical volume path.

```bash
# Format the logical volume as ext4
sudo mkfs.ext4 /dev/ubuntu-vg/lvmdata
```
??? example "Expected result"
    Filesystem creation details are displayed.

```bash
# Create the LVM mount point
sudo mkdir /lvmdata
```
??? example "Expected result"
    No output. `/lvmdata` is created.

```bash
# Mount the logical volume
sudo mount /dev/ubuntu-vg/lvmdata /lvmdata
```
??? example "Expected result"
    No output on success.

```bash
# Show mounted logical-volume space
df -h /lvmdata
```
??? example "Expected result"
    Human-readable usage for `/lvmdata` is displayed.
