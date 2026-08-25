# 8. Process management

!!! note
    The shown Chapter 8 results and `at` restrictions were captured on the prior `LABVM` and are historical only. The replacement `LABVM` requires revalidation; process IDs, process listings, load, and memory values vary between sessions.

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
    ```text
    UID          PID    PPID  C STIME TTY          TIME CMD
    root           1       0  0 06:55 ?        00:00:05 /sbin/init
    root       31305       1  0 08:17 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
    ubuntu     39534   39528  0 09:03 pts/5    00:00:00 ps -ef
    ```

    This is a literal excerpt; the full listing is host-state-dependent.

To filter process output, pipe it through `grep`. To list processes by command name:

```bash
# List processes named sshd.
ps -C sshd
```
??? example "Expected result"
    ```text
        PID TTY          TIME CMD
      31305 ?        00:00:00 sshd
      39527 ?        00:00:00 sshd
    ```

    This is a literal excerpt; connected SSH sessions change the result.

`top` provides a continuously updated process display, ordered by CPU use by default.

```bash
# Open the process monitor.
top -s
```
??? example "Expected result"
    ```text
    top - 09:05:21 up  2:09,  7 users,  load average: 0.01, 0.01, 0.02
    Tasks: 135 total,   1 running, 134 sleeping,   0 stopped,   0 zombie
    MiB Mem :   3916.0 total,   3157.8 free,    444.8 used,    550.9 buff/cache
        PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
          1 root      20   0   22592  13432   9464 S   0.0   0.3   0:05.51 systemd
    ```

    Captured in a PTY and exited normally with `q`; values vary by session.

### :material-application-edit-outline: Stopping processes

Use `Ctrl+C` to stop a foreground process. For a background process, identify its PID and send a signal with `kill`.

`kill [signal] PID` is generic reference syntax. Use it only with the PID of a disposable process you own; validate the target before sending a signal.

If no option is given, `kill` sends a termination signal for a clean shutdown. Common signals are `kill` or `kill -15` for `SIGTERM`, `kill -2` for `SIGINT`, and `kill -9` for `SIGKILL` as a last resort.

### :material-application-edit-outline: Daemons

Daemons are continuously running background processes that are not connected to a terminal. Many have names ending in `d`, such as `cron`, which runs scheduled processes, and `sshd`, which accepts remote shell connections.

## :material-book-open-page-variant-outline: 8.2 Background Processes and Priority

A command entered in a terminal runs in the foreground and controls that terminal session. Append `&` to run a job in the background.

`command &` is generic reference syntax. Use it only for a disposable command you own, then confirm its PID with `jobs -l` before stopping it.

Use `jobs` to list the current user's jobs. `-l` includes PIDs, `-r` shows only running jobs, and `-s` shows only stopped jobs.

To move a foreground job to the background, press `Ctrl+Z` to suspend it, then run `bg`. Use `fg` to return the most recent background job to the foreground, or specify a job such as `fg %3`. End a background job with its PID or a job number such as `kill %2`.

### :material-application-edit-outline: Process priority

Processes start at priority 0. The range is `-20` (highest priority) through `19` (lowest priority). Use `nice` when starting a process with a non-default priority.

`nice -n 19 command` is generic reference syntax. Do not change the priority of a system service or a process you do not own.

To change the priority of a running process, find its PID and use `renice`.

The `renice` examples use generic users, groups, and a sample PID, so they are reference guidance. Change priority only for a disposable process you own; never target `sshd`, PID 1, `cron`, or another existing process.

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
* * * * * touch /home/ubuntu/chapter8-validation/cron-ran
```

Use an isolated LABVM-owned target when learning cron. The source deletion example is reference guidance only and must not be scheduled. For system jobs, an administrator can place scripts or executables in `/etc/cron.daily`, `/etc/cron.hourly`, `/etc/cron.monthly`, or `/etc/cron.weekly`; `/etc/crontab` runs those directories at the corresponding frequency.

### :material-application-edit-outline: Using at

Use `at` to schedule one-time work. You do not need to be logged in when it runs.

`at now + 7 hours` and `at HH:MM` are generic reference syntax. A safe one-time exercise would submit `touch /home/ubuntu/chapter8-validation/at-ran`, confirm it with `atq`, then remove it with `atrm JOB_ID`. On LABVM, `ubuntu` is not permitted to use either `at` or `atq`, so no job was submitted.

Use `atq` to list scheduled jobs. Its output includes the job number, scheduled time, queue identifier, and user. Use `atrm` with the job number to remove a job.

### :material-application-edit-outline: 8.3.1 Process Management Lab

Create `~/chapter8-validation/loop.sh` with nano, then enter this script. The dedicated directory confines this validation exercise.

```text
#!/bin/bash

while true
do
    echo "hello world" >> hello.txt
    sleep 1
done
```

```bash
# Create the isolated loop script.
nano ~/chapter8-validation/loop.sh
```
??? example "Expected result"
    Nano opened and saved the script in a PTY, then exited normally. The validation script was created at `/home/ubuntu/chapter8-validation/loop.sh`.

```bash
# Make the isolated loop script executable for its owner and group.
chmod 750 ~/chapter8-validation/loop.sh
```
??? example "Expected result"
    ```text
    -rwxr-x--- 750 /home/ubuntu/chapter8-validation/loop.sh
    ```

```bash
# List processes owned by ubuntu.
ps -ef | grep ubuntu
```
??? example "Expected result"
    ```text
    ubuntu     39755   39698  0 09:06 ?        00:00:00 sshd: ubuntu@notty
    ubuntu     39756   39755  0 09:06 ?        00:00:00 bash -s
    ubuntu     39772   39756  0 09:06 ?        00:00:00 ps -ef
    ```

    Literal excerpt; PIDs and active sessions vary.

```bash
# List all running processes.
ps -ef
```
??? example "Expected result"
    ```text
    UID          PID    PPID  C STIME TTY          TIME CMD
    root           1       0  0 06:55 ?        00:00:05 /sbin/init
    root       31305       1  0 08:17 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
    ubuntu     39772   39756  0 09:06 ?        00:00:00 ps -ef
    ```

    Literal excerpt; the complete listing varies.

```bash
# Monitor processes continuously.
top
```
??? example "Expected result"
    ```text
    top - 09:11:49 up  2:16,  7 users,  load average: 0.00, 0.00, 0.00
    Tasks: 134 total,   1 running, 133 sleeping,   0 stopped,   0 zombie
    MiB Mem :   3916.0 total,   3170.6 free,    484.3 used,    498.2 buff/cache
    ```

    Captured in a PTY and exited normally with `q`; values vary.

```bash
# Run the isolated loop script in the foreground.
cd ~/chapter8-validation && ./loop.sh
```
??? example "Expected result"
    No output.

Press `Ctrl+C` to stop the foreground `loop.sh` process normally. Validation confirmed it exited and left no loop process running.

```bash
# Run the isolated loop script in the background.
cd ~/chapter8-validation && ./loop.sh &
```
??? example "Expected result"
    ```text
    [1] 39891
    ```

    The job number and PID vary.

```bash
# List jobs with their PIDs.
jobs -l
```
??? example "Expected result"
    ```text
    [1]+ 39891 Running                 ./loop.sh &
    ```

```bash
# Stop the validation loop job using the PID shown by jobs.
kill 39891
```
??? example "Expected result"
    No output. The validation-owned `loop.sh` process terminated with the default `SIGTERM`.

```bash
# Run the isolated loop script in the background with nice value 15.
cd ~/chapter8-validation && nice -n 15 ./loop.sh &
```
??? example "Expected result"
    ```text
      39814  15 loop.sh
    ```

    The validation-owned process had nice value `15` and was then terminated with `SIGTERM`; its PID varies.

The source SSH-daemon exercise is unsafe: changing or terminating `sshd` can disconnect users and disrupt LABVM. Use an owned disposable process instead. `ps aux | grep sshd` remains reference guidance for inspection only.

```bash
# Start a disposable owned process and retain its PID.
sleep 600 &
LOOP_PID=$!
echo "$LOOP_PID"
```
??? example "Expected result"
    ```text
    39974
    ```

    The PID varies. This process is owned by `ubuntu` and is the only process targeted in the following examples.

```bash
# Set the disposable process priority to -5.
sudo renice -5 -p 39974
```
??? example "Expected result"
    ```text
    39974 (process ID) old priority 0, new priority -5
    ```

    The PID varies.

```bash
# Check the current nice value for the disposable process.
ps -o pid=,ni=,comm= -p 39974
```
??? example "Expected result"
    ```text
      39974  -5 sleep
    ```

    The PID varies.

!!! danger
    `SIGKILL` cannot be handled or cleaned up by the target. Use it only as a last resort, and only for a disposable process you own. Never target `sshd`, PID 1, `cron`, or another existing process.

```bash
# Forcefully terminate the disposable process as a last-resort demonstration.
sudo kill -9 39974
```
??? example "Expected result"
    No output. The validation-owned disposable process no longer existed after the command. The PID varies.

```bash
# Edit the current user's crontab.
crontab -e
```
??? example "Expected result"
    ```text
      GNU nano 7.2               /tmp/crontab.bXkqM2/crontab
    # Edit this file to introduce tasks to be run by cron.
    #
    # Each task to run has to be defined through a single line
    ```

    Captured in a PTY and exited normally without saving.

Add this isolated test line instead of scheduling changes under `/tmp` or a user path:

```text
* * * * * touch /home/ubuntu/chapter8-validation/cron-ran
```

Validation installed this entry, captured it, confirmed the target file, and restored the prior crontab. The validation-created entry no longer exists.

The exact `sudo apt install at -y` source command was attempted but failed with `No space left on device`; it is not a successful validated command. Although `/usr/bin/at` is present, LABVM policy returns `You do not have permission to use at.` and `You do not have permission to use atq.` for `ubuntu`. The source `at 14:00` and `rm /tmp/*yaml` examples are therefore reference guidance only: never schedule wildcard deletion of `/tmp`.

The exact `sudo apt install -y htop` command was not retried after the disk-space failure. `/usr/bin/htop` was already available for the monitor exercise.

```bash
# Monitor processes with htop.
htop
```
??? example "Expected result"
    ```text
        0[                            0.0%] Tasks: 46, 25 thr, 87 kthr; 1 running
        1[|                           0.7%] Load average: 0.00 0.00 0.00
      Mem[||||||||              219M/3.82G] Uptime: 02:15:01
      Swp[                           0K/0K]
    ```

    Captured in a PTY and exited normally with `q`; values vary by session.

The retained `~/chapter8-validation/` directory contains the documented loop and harmless scheduler targets. No loop jobs, validation crontab entry, or `at` job remains.

> End of the lab. Do not continue to the next topic.
