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
    Validation pending; no captured output is available.

```bash
# Inspect partition tables
sudo fdisk -l
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a GPT table on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the vdb partition table
sudo fdisk -l /dev/vdb
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a partition spanning vdb
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show vdb partition details
sudo parted /dev/vdb print
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create an MBR table on vdc
sudo parted /dev/vdc mklabel msdos
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a partition spanning vdc
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show vdc partition details
sudo parted /dev/vdc print
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the vdc partition
sudo parted /dev/vdc rm 1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create an ext4 filesystem on vdb1
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Enable the ext4 ACL mount option
sudo tune2fs -o acl /dev/vdb1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Mount vdb1 at the mount point
sudo mount /dev/vdb1 /mnt/mymount
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the mount point
sudo mkdir /mnt/mymount
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Define an fstab entry by device
/dev/vdb2 /boot ext4 defaults 0 2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Define an fstab entry by UUID
UUID=1ea4363f-f9ab-45d8-af48-067b05d202b2 /boot ext4 defaults 0 2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Define a user-mountable fstab entry by label
LABEL=mystuff /mystuff ext4 noauto,user 0 0
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List block devices
sudo lsblk
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Format vdb1 as ext4
sudo mkfs.ext4 /dev/vdb1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the ext4 mount point
sudo mkdir /mnt/myext4fs
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Mount vdb1
sudo mount /dev/vdb1 /mnt/myext4fs
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the vdb mount
mount | grep vdb
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Display available filesystem space
df -h
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Edit fstab
sudo nano /etc/fstab
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add the vdb1 fstab entry
/dev/vdb1   /mnt/myext4fs   ext4    defaults    0 0
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Unmount vdb1
sudo umount /dev/vdb1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Mount all fstab filesystems
sudo mount -a
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Confirm the fstab mount
mount | grep vdb
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Unmount the filesystem
sudo umount /dev/vdb1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Partition vdb for LVM
fdisk /dev/vdb
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create physical volumes
pvcreate /dev/vda3 /dev/vda4
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a volume group
vgcreate ubuntu-vg /dev/vda3 /dev/vda4
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a logical volume
lvcreate -L 100G -n UB2 ubuntu-vg
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Find 10 GB block devices
sudo lsblk -a -p -o name,size | grep 10G
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Overwrite vdb with zeros
sudo dd if=/dev/zero of=/dev/vdb bs=4096
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Overwrite vdc with zeros
sudo dd if=/dev/zero of=/dev/vdc bs=4096
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a GPT label on vdb
sudo parted /dev/vdb mklabel gpt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a GPT label on vdc
sudo parted /dev/vdc mklabel gpt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a full vdb partition
sudo parted /dev/vdb mkpart primary 1 100%
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create a full vdc partition
sudo parted /dev/vdc mkpart primary 1 100%
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install LVM tools
sudo apt install -y lvm2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Scan existing volume groups
sudo vgscan
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create LVM physical volumes
sudo pvcreate /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List physical volumes
sudo pvs
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the ubuntu-vg volume group
sudo vgcreate ubuntu-vg /dev/vdb1 /dev/vdc1
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List volume groups
sudo vgs
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the lvmdata logical volume
sudo lvcreate -l 100%VG -n lvmdata ubuntu-vg
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List logical volumes
sudo lvs
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Display logical volume details
sudo lvdisplay
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Format the logical volume as ext4
sudo mkfs.ext4 /dev/ubuntu-vg/lvmdata
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create the LVM mount point
sudo mkdir /lvmdata
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Mount the logical volume
sudo mount /dev/ubuntu-vg/lvmdata /lvmdata
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show mounted logical-volume space
df -h /lvmdata
```
??? example "Expected result"
    Validation pending; no captured output is available.
