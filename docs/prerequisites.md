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
        Validation pending; no captured output is available.

2. From `LABHOST`, connect to `LABVM`. The course password is supplied separately and is never displayed.

    ```bash
    # Connect from LABHOST to LABVM.
    ssh ubuntu@192.168.100.4
    ```

    ??? example "Expected result"
        Validation pending; no captured output is available.

Run `exit` once to return from `LABVM` to `LABHOST`. Run `exit` a second time to return from `LABHOST` to your local machine.

## :material-book-open-page-variant-outline: Expected initial state

- `LABHOST`: Ubuntu 22.04.5, 4 vCPUs, about 16 GB of memory, and 40 GiB root storage.
- `LABVM` capacity and disk layout are validated separately for each assigned environment.

## :material-book-open-page-variant-outline: Check your environment

After step 1, run the first two checks on `LABHOST`. Then complete step 2 and run the remaining checks on `LABVM`, which is the environment for every chapter exercise.

```bash
# Show the LABHOST operating-system release.
lsb_release -d
```

??? example "Expected result"
    `Description:	Ubuntu 22.04.5 LTS`

```bash
# List LABHOST block devices.
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
# Show the LABVM operating-system release.
lsb_release -d
```

??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the number of LABVM processors available.
nproc
```

??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show LABVM memory use.
free -h
```

??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List LABVM block devices.
lsblk
```

??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Test LABVM name resolution and outbound connectivity.
ping -c 3 ubuntu.com
```

??? example "Expected result"
    Validation pending; no captured output is available.

## :material-book-open-page-variant-outline: Safety

!!! warning
    `/dev/vdb` and `/dev/vdc` are intentionally disposable lab disks. Later storage exercises partition, format, and overwrite them. Do not use them for personal data.
