# Internal Access and Validation Runbook

This is internal operator content, not student-facing training material. It is the procedure authority. `playground.md` contains current assignment data only; `migration.md` and `commands.md` contain historical evidence only.

# Labels

`LABHOST` is the conceptual label for the assigned outer public host. `LABVM` is the conceptual label for the nested VM. Neither is a DNS hostname or SSH alias. Never run `ssh LABHOST` or `ssh LABVM`.

# Authority and Resolution

- Resolve the outer target from the current synchronized `playground.md` public-target field; do not reproduce it here.
- The SSH username is always `ubuntu`; never derive it from student data.
- The outer hop uses the operator's configured default SSH key or agent. Do not use an assignment password or guess SSH key paths.
- Resolve the nested private target from the executable nested SSH command in authoritative `ubuntu_basic_lab.md`. This is a documented topology value, not assignment-derived.
- Resolve the nested password from the comment directly associated with that executable source command. Do not write its value. The source prose has a known conflicting password statement; the executable-command comment is the validated execution authority. Stop and escalate if it changes or no longer works.

# Manual Connection Path

Resolve the variables from the authority section before connecting.

```sh
# Connect from the local operator machine to the assigned outer host.
ssh ubuntu@"$LABHOST_PUBLIC_IP"
```

```sh
# Connect from the outer host to the nested VM.
ssh ubuntu@"$LABVM_PRIVATE_IP"
```

Commands after the second hop execute on `LABVM`.

# Noninteractive Nested Validation

This is internal automation guidance, not a learner command. The approved runner must inject `LABVM_PASSWORD` into the current process environment. Execute the following from `LABHOST` after confirming `sshpass` is available:

```sh
# Confirm that sshpass is available on the outer host.
command -v sshpass
```

```sh
# Run an approved remote validation command on the nested VM.
SSHPASS="$LABVM_PASSWORD" sshpass -e ssh ubuntu@"$LABVM_PRIVATE_IP" '<remote-command>'
```

Do not use `sshpass -p`, echo or print secrets, write password files, or include secrets in command output. If `sshpass` is unavailable, stop and report a blocker; do not install it unless separately authorized.

# Package-Command Preflight

Chapter commands run only on `LABVM`. Before any command that needs `sudo`, run:

```sh
# Confirm that sudo can run noninteractively on the nested VM.
sudo -n true
```

Stop if it fails. Connection authentication is not a student-facing interactive lab command.

# Operation Recording

Before every remote action, state the simple command that will run. Afterwards, report the exact command and result with active targets and credentials redacted. Do not store active connection data in documentation or `commands.md`. Record only successful source-training commands in `commands.md`, and update `migration.md` after material validation changes.

# Failure Handling

Do not guess an alternate user, target, password, or key. Distinguish and report the blocker as an outer key failure, nested password failure, `sudo` failure, or command/package failure, then stop.
