# Prerequisites

!!! abstract
    Each learner receives a dedicated outer Ubuntu student host that provides access to a ready LAB HOST.

## :material-book-open-page-variant-outline: Lab layout

The outer `STUDENT HOST` is an Ubuntu 22.04 virtual machine. Its nested `LAB HOST` runs Ubuntu 24.04.2 and is reachable at `192.168.100.4`. Course staff prepare its network. Run all chapter exercises on the LAB HOST after you sign in.

## :material-book-open-page-variant-outline: Access

You receive your individual outer-host address and credentials through the approved channel. Connect to the outer host as `ubuntu`, then sign in from there as `ubuntu@192.168.100.4`.

## :material-book-open-page-variant-outline: Expected initial state

- STUDENT HOST: Ubuntu 22.04.5, 4 vCPUs, about 16 GB of memory, and 40 GiB root storage.
- LAB HOST: Ubuntu 24.04.2, 2 vCPUs, about 4 GB of memory, and a `vda` system disk.
- LAB HOST: empty, disposable 10 GB `vdb` and `vdc` disks reserved for storage exercises.

## :material-book-open-page-variant-outline: Check your environment

Run the first two commands on the STUDENT HOST before signing in. Then sign in to the LAB HOST and run the remaining commands.

```bash
# Show the STUDENT HOST operating-system release.
lsb_release -d
```

??? example "Expected result"
    `Description:	Ubuntu 22.04.5 LTS`

```bash
# List the STUDENT HOST block devices.
lsblk
```

??? example "Expected result"
    ```text
    NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0     7:0    0    74M  1 loop /snap/core22/2437
    loop1     7:1    0  66.8M  1 loop /snap/core24/1643
    loop2     7:2    0 352.3M  1 loop /snap/google-cloud-cli/489
    loop3     7:3    0 115.3M  1 loop /snap/lxd/40338
    loop4     7:4    0  50.1M  1 loop /snap/snapd/27710
    sda       8:0    0    40G  0 disk
    |-sda1    8:1    0  39.9G  0 part /
    |-sda14   8:14   0     4M  0 part
    `-sda15   8:15   0   106M  0 part /boot/efi
    ```

    Device details can vary. Verify the root filesystem is on `sda1` and the disk is about 40 GB.

```bash
# Show the LAB HOST operating-system release.
lsb_release -d
```

??? example "Expected result"
    `Description:	Ubuntu 24.04.2 LTS`

```bash
# Show the number of LAB HOST processors available.
nproc
```

??? example "Expected result"
    `2`

```bash
# Show LAB HOST memory use.
free -h
```

??? example "Expected result"
    ```text
                   total        used        free      shared  buff/cache   available
    Mem:           3.8Gi       407Mi       3.4Gi       984Ki       277Mi       3.4Gi
    Swap:             0B          0B          0B
    ```

    Live memory use varies. Verify about 4 GB of memory is available.

```bash
# List LAB HOST block devices.
lsblk
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
    vdc     253:32   0   10G  0 disk
    ```

    Device details can vary. Verify `vda` is the system disk and `vdb` and `vdc` are 10 GB disks without partitions.

```bash
# Test LAB HOST name resolution and outbound connectivity.
ping -c 3 ubuntu.com
```

??? example "Expected result"
    ```text
    PING ubuntu.com (185.125.190.20) 56(84) bytes of data.
    64 bytes from website-content-cache-1.ps5.canonical.com (185.125.190.20): icmp_seq=1 ttl=60 time=13.4 ms
    64 bytes from website-content-cache-1.ps5.canonical.com (185.125.190.20): icmp_seq=2 ttl=60 time=13.4 ms
    64 bytes from website-content-cache-1.ps5.canonical.com (185.125.190.20): icmp_seq=3 ttl=60 time=13.4 ms

    --- ubuntu.com ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2003ms
    rtt min/avg/max/mdev = 13.421/13.426/13.434/0.005 ms
    ```

    The resolved address and timings vary. Verify three replies and zero packet loss.

## :material-book-open-page-variant-outline: Safety

!!! warning
    `/dev/vdb` and `/dev/vdc` are intentionally disposable lab disks. Later storage exercises partition, format, and overwrite them. Do not use them for personal data.
