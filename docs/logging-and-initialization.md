# 5. Logging and Initialization

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
    No output. The command returned exit status 1 because this LAB HOST has no matching `NetworkManager` entries.

```bash
# Search syslog for errors without case sensitivity
grep -i "error" /var/log/syslog
```
??? example "Expected result"
    ```text
    2026-08-25T06:14:48.439692+00:00 ubuntu apt.systemd.daily[6738]: OSError: [Errno 28] No space left on device
    ```

    This is a safe literal excerpt; log contents are host-state-dependent.

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

```bash
# Run log rotation using the main configuration
sudo logrotate /etc/logrotate.conf
```
??? example "Expected result"
    No output.

The main configuration is `/etc/logrotate.conf`. Its options and the example configuration in the source are reference material; configuration content is host-specific and is not presented as a command result.

```bash
# Inspect logrotate history
cat /var/lib/logrotate/status
```
??? example "Expected result"
    No standard output. This LAB HOST returned exit status 1 because the status file is absent.

```bash
# Force verbose log rotation for troubleshooting
sudo logrotate -vf /etc/logrotate.conf
```
??? example "Expected result"
    ```text
    reading config file /etc/logrotate.conf
    including /etc/logrotate.d
    Handling 13 logs
    ```

    Safe literal excerpt from the verbose run. Rotation completed successfully; per-log details are intentionally omitted because they may identify host activity.

```bash
# Display kernel messages
dmesg
```
??? example "Expected result"
    ```text
    dmesg: read kernel buffer failed: Operation not permitted
    ```

    This LAB HOST restricts unprivileged kernel-ring-buffer access.

```bash
# Page through kernel messages
dmesg | less
```
??? example "Expected result"
    The pager opened and exited with no displayed messages because `dmesg` is restricted for this user. Press `q` to exit an interactive pager.

```bash
# Find vda device messages
dmesg | grep -i vda
```
??? example "Expected result"
    No output. The command returned exit status 1 because unprivileged `dmesg` access is restricted.

```bash
# Save vda messages to a file
dmesg | grep vda > vda.txt
```
??? example "Expected result"
    No standard output. The command returned exit status 1 because unprivileged `dmesg` access is restricted; `vda.txt` was left in place as documented.

```bash
# Search syslog for errors
grep error /var/log/syslog
```
??? example "Expected result"
    No output. The newly rotated `syslog` had no lowercase `error` entries at validation time.

```bash
# Show the first ten syslog lines
head -n 10 /var/log/syslog
```
??? example "Expected result"
    No output. The newly rotated `syslog` was empty at validation time.

```bash
# Show the last ten syslog lines
tail -n 10 /var/log/syslog
```
??? example "Expected result"
    No output. The newly rotated `syslog` was empty at validation time.

```bash
# List available log files
ls -l /var/log
```
??? example "Expected result"
    The command completed successfully. Log names, ownership, sizes, and timestamps are host-state-dependent and are not reproduced here.

```bash
# List boot files
ls -l /boot/
```
??? example "Expected result"
    The command completed successfully. Kernel image and initrd filenames, sizes, and timestamps are host-state-dependent.

```bash
# Read the systemctl manual
man systemctl
```
??? example "Expected result"
    The installed `systemctl` manual opened successfully in its pager. Press `q` to exit.

```bash
# Stop the cron service
sudo systemctl stop cron
```
??? example "Expected result"
    No output. `cron` was active before this command and was restored after validation.

```bash
# Inspect stopped cron service status
sudo systemctl status cron
```
??? example "Expected result"
    The service was inactive after the documented stop command. `systemctl status` returned exit status 3 for the inactive service.

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
    active
    ```

```bash
# List service units
systemctl list-units -t service
```
??? example "Expected result"
    The command completed successfully; the service list is host-state-dependent.

```bash
# Show running SSH services
systemctl list-units -t service | grep -i ssh
```
??? example "Expected result"
    The command completed successfully and found the active SSH service.

```bash
# List failed units
systemctl --failed
```
??? example "Expected result"
    The command completed successfully. Failed-unit state is host-state-dependent.

```bash
# Read the journalctl manual
man journalctl
```
??? example "Expected result"
    The installed `journalctl` manual opened successfully in its pager. Press `q` to exit.

```bash
# Query the SSH journal
journalctl -u ssh.service
```
??? example "Expected result"
    The command completed successfully. Journal entries can contain host and session data, so no log content is reproduced.

```bash
# Show SSH service properties
systemctl show ssh.service
```
??? example "Expected result"
    The command completed successfully. Service properties are host-state-dependent.

```bash
# Restart the SSH service
sudo systemctl restart ssh
```
??? example "Expected result"
    No output. The restart completed successfully; a separate post-restart SSH connection confirmed the service remained active.
