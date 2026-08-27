# Prerequisites

!!! abstract
    Each learner receives access to `LABHOST`, which provides access to `LABVM`.

## :material-book-open-page-variant-outline: Lab layout

`LABHOST` is the assigned GCP VM that you reach from your local computer using configured SSH keys. `LABVM` is your nested internal VM. Reach it from `LABHOST` with the course-provided password. Run all chapter exercises on `LABVM`.

## :material-book-open-page-variant-outline: Access

1. From your local computer, connect to your assigned `LABHOST`. Course staff provide the actual username and public IP address through the approved channel.

    ```bash
    # Connect to the assigned LABHOST using your configured SSH keys.
    ssh <LABHOST_USER>@<LABHOST_PUBLIC_IP>
    ```

    ??? example "Expected result"
        ```shell
        Expanded Security Maintenance for Applications is not enabled.
        ```

2. From `LABHOST`, connect to `LABVM` using the source-lab LABVM password: `canonical_lab`.

    ```bash
    # Connect from LABHOST to LABVM.
    # password is: canonical_lab
    ssh ubuntu@192.168.100.4
    ```

    ??? example "Expected result"
        ```shell
        ubuntu@ubuntu:~$
        ```

Run `exit` once to return from `LABVM` to `LABHOST`. Run `exit` a second time to return from `LABHOST` to your local machine.

## :material-book-open-page-variant-outline: Expected initial state

- `LABHOST`: Ubuntu 22.04.5, 4 vCPUs, about 16 GB of memory, and 40 GiB root storage.
- `LABVM` root filesystem had 328 MiB available (87% used) after the Chapter 3 package repair; capacity and disk layout are validated separately for each assigned environment.

## :material-book-open-page-variant-outline: Check your environment

After step 1, run the first two checks on `LABHOST`. Then complete step 2 and run the remaining checks on `LABVM`, which is the environment for every chapter exercise.

```bash
# Show the LABHOST operating-system release.
lsb_release -d
```

??? example "Expected result"
    ```shell
    Description:	Ubuntu 22.04.5 LTS
    ```

```bash
# List LABHOST block devices.
lsblk
```

??? example "Expected result"
    ```shell
    NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    sda       8:0    0    40G  0 disk
    ├─sda1    8:1    0  39.9G  0 part /
    ├─sda14   8:14   0     4M  0 part
    └─sda15   8:15   0   106M  0 part /boot/efi
    ```

    Device details can vary. Verify the root filesystem is on `sda1` and the disk is about 40 GB.

```bash
# Show the LABVM operating-system release.
lsb_release -d
```

??? example "Expected result"
    ```shell
    No LSB modules are available.
    Description:	Ubuntu 24.04.2 LTS
    ```

```bash
# Show the number of LABVM processors available.
nproc
```

??? example "Expected result"
    ```shell
    2
    ```

```bash
# Show LABVM memory use.
free -h
```

??? example "Expected result"
    ```shell
                   total        used        free      shared  buff/cache   available
    Mem:           3.8Gi       415Mi       3.4Gi       956Ki       277Mi       3.4Gi
    Swap:             0B          0B          0B
    ```

```bash
# List LABVM block devices.
lsblk
```

??? example "Expected result"
    ```shell
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
    vda     253:0    0  3.5G  0 disk
    ├─vda1  253:1    0  2.5G  0 part /
    ├─vda14 253:14   0    4M  0 part
    ├─vda15 253:15   0  106M  0 part /boot/efi
    └─vda16 259:0    0  913M  0 part /boot
    vdb     253:16   0   10G  0 disk
    vdc     253:32   0   10G  0 disk
    ```

```bash
# Test LABVM name resolution and outbound connectivity.
ping -c 3 ubuntu.com
```

??? example "Expected result"
    ```shell
    3 packets transmitted, 3 received, 0% packet loss
    ```

## :material-book-open-page-variant-outline: Safety

!!! warning
    `/dev/vdb` and `/dev/vdc` are intentionally disposable lab disks. Later storage exercises partition, format, and overwrite them. Do not use them for personal data.
