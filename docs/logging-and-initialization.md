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
    Validation pending; no captured output is available.

```bash
# Search syslog for errors without case sensitivity
grep -i "error" /var/log/syslog
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List per-application logrotate rules
ls /etc/logrotate.d/
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Run log rotation using the main configuration
sudo logrotate /etc/logrotate.conf
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect the main logrotate configuration
cat /etc/logrotate.conf
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect logrotate history
cat /var/lib/logrotate/status
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Force verbose log rotation for troubleshooting
sudo logrotate -vf /etc/logrotate.conf
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Display kernel messages
dmesg
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Page through kernel messages
dmesg | less
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Find vda device messages
dmesg | grep -i vda
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Save vda messages to a file
dmesg | grep vda > vda.txt
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Search syslog for errors
grep error /var/log/syslog
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the first ten syslog lines
head -n 10 /var/log/syslog
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the last ten syslog lines
tail -n 10 /var/log/syslog
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List available log files
ls -l /var/log
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List boot files
ls -l /boot/
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Read the systemctl manual
man systemctl
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Stop the cron service
sudo systemctl stop cron
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect stopped cron service status
sudo systemctl status cron
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Start the cron service
sudo systemctl start cron
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Inspect running cron service status
sudo systemctl status cron
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List service units
systemctl list-units -t service
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show running SSH services
systemctl list-units -t service | grep -i ssh
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List failed units
systemctl --failed
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Read the journalctl manual
man journalctl
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Query the SSH journal
journalctl -u ssh.service
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show SSH service properties
systemctl show ssh.service
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Restart the SSH service
sudo systemctl restart ssh
```
??? example "Expected result"
    Validation pending; no captured output is available.
