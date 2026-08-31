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
        Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1066-gcp x86_64)

         * Documentation:  https://help.ubuntu.com
         * Management:     https://landscape.canonical.com
         * Support:        https://ubuntu.com/pro
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

- The `LABHOST` and `LABVM` hardware, disk layout, and available capacity vary by assignment.
- Run the read-only checks in the next section to confirm the actual state of your environment before starting the course.

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
    ```text
    NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0     7:0    0    74M  1 loop /snap/core22/2437
    loop1     7:1    0  66.8M  1 loop /snap/core24/1643
    loop2     7:2    0 344.5M  1 loop /snap/google-cloud-cli/491
    loop3     7:3    0 115.3M  1 loop /snap/lxd/40338
    loop4     7:4    0  50.1M  1 loop /snap/snapd/27710
    sda       8:0    0    40G  0 disk
    |-sda1    8:1    0  39.9G  0 part /
    |-sda14   8:14   0     4M  0 part
    `-sda15   8:15   0   106M  0 part /boot/efi
    ```

Device names and sizes vary by environment. Use the listing to identify the block device that backs `/`.

```bash
# Show the LABVM operating-system release.
lsb_release -d
```

??? example "Expected result"
    ```shell
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
    ```text
                   total        used        free      shared  buff/cache   available
    Mem:           3.8Gi       402Mi       3.4Gi       960Ki       282Mi       3.4Gi
    Swap:             0B          0B          0B
    ```

```bash
# List LABVM block devices.
lsblk
```

??? example "Expected result"
    ```text
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
    vda     253:0    0  8.5G  0 disk
    |-vda1  253:1    0  7.5G  0 part /
    |-vda14 253:14   0    4M  0 part
    |-vda15 253:15   0  106M  0 part /boot/efi
    `-vda16 259:0    0  913M  0 part /boot
    vdb     253:16   0   10G  0 disk
    vdc     253:32   0   10G  0 disk
    ```

```bash
# Test LABVM name resolution and outbound connectivity.
ping -c 3 ubuntu.com
```

??? example "Expected result"
    ```text
    PING ubuntu.com (185.125.190.29) 56(84) bytes of data.
    64 bytes from website-content-cache-3.ps5.canonical.com (185.125.190.29): icmp_seq=1 ttl=60 time=13.7 ms
    64 bytes from website-content-cache-3.ps5.canonical.com (185.125.190.29): icmp_seq=2 ttl=60 time=13.7 ms
    64 bytes from website-content-cache-3.ps5.canonical.com (185.125.190.29): icmp_seq=3 ttl=60 time=13.7 ms

    --- ubuntu.com ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss, time 2003ms
    rtt min/avg/max/mdev = 13.693/13.703/13.715/0.009 ms
    ```

    Latency and timing values vary with network conditions. Three replies with 0% packet loss confirm name resolution and outbound connectivity.

## :material-book-open-page-variant-outline: Safety

!!! warning
    `/dev/vdb` and `/dev/vdc` are intentionally disposable lab disks. Later storage exercises partition, format, and overwrite them. Do not use them for personal data.
