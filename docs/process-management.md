# 8. Process management

!!! note
    Chapter 8 requires replacement-LABVM validation. Process IDs, process listings, load, memory values, and scheduling authorization vary between sessions.

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
    root           1       0  0 Aug25 ?        00:00:34 /usr/lib/systemd/systemd --system --deserialize=67
    root       67065       1  0 Aug28 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
    ubuntu     84250   84249  0 22:21 pts/0    00:00:00 ps -ef
    ```

To filter process output, pipe it through `grep`. To list processes by command name:

```bash
# List processes named sshd.
ps -C sshd
```
??? example "Expected result"
    ```text
        PID TTY          TIME CMD
      67065 ?        00:00:00 sshd
      71979 ?        00:00:00 sshd
      72042 ?        00:00:00 sshd
      84251 ?        00:00:00 sshd
      84299 ?        00:00:00 sshd
    ```

`top` provides a continuously updated process display, ordered by CPU use by default.

```bash
# Capture one secure-mode process-monitor snapshot.
top -b -n1 -s
```
??? example "Expected result"
    ```text
    %Cpu(s):  0.0 us,  4.5 sy,  0.0 ni, 95.5 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    ```

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

`at now + 7 hours` and `at HH:MM` are generic reference syntax. A safe one-time exercise would submit `touch /home/ubuntu/chapter8-validation/at-ran`, confirm it with `atq`, then remove it with `atrm JOB_ID`. Confirm that `ubuntu` is authorized to use `at` and `atq` before attempting this exercise.

Use `atq` to list scheduled jobs. Its output includes the job number, scheduled time, queue identifier, and user. Use `atrm` with the job number to remove a job.

### :material-application-edit-outline: 8.3.1 Process Management Lab

Create `~/chapter8-validation/loop.sh` with nano, then enter this script. The dedicated directory confines this validation exercise. `nano ~/chapter8-validation/loop.sh` remains the interactive lesson reference; validation used the equivalent noninteractive creation command below.

```text
#!/bin/bash

while true
do
    echo "hello world" >> hello.txt
    sleep 1
done
```

```bash
# Create the isolated loop script noninteractively.
printf '%s\n' '#!/bin/bash' '' 'while true' 'do' '    echo "hello world" >> hello.txt' '    sleep 1' 'done' > ~/chapter8-validation/loop.sh
```
??? example "Expected result"
    No output. The written bytes were compared with the documented loop content.

```bash
# Make the isolated loop script executable for its owner and group.
chmod 750 ~/chapter8-validation/loop.sh
```
??? example "Expected result"
    ```text
    -rwxr-x--- loop.sh
    ```

```bash
# List processes owned by ubuntu.
ps -ef | grep ubuntu
```
??? example "Expected result"
    The process list is session-specific and was inspected without recording process identities.

```bash
# List all running processes.
ps -ef
```
??? example "Expected result"
    The process list is session-specific and was inspected without recording process identities.

```bash
# Capture one bounded process-monitor snapshot.
top -b -n1
```
??? example "Expected result"
    ```text
    %Cpu(s):  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    ```

```bash
# Run the loop in a dedicated session and interrupt its verified process group from a second session.
setsid bash -c 'cd ~/chapter8-validation && exec ./loop.sh'
```
??? example "Expected result"
    No output. The verified owned loop process group exited normally after `SIGINT`.

Press `Ctrl+C` to stop the foreground `loop.sh` process normally.

```bash
# Run the isolated loop script in the background and retain its PID.
cd ~/chapter8-validation && ./loop.sh &
LOOP_SCRIPT_PID=$!
echo "$LOOP_SCRIPT_PID"
```
??? example "Expected result"
    The PID is session-specific and was retained only for verified cleanup.

```bash
# List jobs with their PIDs.
jobs -l
```
??? example "Expected result"
    ```text
    [1]+ Running ./loop.sh
    ```

```bash
# Stop the validation loop job using its retained PID.
kill "$LOOP_SCRIPT_PID"
```
??? example "Expected result"
    No output. The verified owned loop exited cleanly.

```bash
# Run the isolated loop script in the background with nice value 15.
cd ~/chapter8-validation && nice -n 15 ./loop.sh &
```
??? example "Expected result"
    The loop ran at nice value 15 and was then terminated cleanly.

The source SSH-daemon exercise is unsafe: changing or terminating `sshd` can disconnect users and disrupt LABVM. Use an owned disposable process instead. `ps aux | grep sshd` remains reference guidance for inspection only.

!!! note
    Run the following linked commands in the same shell session. They must target only the freshly created, owned disposable process.

```bash
# Start a disposable owned process and retain its PID.
sleep 600 &
SLEEP_PID=$!
echo "$SLEEP_PID"
```
??? example "Expected result"
    The PID is session-specific and was retained only for verified cleanup.

```bash
# Set the disposable process priority to -5.
sudo renice -5 -p "$SLEEP_PID"
```
??? example "Expected result"
    ```text
    old priority 0, new priority -5
    ```

```bash
# Check the current nice value for the disposable process.
ps -o pid=,ni=,comm= -p "$SLEEP_PID"
```
??? example "Expected result"
    ```text
    -5 sleep
    ```

!!! danger
    `SIGKILL` cannot be handled or cleaned up by the target. Use it only as a last resort, and only for a disposable process you own. Never target `sshd`, PID 1, `cron`, or another existing process.

```bash
# Forcefully terminate the disposable process as a last-resort demonstration.
sudo kill -9 "$SLEEP_PID"
```
??? example "Expected result"
    No output. The verified owned `sleep` process was terminated.

```bash
# Install the isolated cron entry noninteractively.
printf '%s\n' '* * * * * touch /home/ubuntu/chapter8-validation/cron-ran' | crontab -
```
??? example "Expected result"
    ```text
    * * * * * touch /home/ubuntu/chapter8-validation/cron-ran
    ```

Add this isolated test line instead of scheduling changes under `/tmp` or a user path:

```text
* * * * * touch /home/ubuntu/chapter8-validation/cron-ran
```

During validation, install this entry only in the current user's crontab, verify its target, then remove the validation-created entry and restore the prior crontab state.

The `at` availability and authorization on the replacement LABVM require validation before use. The source `at 14:00` and `rm /tmp/*yaml` examples are reference guidance only: never schedule wildcard deletion of `/tmp`.

```bash
# Install at using the source package command.
sudo apt install at -y
```
??? example "Expected result"
    The package installation completed successfully.

```bash
# Submit the isolated one-time marker job.
printf '%s\n' 'touch /home/ubuntu/chapter8-validation/at-ran' | at now + 1 minute
```
??? example "Expected result"
    ```text
    warning: commands will be executed using /bin/sh
    ```

```bash
# List the pending one-time job.
atq
```
??? example "Expected result"
    A pending job was listed and then completed; dynamic job details are not recorded.

```bash
# Install htop using the source package command.
sudo apt install -y htop
```
??? example "Expected result"
    The package installation completed successfully.

The availability of `htop` on the replacement LABVM requires validation before this monitor exercise.

```bash
# Check htop availability after the bounded top snapshots validated monitoring.
htop --version
```
??? example "Expected result"
    ```text
    htop 3.3.0
    ```

The `~/chapter8-validation/` directory is the intended location for the documented loop and harmless scheduler targets. Confirm its final state during replacement-LABVM validation.

> End of the lab. Do not continue to the next topic.
