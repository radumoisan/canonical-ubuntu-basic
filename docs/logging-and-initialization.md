# 5. Logging and Initialization

!!! abstract
    Inspect system logs, understand boot initialization, and manage systemd units.

!!! note
    Command output varies between systems and over time. Log entries, timestamps, unit information, and directory listings depend on the current state of the system.

## :material-book-open-page-variant-outline: 5.1 System Logging

Logging records normal operation, state changes, diagnostics, kernel and network events, authentication, user actions, and exceptions. Logs are a first troubleshooting step and support security monitoring. Ubuntu commonly writes local logs under `/var/log/` through `rsyslogd`, including `/var/log/kern.log`, `/var/log/syslog`, and `/var/log/auth.log`. Systems can also send logs to a remote collector.

Search a log by source or severity:

```bash
# Search syslog for NetworkManager entries
grep NetworkManager /var/log/syslog
```
??? example "Expected result"
    No output. The command returned exit status 1 because no matching `NetworkManager` entry was present.

```bash
# Search syslog for errors without case sensitivity
grep -i "error" /var/log/syslog
```
??? example "Expected result"
    ```text
    2025-02-19T11:09:18.576725+00:00 ubuntu systemd[1]: apport-autoreport.path - Process error reports when automatic reporting is enabled (file watch) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
    2025-02-19T11:09:18.576736+00:00 ubuntu systemd[1]: apport-autoreport.timer - Process error reports when automatic reporting is enabled (timer based) was skipped because of an unmet condition check (ConditionPathExists=/var/lib/apport/autoreport).
    2025-02-19T11:09:18.578250+00:00 ubuntu kernel: RAS: Correctable Errors collector initialized.
    2025-02-19T11:09:18.939687+00:00 ubuntu snapd[635]: helpers.go:160: error trying to compare the snap system key: system-key missing on disk
    ```

    Contiguous excerpt from the leading matches; matched entries and counts vary with system activity and time.

```bash
# List per-application logrotate rules
ls /etc/logrotate.d/
```
??? example "Expected result"
    ```text
    alternatives
    apport
    apt
    bootlog
    btmp
    cloud-init
    dpkg
    rsyslog
    ubuntu-pro-client
    ufw
    unattended-upgrades
    wtmp
    ```

    The set of rules varies with installed packages.

```bash
# Run log rotation using the main configuration
sudo logrotate /etc/logrotate.conf
```
??? example "Expected result"
    No output.

The main configuration is `/etc/logrotate.conf`. Its options and the example configuration in the source are reference material; configuration content is host-specific and is not presented as a command result.

```bash
# Inspect logrotate history with required privilege
sudo cat /var/lib/logrotate/status
```
??? example "Expected result"
    ```text
    logrotate state -- version 2
    "/var/log/syslog" 2026-8-31-15:0:0
    "/var/log/dpkg.log" 2026-9-1-0:0:26
    "/var/log/unattended-upgrades/unattended-upgrades.log" 2026-9-1-0:0:26
    "/var/log/unattended-upgrades/unattended-upgrades-shutdown.log" 2026-8-31-15:0:0
    "/var/log/auth.log" 2026-8-31-15:0:0
    "/var/log/cloud-init.log" 2026-8-31-15:0:0
    "/var/log/apt/term.log" 2026-9-1-0:0:26
    ```

    Contiguous excerpt from the state file; tracked logs and timestamps vary with rotation history.

```bash
# Force verbose log rotation for troubleshooting
sudo logrotate -vf /etc/logrotate.conf
```
??? example "Expected result"
    ```text
    reading config file /etc/logrotate.conf
    including /etc/logrotate.d
    reading config file alternatives
    reading config file apport
    reading config file apt
    reading config file bootlog
    reading config file btmp
    reading config file cloud-init
    reading config file dpkg
    reading config file rsyslog
    reading config file ubuntu-pro-client
    reading config file ufw
    reading config file unattended-upgrades
    reading config file wtmp
    ```

    Contiguous excerpt from the leading lines of a much longer verbose listing; which logs rotate and the per-log detail lines vary with configuration and log state.

### :material-application-edit-outline: 5.1.1 System Logging Lab

```bash
# Display kernel messages with required privilege
sudo dmesg
```
??? example "Expected result"
    ```text
    [    0.000000] Linux version 6.8.0-53-generic (buildd@lcy02-amd64-046) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #55-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 17 15:37:52 UTC 2025 (Ubuntu 6.8.0-53.55-generic 6.8.12)
    [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.8.0-53-generic root=LABEL=cloudimg-rootfs ro console=tty1 console=ttyS0
    [    0.000000] KERNEL supported cpus:
    [    0.000000]   Intel GenuineIntel
    [    0.000000]   AMD AuthenticAMD
    [    0.000000]   Hygon HygonGenuine
    [    0.000000]   Centaur CentaurHauls
    [    0.000000]   zhaoxin   Shanghai
    ```

    Contiguous excerpt from the leading lines; the full kernel ring buffer contains many boot and runtime messages that vary with kernel, hardware, and uptime.

```bash
# Page through kernel messages with required privilege
sudo dmesg | less
```
??? example "Expected result"
    ```text
    [    0.000000] KERNEL supported cpus:
    [    0.000000]   Intel GenuineIntel
    [    0.000000]   AMD AuthenticAMD
    [    0.000000]   Hygon HygonGenuine
    [    0.000000]   Centaur CentaurHauls
    [    0.000000]   zhaoxin   Shanghai
    ```

    First-screen pager excerpt; the header line and text wrapping vary with terminal width. Press `q` to exit.

```bash
# Find vda device messages with required privilege
sudo dmesg | grep -i vda
```
??? example "Expected result"
    ```text
    [    1.688305] virtio_blk virtio1: [vda] 17825792 512-byte logical blocks (9.13 GB/8.50 GiB)
    [    1.710060]  vda: vda1 vda14 vda15 vda16
    [    4.127767] EXT4-fs (vda1): mounted filesystem 2f225ac0-574c-4638-b2a0-8af6dc507d6e ro with ordered data mode. Quota mode: none.
    [    5.319913] EXT4-fs (vda1): re-mounted 2f225ac0-574c-4638-b2a0-8af6dc507d6e r/w. Quota mode: none.
    [    6.031748] EXT4-fs (vda16): mounted filesystem 9839930e-5122-4a59-995e-9375c70604a2 r/w with ordered data mode. Quota mode: none.
    [   10.924164] EXT4-fs (vda1): resizing filesystem from 655099 to 1965819 blocks
    [   10.982881] EXT4-fs (vda1): resized filesystem to 1965819
    ```

    Kernel `vda` device messages; the exact entries vary with the boot and device history.

```bash
# Save vda messages to a file with required privilege
sudo dmesg | grep vda > vda.txt
```
??? example "Expected result"
    No output. The command writes the matching `vda` lines to `vda.txt` in the current working directory.

```bash
# Search syslog for errors
grep error /var/log/syslog
```
??? example "Expected result"
    No output. The command returned exit status 1 because no lowercase `error` entry was present.

```bash
# Show the first ten syslog lines
head -n 10 /var/log/syslog
```
??? example "Expected result"
    ```text
    2026-09-01T09:06:56.530553+00:00 ubuntu rsyslogd: [origin software="rsyslogd" swVersion="8.2312.0" x-pid="49294" x-info="https://www.rsyslog.com"] rsyslogd was HUPed
    2026-09-01T09:06:56.542611+00:00 ubuntu systemd[1]: session-228.scope: Deactivated successfully.
    2026-09-01T09:07:06.688168+00:00 ubuntu systemd[1]: Stopping user@1000.service - User Manager for UID 1000...
    2026-09-01T09:07:06.689908+00:00 ubuntu systemd[53335]: Activating special unit exit.target...
    2026-09-01T09:07:06.690870+00:00 ubuntu systemd[53335]: Stopped target default.target - Main User Target.
    2026-09-01T09:07:06.691581+00:00 ubuntu systemd[53335]: Stopped target basic.target - Basic System.
    2026-09-01T09:07:06.691671+00:00 ubuntu systemd[53335]: Stopped target paths.target - Paths.
    2026-09-01T09:07:06.691796+00:00 ubuntu systemd[53335]: Stopped target sockets.target - Sockets.
    2026-09-01T09:07:06.691866+00:00 ubuntu systemd[53335]: Stopped target timers.target - Timers.
    2026-09-01T09:07:06.691938+00:00 ubuntu systemd[53335]: Stopped launchpadlib-cache-clean.timer - Clean up old files in the Launchpadlib cache.
    ```

    The first ten lines; content and timestamps vary with the current log and rotation state.

```bash
# Show the last ten syslog lines
tail -n 10 /var/log/syslog
```
??? example "Expected result"
    ```text
    2026-09-01T09:09:26.885127+00:00 ubuntu systemd[53876]: Reached target sockets.target - Sockets.
    2026-09-01T09:09:26.885280+00:00 ubuntu systemd[53876]: Reached target basic.target - Basic System.
    2026-09-01T09:09:26.885474+00:00 ubuntu systemd[53876]: Reached target default.target - Main User Target.
    2026-09-01T09:09:26.885549+00:00 ubuntu systemd[53876]: Startup finished in 156ms.
    2026-09-01T09:09:26.885633+00:00 ubuntu systemd[1]: Started user@1000.service - User Manager for UID 1000.
    2026-09-01T09:09:26.896301+00:00 ubuntu systemd[1]: Started session-241.scope - Session 241 of User ubuntu.
    2026-09-01T09:09:27.364608+00:00 ubuntu systemd[1]: session-241.scope: Deactivated successfully.
    2026-09-01T09:09:28.254149+00:00 ubuntu systemd[1]: Started session-243.scope - Session 243 of User ubuntu.
    2026-09-01T09:09:28.369081+00:00 ubuntu systemd[1]: session-243.scope: Deactivated successfully.
    2026-09-01T09:09:29.212930+00:00 ubuntu systemd[1]: Started session-244.scope - Session 244 of User ubuntu.
    ```

    The ten newest lines; the newest entries vary continuously with system and session activity.

```bash
# List available log files
ls -l /var/log
```
??? example "Expected result"
    ```text
    total 3288
    lrwxrwxrwx  1 root      root                 39 Feb 14  2025 README -> ../../usr/share/doc/systemd/README.logs
    -rw-r--r--  1 root      root                  0 Sep  1 09:06 alternatives.log
    -rw-r--r--  1 root      root              10164 Sep  1 07:03 alternatives.log.1
    -rw-r--r--  1 root      root                161 Feb 14  2025 alternatives.log.2.gz
    -rw-r-----  1 root      adm                   0 Feb 19  2025 apport.log
    drwxr-xr-x  2 root      root               4096 Sep  1 09:06 apt
    -rw-r-----  1 syslog    adm               12686 Sep  1 09:09 auth.log
    -rw-r-----  1 syslog    adm              177031 Sep  1 09:06 auth.log.1
    -rw-rw----  1 root      utmp                  0 Sep  1 09:06 btmp
    -rw-rw----  1 root      utmp                  0 Sep  1 00:00 btmp.1
    -rw-r-----  1 root      adm               12853 Feb 19  2025 cloud-init-output.log.1
    -rw-r-----  1 syslog    adm              304696 Feb 19  2025 cloud-init.log.1
    drwxr-xr-x  2 root      root               4096 Jan 31  2025 dist-upgrade
    -rw-r-----  1 root      adm               58742 Sep  1 06:58 dmesg
    -rw-r-----  1 root      adm               47633 Aug 31 15:07 dmesg.0
    -rw-r-----  1 root      adm               14151 Feb 19  2025 dmesg.1.gz
    -rw-r-----  1 root      adm               14324 Feb 19  2025 dmesg.2.gz
    -rw-r-----  1 root      adm               15130 Feb 19  2025 dmesg.3.gz
    -rw-r-----  1 root      adm               15092 Feb 19  2025 dmesg.4.gz
    -rw-r--r--  1 root      root                  0 Sep  1 09:06 dpkg.log
    -rw-r--r--  1 root      root             187658 Sep  1 07:03 dpkg.log.1
    -rw-r--r--  1 root      root                406 Feb 14  2025 dpkg.log.2.gz
    drwxr-sr-x+ 3 root      systemd-journal    4096 Feb 19  2025 journal
    -rw-r-----  1 syslog    adm                   0 Sep  1 09:06 kern.log
    -rw-r-----  1 syslog    adm              578952 Sep  1 07:03 kern.log.1
    drwxr-xr-x  2 landscape landscape          4096 Feb 19  2025 landscape
    -rw-rw-r--  1 root      utmp             292292 Sep  1 09:08 lastlog
    drwx------  2 root      root               4096 Feb 19  2025 private
    -rw-r-----  1 syslog    adm               46848 Sep  1 09:09 syslog
    -rw-r-----  1 syslog    adm             1702719 Sep  1 09:06 syslog.1
    drwxr-xr-x  2 root      root               4096 Sep  1 00:07 sysstat
    drwxr-x---  2 root      adm                4096 Sep  1 09:06 unattended-upgrades
    -rw-rw-r--  1 root      utmp               2304 Sep  1 09:08 wtmp
    -rw-rw-r--  1 root      utmp              60672 Sep  1 07:15 wtmp.1
    ```

    File names, sizes, and dates vary with installed packages, system activity, and rotation history.

## :material-book-open-page-variant-outline: 5.2 Boot Process Overview

Firmware starts first, then GRUB transfers control to the operating system. The initrd prepares required hardware and drivers before the real root filesystem is available. The kernel manages system resources, and Ubuntu Server 24.04 uses systemd as its init system.

![Boot process](assets/boot.png)

### :material-application-edit-outline: 5.2.1 Boot Process Lab

```bash
# List boot files
ls -l /boot/
```
??? example "Expected result"
    ```text
    total 108321
    -rw------- 1 root root  9135252 Jul 31 20:56 System.map-6.8.0-138-generic
    -rw------- 1 root root  9080742 Jan 17  2025 System.map-6.8.0-53-generic
    -rw-r--r-- 1 root root   287560 Jul 31 20:56 config-6.8.0-138-generic
    -rw-r--r-- 1 root root   287562 Jan 17  2025 config-6.8.0-53-generic
    drwx------ 3 root root      512 Jan  1  1970 efi
    drwxr-xr-x 6 root root     4096 Sep  1 06:58 grub
    lrwxrwxrwx 1 root root       28 Sep  1 06:58 initrd.img -> initrd.img-6.8.0-138-generic
    -rw-r--r-- 1 root root 31058293 Sep  1 07:00 initrd.img-6.8.0-138-generic
    -rw-r--r-- 1 root root 30994992 Sep  1 06:56 initrd.img-6.8.0-53-generic
    lrwxrwxrwx 1 root root       27 Feb 14  2025 initrd.img.old -> initrd.img-6.8.0-53-generic
    drwx------ 2 root root    16384 Feb 14  2025 lost+found
    lrwxrwxrwx 1 root root       25 Sep  1 06:58 vmlinuz -> vmlinuz-6.8.0-138-generic
    -rw------- 1 root root 15055240 Jul 31 20:56 vmlinuz-6.8.0-138-generic
    -rw------- 1 root root 14981512 Jan 17  2025 vmlinuz-6.8.0-53-generic
    lrwxrwxrwx 1 root root       24 Feb 14  2025 vmlinuz.old -> vmlinuz-6.8.0-53-generic
    ```

    Kernel and initrd versions vary with the installed and running kernel.

## :material-book-open-page-variant-outline: 5.3 Systemd

systemd is the default init system. It manages units and their dependencies. Unit definitions reside in `/etc/systemd/system` or `/lib/systemd/system`.

### :material-application-edit-outline: 5.3.1 Systemd Lab

```bash
# Read the systemctl manual
man systemctl
```
??? example "Expected result"
    ```text
    SYSTEMCTL(1)                       systemctl                      SYSTEMCTL(1)
    NAME
           systemctl - Control the systemd system and service manager
    SYNOPSIS
           systemctl [OPTIONS...] COMMAND [UNIT...]
    DESCRIPTION
           systemctl may be used to introspect and control the state of the
           "systemd" system and service manager. Please refer to systemd(1) for an
           introduction into the basic concepts and functionality this tool
           manages.
    ```

    First-screen pager excerpt; the header line and text wrapping vary with terminal width. Press `q` to exit.

```bash
# Stop the cron service
sudo systemctl stop cron
```
??? example "Expected result"
    No output.

```bash
# Inspect stopped cron service status
sudo systemctl status cron
```
??? example "Expected result"
    ```text
    ○ cron.service - Regular background program processing daemon
         Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
         Active: inactive (dead) since Tue 2026-09-01 09:10:18 UTC; 28s ago
       Duration: 2h 10min 33.214s
           Docs: man:cron(8)
        Process: 22663 ExecStart=/usr/sbin/cron -f -P $EXTRA_OPTS (code=killed, signal=TERM)
       Main PID: 22663 (code=killed, signal=TERM)
            CPU: 143ms
    ```

    Contiguous excerpt from the leading status lines; the unit reports `inactive (dead)`, trailing recent-journal lines follow, and `systemctl status` returns a non-zero exit status for inactive units. Timestamps and the journal tail vary.

```bash
# Start the cron service
sudo systemctl start cron
```
??? example "Expected result"
    No output.

```bash
# Inspect running cron service status
sudo systemctl status cron
```
??? example "Expected result"
    ```text
    ● cron.service - Regular background program processing daemon
         Loaded: loaded (/usr/lib/systemd/system/cron.service; enabled; preset: enabled)
         Active: active (running) since Tue 2026-09-01 09:11:05 UTC; 1s ago
           Docs: man:cron(8)
       Main PID: 54602 (cron)
          Tasks: 1 (limit: 4656)
         Memory: 352.0K (peak: 596.0K)
            CPU: 3ms
         CGroup: /system.slice/cron.service
                 └─54602 /usr/sbin/cron -f -P

    Sep 01 09:11:05 ubuntu systemd[1]: Started cron.service - Regular background program processing daemon.
    ```

    Contiguous excerpt; the running timestamps, PID, resource counters, and trailing journal lines vary.

```bash
# List service units
systemctl list-units -t service
```
??? example "Expected result"
    ```text
      UNIT                                           LOAD   ACTIVE SUB     DESCRIPTION
      apparmor.service                               loaded active exited  Load AppArmor profiles
      apport.service                                 loaded active exited  automatic crash report generation
      blk-availability.service                       loaded active exited  Availability of block devices
      console-setup.service                          loaded active exited  Set console font and keymap
      cron.service                                   loaded active running Regular background program processing daemon
      dbus.service                                   loaded active running D-Bus System Message Bus
      finalrd.service                                loaded active exited  Create final runtime dir for shutdown pivot root
    ```

    Contiguous excerpt from the leading lines of the table; the listed units and states vary with the running system. The output closes with the line `51 loaded units listed. Pass --all to see loaded but inactive units, too.` followed by a hint to use `systemctl list-unit-files`.

```bash
# Show running SSH services
systemctl list-units -t service | grep -i ssh
```
??? example "Expected result"
    ```text
      ssh.service                                    loaded active running OpenBSD Secure Shell server
    ```

```bash
# List failed units
systemctl --failed
```
??? example "Expected result"
    ```text
      UNIT LOAD ACTIVE SUB DESCRIPTION

    0 loaded units listed.
    ```

    No failed units at the time of inspection; the header row and count vary if units fail.

```bash
# Read the journalctl manual
man journalctl
```
??? example "Expected result"
    ```text
    JOURNALCTL(1)                     journalctl                     JOURNALCTL(1)
    NAME
           journalctl - Print log entries from the systemd journal
    SYNOPSIS
           journalctl [OPTIONS...] [MATCHES...]
    DESCRIPTION
           journalctl is used to print the log entries stored in the journal by
           systemd-journald.service(8) and systemd-journal-remote.service(8).
           If called without parameters, it will show the contents of the journal
           accessible to the calling user, starting with the oldest entry
           collected.
    ```

    First-screen pager excerpt; the header line and text wrapping vary with terminal width. Press `q` to exit.

```bash
# Query the SSH journal
journalctl -u ssh.service
```
??? example "Expected result"
    ```text
    Aug 31 15:07:39 ubuntu systemd[1]: Starting ssh.service - OpenBSD Secure Shell server...
    Aug 31 15:07:39 ubuntu sshd[842]: Server listening on :: port 22.
    Aug 31 15:07:39 ubuntu systemd[1]: Started ssh.service - OpenBSD Secure Shell server.
    ```

    Contiguous excerpt from the leading entries; the journal continues with the unit's service lifecycle and per-session records, so the full listing varies with connection activity and journal retention.

```bash
# Show SSH service properties
systemctl show ssh.service
```
??? example "Expected result"
    ```text
    Type=notify
    ExitType=main
    Restart=on-failure
    RestartMode=normal
    NotifyAccess=main
    RestartUSec=100ms
    RestartSteps=0
    RestartMaxDelayUSec=infinity
    RestartUSecNext=100ms
    TimeoutStartUSec=1min 30s
    TimeoutStopUSec=1min 30s
    TimeoutAbortUSec=1min 30s
    ```

    Contiguous excerpt from the leading properties; the command prints hundreds of unit properties whose names and values vary with the unit definition and runtime state.

```bash
# Restart the SSH service
sudo systemctl restart ssh
```
??? example "Expected result"
    No output. The service restarts and remains available; reconnecting with SSH succeeds afterward.
