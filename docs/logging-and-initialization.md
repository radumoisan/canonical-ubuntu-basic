# 5. Logging and Initialization

!!! note
    Structured from the source material. Command validation is pending.

!!! abstract
    Inspect system logs, understand boot initialization, and manage systemd units.

## :material-book-open-page-variant-outline: 5.1 System Logging

Logging records normal operation, state changes, diagnostics, kernel and network events, authentication, user actions, and exceptions. Logs are a first troubleshooting step and support security monitoring. Ubuntu commonly writes local logs under `/var/log/` through `rsyslogd`, including `/var/log/kern.log`, `/var/log/syslog`, and `/var/log/auth.log`. Systems can also send logs to a remote collector.

Search a log by source or severity:

```bash
# Search syslog for NetworkManager entries
grep NetworkManager /var/log/syslog
```
??? example "Expected result"
    Matching NetworkManager log entries are displayed; no output means no matches.

```bash
# Search syslog for errors without case sensitivity
grep -i "error" /var/log/syslog
```
??? example "Expected result"
    Matching error entries are displayed; no output means no matches.

`dmesg` displays the kernel ring buffer. `logrotate` archives, compresses, deletes, or otherwise processes old logs and creates replacement files. Its main configuration is `/etc/logrotate.conf`; `/etc/logrotate.d` contains per-application configuration.

```bash
# List per-application logrotate rules
ls /etc/logrotate.d/
```
??? example "Expected result"
    Source fixture: `apport apt aptitude dpkg landscape-client ppp rsyslog ufw unattended-upgrades upstart`

```bash
# Run log rotation using the main configuration
sudo logrotate /etc/logrotate.conf
```
??? example "Expected result"
    No output on success. Configured logs are rotated as applicable.

`logrotate` is activated on a schedule determined by the location of its script in cron directories such as `/etc/cron.daily` and `/etc/cron.hourly`. Cron runs scripts in these directories at the interval in the directory name. The `logrotate` command can also be run from the command line. When it runs, it performs the rotations defined by its included configuration files.

### :material-application-edit-outline: logrotate Configuration Options

Options in a logrotate configuration file determine the criteria for rotating logs. Inspect the main configuration file:

```bash
# Inspect the main logrotate configuration
cat /etc/logrotate.conf
```
??? example "Expected result"
    The source configuration example contains:

    ```text
    # see "man logrotate" for details
    # rotate log files weekly
    weekly
    # use the syslog group by default, since this is the owning group
    # of /var/log/syslog.
    su root syslog
    # keep 4 weeks worth of backlogs
    rotate 4
    # create new (empty) log files after rotating old ones create
    # uncomment this if you want your log files compressed
    #compress
    # packages drop log rotation information into this directory
    include /etc/logrotate.d
    ```

    Local configuration contents may vary.

Another common option is `size`, which determines the size a logfile must exceed before it is rotated. This helps prevent sudden, unexpected disk use when, for example, an error produces large volumes of log messages.

In supplementary configuration files, the first line is the logfile location and precedes a block of options that apply to it. These options are always contained within braces (`{}`). They can override defaults in `logrotate.conf` or add options that apply only to that file. Options in `logrotate.conf` that are not present in a supplementary configuration file still apply because the main file provides the defaults.

Multiple log files can be configured in one file within the `logrotate.d` directory. An example dpkg configuration may include the following options:

- `rotate 12`: Determines the number of logfiles to archive and keep. When that number is exceeded, the oldest archived log is deleted.
- `monthly`: Rotates logs after this interval. Other intervals include `daily` and `yearly`. A supplementary configuration loaded after the main configuration overrides its `weekly` setting with `monthly`.
- `missingok`: Continues without an error if no logfile is present.
- `notifempty`: Does not rotate an empty logfile.
- `compress`: Compresses archived logfiles, using gzip by default.
- `delaycompress`: Delays compression until the next rotation, leaving one rotated log uncompressed. This permits software to continue writing to the first rotated log for a time after rotation.
- `create <mode> <owner> <group>`: Specifies ownership and permissions for the replacement logfile created after rotation.

Supplementary configuration files commonly use a `postrotate` block, which ends with `endscript` and runs after rotation. It is usually used to restart the application so it begins using the newly rotated-in log:

```text
postrotate
  invoke-rc.d rsyslog reload >/dev/null 2>&1 || true
endscript
```

```bash
# Inspect logrotate history
cat /var/lib/logrotate/status
```
??? example "Expected result"
    `logrotate state -- version 2`
    `"/var/log/auth.log" 2016-6-19-6:46:8`
    Output varies with local rotation history.

```bash
# Force verbose log rotation for troubleshooting
sudo logrotate -vf /etc/logrotate.conf
```
??? example "Expected result"
    Verbose rotation actions are displayed. The `-f` option forces rotation even when it was recently performed.

### :material-application-edit-outline: 5.1.1 System Logging Lab

```bash
# Display kernel messages
dmesg
```
??? example "Expected result"
    Kernel boot and device messages are displayed.

```bash
# Page through kernel messages
dmesg | less
```
??? example "Expected result"
    Kernel messages open in `less`; press `q` to exit.

```bash
# Find vda device messages
dmesg | grep -i vda
```
??? example "Expected result"
    Matching disk-device messages are displayed; device details vary.

```bash
# Save vda messages to a file
dmesg | grep vda > vda.txt
```
??? example "Expected result"
    No output. Matching messages are written to `vda.txt`.

```bash
# Search syslog for errors
grep error /var/log/syslog
```
??? example "Expected result"
    Matching entries are displayed; errors in this exercise do not stop the lab.

```bash
# Show the first ten syslog lines
head -n 10 /var/log/syslog
```
??? example "Expected result"
    The first ten syslog entries are displayed.

```bash
# Show the last ten syslog lines
tail -n 10 /var/log/syslog
```
??? example "Expected result"
    The last ten syslog entries are displayed.

```bash
# List available log files
ls -l /var/log
```
??? example "Expected result"
    A detailed listing of system and application log files is displayed.

## :material-book-open-page-variant-outline: 5.2 Boot Process Overview

Boot activity starts with power-on, firmware (BIOS, EFI, or UEFI), and a boot loader. Ubuntu uses GRUB2. Before the kernel loads, `initrd` provides a temporary RAM filesystem for early hardware detection and driver loading. The kernel manages hardware and process resources. After it loads, the real root filesystem replaces `initrd`.

Ubuntu Server 24.04 uses systemd as init. Init is the first process started by the kernel and loads the foundational processes and tools required for user programs.

### :material-application-edit-outline: 5.2.1 Boot Process Lab

```bash
# List boot files
ls -l /boot/
```
??? example "Expected result"
    Source fixture includes `config-5.4.0-51-generic`, `initrd.img`, `vmlinuz`, and the `grub` directory. Kernel versions and timestamps vary.

## :material-book-open-page-variant-outline: 5.3 Systemd

Systemd is Ubuntu's default init system and manages processes loaded after the kernel. It calls managed processes units. A unit starts when another unit depends on it; boot begins with `default.target`. Unit definitions are stored in `/etc/systemd/system`, `/lib/systemd/system`, and their subdirectories. Scripts can use init-agnostic abstractions such as `invoke-rc.d`; users interact through systemd commands.

`systemctl start $unit`, `systemctl stop $unit`, and `systemctl restart $unit` control a unit. `systemctl status` displays service status.

!!! warning
    Stopping or restarting services changes the running system. Follow the lab sequence so `cron` is restarted after inspection.

### :material-application-edit-outline: 5.3.1 Systemd Lab

```bash
# Read the systemctl manual
man systemctl
```
??? example "Expected result"
    The `systemctl` manual opens in a pager.

```bash
# Stop the cron service
sudo systemctl stop cron
```
??? example "Expected result"
    No output on success.

```bash
# Inspect stopped cron service status
sudo systemctl status cron
```
??? example "Expected result"
    The source fixture shows `Active: inactive (dead)`.

```bash
# Start the cron service
sudo systemctl start cron
```
??? example "Expected result"
    No output on success.

```bash
# Inspect running cron service status
sudo systemctl status cron
```
??? example "Expected result"
    The source fixture shows `Active: active (running)`.

```bash
# List service units
systemctl list-units -t service
```
??? example "Expected result"
    Many service units are listed; local services vary.

```bash
# Show running SSH services
systemctl list-units -t service | grep -i ssh
```
??? example "Expected result"
    Matching SSH service units are displayed when present.

```bash
# List failed units
systemctl --failed
```
??? example "Expected result"
    Failed units are listed, or no failed units are reported.

```bash
# Read the journalctl manual
man journalctl
```
??? example "Expected result"
    The `journalctl` manual opens in a pager.

```bash
# Query the SSH journal
journalctl -u ssh.service
```
??? example "Expected result"
    Journal entries for `ssh.service` are displayed when available.

```bash
# Show SSH service properties
systemctl show ssh.service
```
??? example "Expected result"
    Properties for `ssh.service` are displayed.

```bash
# Restart the SSH service
sudo systemctl restart ssh
```
??? example "Expected result"
    No output on success.
