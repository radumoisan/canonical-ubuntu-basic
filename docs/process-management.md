# 8. Process management

!!! note
    This page is structured from the source material. Commands are pending validation.

!!! abstract
    Define and manage processes, job control, priorities, and scheduled work with cron and at.

## :material-book-open-page-variant-outline: 8.1 Process Administration

Starting with init, everything a computer does is a process, sometimes called a job or unit. The init system tracks each process with a process ID (PID). Each running process has a numerical directory at `/proc/[PID]` that contains process information.

### :material-application-edit-outline: Listing processes

`ps` lists processes. Without options, it lists the current user's processes and shows the PID, terminal (TTY), CPU time, and command.

```bash
# List all processes with detailed information.
ps -ef
```
??? example "Expected result"
    A process list is displayed. Results vary by system.

To filter process output, pipe it through `grep`. To list processes by command name:

```bash
# List processes named sshd.
ps -C sshd
```
??? example "Expected result"
    ```text
    PID TTY TIME CMD
    958 ? 00:00:00 sshd
    ```
    The PIDs and number of entries vary.

`top` provides a continuously updated process display, ordered by CPU use by default.

```bash
# Open the process monitor.
top -s
```
??? example "Expected result"
    An interactive process display opens. Press `q` to exit.

### :material-application-edit-outline: Stopping processes

Use `Ctrl+C` to stop a foreground process. For a background process, identify its PID and send a signal with `kill`.

```bash
# Send a signal to a process by PID.
kill option PID
```
??? example "Expected result"
    The specified process receives the requested signal.

If no option is given, `kill` sends a termination signal for a clean shutdown. Common signals are `kill` or `kill -15` for `SIGTERM`, `kill -2` for `SIGINT`, and `kill -9` for `SIGKILL` as a last resort.

### :material-application-edit-outline: Daemons

Daemons are continuously running background processes that are not connected to a terminal. Many have names ending in `d`, such as `cron`, which runs scheduled processes, and `sshd`, which accepts remote shell connections.

## :material-book-open-page-variant-outline: 8.2 Background Processes and Priority

A command entered in a terminal runs in the foreground and controls that terminal session. Append `&` to run a job in the background.

```bash
# Start a program in the background.
programname &
```
??? example "Expected result"
    ```text
    [1] 18531
    ```
    The shell reports a job number and PID; values vary.

Use `jobs` to list the current user's jobs. `-l` includes PIDs, `-r` shows only running jobs, and `-s` shows only stopped jobs.

To move a foreground job to the background, press `Ctrl+Z` to suspend it, then run `bg`. Use `fg` to return the most recent background job to the foreground, or specify a job such as `fg %3`. End a background job with its PID or a job number such as `kill %2`.

### :material-application-edit-outline: Process priority

Processes start at priority 0. The range is `-20` (highest priority) through `19` (lowest priority). Use `nice` when starting a process with a non-default priority.

```bash
# Start a command at the lowest priority.
nice -n 19 commandname
```
??? example "Expected result"
    The command starts with nice value 19.

To change the priority of a running process, find its PID and use `renice`.

```bash
# Give a process with PID 19365 a higher priority.
renice -10 -p 19365
```
??? example "Expected result"
    The process priority is changed to -10 if permitted.

```bash
# Lower priority for a user's processes.
renice 15 -u greedyuser
```
??? example "Expected result"
    Processes owned by `greedyuser` are assigned nice value 15 if permitted.

```bash
# Raise priority for a group's processes.
renice -18 -g website
```
??? example "Expected result"
    Processes in the `website` group are assigned nice value -18 if permitted.

## :material-book-open-page-variant-outline: 8.3 Scheduling Processes

Use `cron` to run recurring work and `at` for one-time work. This is useful for work such as overnight backups or CPU-intensive calculations.

### :material-application-edit-outline: Scheduling recurring processes

`cron` is a daemon started by init. It reads configuration and runs listed jobs at scheduled times. Use `crontab -e` to edit a user's crontab; it checks syntax before saving, and crontab files should not be edited directly.

Each crontab line defines one job in this order:

```text
Minute
Hour
Day of the month
Month
Day of the week
Command to run
# m h dom mon dow command
1 2 6 * * * rm -rf /home/codemonkey/sandbox/*
```

The example removes the contents of the sandbox directory at 6:12 AM every day. For system jobs, an administrator can place scripts or executables in `/etc/cron.daily`, `/etc/cron.hourly`, `/etc/cron.monthly`, or `/etc/cron.weekly`; `/etc/crontab` runs those directories at the corresponding frequency.

### :material-application-edit-outline: Using at

Use `at` to schedule one-time work. You do not need to be logged in when it runs.

```bash
# Schedule a one-time job for a relative or specific time.
at now + 7 hours or at HH:MM
```
??? example "Expected result"
    An `at>` prompt opens. Input continues until `Ctrl+D` is pressed.

Use `atq` to list scheduled jobs. Its output includes the job number, scheduled time, queue identifier, and user. Use `atrm` with the job number to remove a job.

### :material-application-edit-outline: 8.3.1 Process Management Lab

Create `~/loop.sh` with nano, then enter this script:

```text
#!/bin/bash

while true
do
    echo "hello world" >> hello.txt
    sleep 1
done
```

```bash
# Create the loop script.
nano ~/loop.sh
```
??? example "Expected result"
    The nano editor opens for `~/loop.sh`.

```bash
# Make the loop script executable for its owner and group.
chmod 750 ~/loop.sh
```
??? example "Expected result"
    No output.

```bash
# List processes owned by ubuntu.
ps -ef | grep ubuntu
```
??? example "Expected result"
    Matching process entries are displayed; values vary.

```bash
# List all running processes.
ps -ef
```
??? example "Expected result"
    A detailed process list is displayed.

```bash
# Monitor processes continuously.
top
```
??? example "Expected result"
    An interactive process display opens. Press `q` to exit.

```bash
# Run the loop script in the foreground.
./loop.sh
```
??? example "Expected result"
    The script appends `hello world` to `hello.txt` once per second until interrupted.

Press `Ctrl+C` to stop the foreground `loop.sh` process.

```bash
# Run the loop script in the background.
./loop.sh &
```
??? example "Expected result"
    The shell reports a background job number and PID.

```bash
# List jobs with their PIDs.
jobs -l
```
??? example "Expected result"
    The background `loop.sh` job and its PID are displayed.

```bash
# Stop the loop job using its PID.
kill <PID>
```
??? example "Expected result"
    The process identified by the supplied PID terminates.

```bash
# Run the loop script in the background with nice value 15.
nice -n 15 ./loop.sh &
```
??? example "Expected result"
    The shell reports a background job; it runs at nice value 15.

```bash
# Find the SSH daemon PID.
ps aux | grep sshd
```
??? example "Expected result"
    An `sshd` process entry, including its PID, is displayed.

```bash
# Set the SSH daemon priority to -5.
sudo renice -5 -p <PID>
```
??? example "Expected result"
    The specified process is assigned nice value -5.

```bash
# Check the current nice value for the process.
ps -o ni <PID>
```
??? example "Expected result"
    The process nice value is displayed.

!!! danger
    The next command forcefully terminates the process identified by the PID. Confirm the PID before running it.

```bash
# Forcefully terminate the specified process.
sudo kill -9 <PID>
```
??? example "Expected result"
    The specified process is forcefully terminated.

```bash
# Edit the current user's crontab.
crontab -e
```
??? example "Expected result"
    The crontab editor opens.

Add this line to schedule creation of `/tmp/mytest.txt` every five minutes:

```text
*/5 * * * * touch /tmp/mytest.txt
```

```bash
# Install the at scheduler.
sudo apt install at -y
```
??? example "Expected result"
    The `at` package is installed or reported as already installed.

```bash
# Open an at prompt for 2:00 PM.
at 14:00
```
??? example "Expected result"
    An `at>` prompt opens.

At the prompt, enter `rm /tmp/*yaml`, then press `Ctrl+D` to submit the job.

```bash
# List scheduled at jobs.
atq
```
??? example "Expected result"
    The scheduled 2:00 PM job is listed.

```bash
# Install htop.
sudo apt install -y htop
```
??? example "Expected result"
    The `htop` package is installed or reported as already installed.

```bash
# Monitor processes with htop.
htop
```
??? example "Expected result"
    An interactive process display opens. Press `q` to exit.

> End of the lab. Do not continue to the next topic.
