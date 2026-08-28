# Ubuntu Basic Migration Tracker

## :material-book-open-page-variant-outline: Current State

- Current phase: Chapter 5 replacement nested-VM validation is Blocked because `journalctl -u ssh.service` has no publishable safe literal result; Chapters 6 through 8 require revalidation.
- Active target: Chapter 5 safe SSH-journal result resolution.
- Next action: Establish an authorized student-facing form or safe literal result for the SSH journal query, then complete Chapter 5 result documentation.
- The prior `LABHOST` was destroyed. Its captured results are historical only and must not be used as replacement-environment validation evidence; no MkDocs build has been run.

## :material-book-open-page-variant-outline: Status Legend

- Not started
- Structured
- Formatting
- Ready for validation
- Validating
- Blocked
- Complete

## :material-book-open-page-variant-outline: Page Status

| Page | Status |
| --- | --- |
| Home | Complete |
| Prerequisites | Complete (validated two-layer student environment/readiness checks; not chapter validation) |
| Networking Appendix | Complete |
| 1. What is Ubuntu | Complete (replacement environment) |
| 2. CLI Environment | Complete (replacement environment) |
| 3. Linux Filesystem Hierarchy | Complete (replacement environment) |
| 4. Identity and Ownership | Complete (replacement environment) |
| 5. Logging and Initialization | Blocked (replacement environment) |
| 6. Storage | Ready for validation (replacement environment) |
| 7. Networking | Ready for validation (replacement environment) |
| 8. Process Management | Ready for validation (replacement environment) |
| 9. Backup and Recovery | Structured |
| 10. Software Management | Structured |

## :material-book-open-page-variant-outline: Chapter Subsections

| Chapter | Source subsections | Status |
| --- | --- | --- |
| 1. What is Ubuntu | 1.1 What is Linux?; 1.2 What is the Kernel?; 1.3 What is Ubuntu?; 1.4 The Release Cycle; 1.5 Ubuntu Lab | Complete (all source commands validated on replacement environment) |
| 2. CLI Environment | 2.1 Secure Shell; 2.2 CLI Commands; 2.2.1 CLI Commands Lab; 2.3 Getting Help; 2.3.1 Getting Help Lab; 2.4 Shell Environment Variables; 2.4.1 Shell Environment and Variables Lab; 2.5 Standard Streams; 2.5.1 Redirection Lab; 2.6 Command Chaining; 2.7 Return Values and Expansion; 2.7.1 Chaining and Expansion Lab; 2.8 Introduction to nano; 2.8.1 nano Lab | Complete (replacement environment) |
| 3. Linux Filesystem Hierarchy | 3.1 The Filesystem Hierarchy Standard; 3.2 Required Root Filesystem Directories; 3.2.1 Directory Structure Lab; 3.3 Linux File Types; 3.3.1 File Types Lab | Complete (all source commands validated on replacement environment) |
| 4. Identity and Ownership | 4.1 User Management; 4.2 Privilege Delegation; 4.2.1 User Management & Privileges Lab; 4.3 Permissions; 4.3.1 Permissions Lab | Complete (all source commands validated on replacement environment) |
| 5. Logging and Initialization | 5.1 System Logging; 5.1.1 System Logging Lab; 5.2 Boot Process Overview; 5.2.1 Boot Process Lab; 5.3 Systemd; 5.3.1 Systemd Lab | Blocked (replacement environment; prior results superseded) |
| 6. Storage | 6.1 Partitioning; 6.1.1 Partitioning Lab; 6.2 File Systems; 6.2.1 Filesystems Lab; 6.3 LVM; 6.3.1 LVM Lab | Ready for validation (replacement environment; prior results superseded) |
| 7. Networking | 7.1 Basic network commands; 7.1.1 ip Lab; 7.2 ethtool Command; 7.2.1 ethtool lab; 7.3 Network Troubleshooting Commands; 7.3.1 Networking Lab | Ready for validation (replacement environment; prior results superseded) |
| 8. Process Management | 8.1 Process Administration; 8.2 Background Processes and priority; 8.3 Scheduling Processes; 8.3.1 Process Management Lab | Ready for validation (replacement environment; prior results superseded; `at` status is unvalidated) |
| 9. Backup and Recovery | 9.1 Using Archiving and Compression Utilities; 9.2 Tar archiving; 9.3 Using rsync; 9.4 Backup and Recovery Lab | Structured |
| 10. Software Management | 10.1 Debian Package Management; 10.2 Advanced Package Tool (Apt); 10.3 Snappy Package Management; 10.3.1 Software Management Lab | Structured |

## :material-book-open-page-variant-outline: Open Findings

- 2026-08-24: The prior environment's system-libvirt `cloud` network and `ubuntu` domain were active and autostarted. This history is superseded and is not replacement-environment evidence.
- 2026-08-24: GCP disk tier cannot be verified from the available local evidence.
- 2026-08-24: Package and service variance is confirmed: `qemu-kvm` and `virtqemud.service` are absent while functional QEMU/KVM packages and active monolithic `libvirtd` are present.
- 2026-08-24: Structural migration had introduced unvalidated descriptive or assumed expected-result bodies. They were reset to the standardized pre-validation notice, including source-provided fixtures.
- Deployment artifacts are retained; chart versioning and image tags remain CI-managed.
- 2026-08-24: The derived Chapter 1 page corrects Ubuntu 23.10's release date from October 2024 to October 2023.
- 2026-08-24: The source `umask` default file-permissions semantics require command or factual validation before correction. They remain uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `umask 000 filename` command syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `visudo /etc/sudoers` syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The Networking appendix IPv4-only IP-address definition requires factual validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-25: Prior Chapter 3 validation confirmed Ubuntu's merged `/usr` root symlinks and an empty `/usr/games`; this evidence was superseded by replacement-environment validation. Directory, device, package, kernel, and home-directory listings are host-state-dependent.
- 2026-08-25: Chapter 4 validation confirmed that `visudo /etc/sudoers` is interactive and cannot be used as a safe automated inspection. The derived page uses validated `sudo visudo -c`, which checks syntax without changing policy.
- 2026-08-25: Chapter 4 validation confirmed that the source `umask 000 filename` and `umask 077 filename` forms do not apply a mask to the named file. The derived page uses the valid mask-only forms. The documented `labuser`, `students`, `file01.txt`, `file02.txt`, `test01`, and `test02` fixtures were removed after validation.
- 2026-08-25: Chapter 6 validation reclassifies raw fstab lines, the uncreated `/dev/vdb2` example, generic LVM syntax, and unsafe `/dev/vda3` and `/dev/vda4` examples as reference content. The fstab edit is also reference guidance: it must be validated with `mount -a` before reboot, but no `/dev/vdb1` entry is retained because the sequential LVM lab wipes and repurposes `/dev/vdb`.
- 2026-08-25: The source `dd` commands zeroed the complete authorized 10 GiB `/dev/vdb` and `/dev/vdc` devices but ended with the expected end-of-device write error; they are documented but excluded from the successful-command record. The `lvm2` package transaction could not complete because the LAB HOST root filesystem was full, but installed LVM commands remained functional and the documented LVM workflow completed.
- 2026-08-25: Chapter 7 validation identified `ens2` as the active LAB HOST management interface and did not change its addressing, MAC address, link state, speed, ring settings, offloads, or VLAN configuration. Address and VLAN mutation teaching was safely substituted with a temporary `labdummy0` interface and documentation-range test subnet; all temporary state was removed.
- 2026-08-25: Chapter 7 reclassifies source placeholders, generic and topology-specific probes, unbounded diagnostics, unsupported `ens20`, raw standalone netcat commands, and management-interface mutations as beginner reference guidance. `ethtool` was already installed; the exact documented traceroute installation command succeeded on retry and remains installed. The first traceroute installation attempt installed the package but encountered a post-install no-space warning, so it is not recorded.
- 2026-08-25: The Networking Appendix is complete. Its IP-address definition now covers IPv4 and IPv6, its network-address example requires a prefix length, and its Ubuntu 24.04 Netplan guidance correctly describes `/etc/netplan/` filename variability and cloud-init regeneration.
- 2026-08-25: Chapter 8 validation is blocked. The exact `sudo apt install at -y` command failed with `No space left on device`; root had 55 MiB available (98% used) after the attempt. `ubuntu` is also denied both `at` and `atq`, so a harmless one-time job cannot be submitted or inspected. No cleanup, disk, service, or authorization change was made to work around either restriction.
- 2026-08-25: Replacement-environment prerequisite validation completed through the documented two-layer student route. The documented read-only operating-system, processor, memory, block-device, and outbound-connectivity checks succeeded. No package, configuration, service, network, disk, or other remote mutation was performed.
- 2026-08-25: Chapters 3 through 8 require replacement-environment revalidation. Their student-facing expected-result bodies still contain prior-environment captures and require a separate documented content reset; they were not mass-replaced during readiness validation.
- 2026-08-25: Sections 2.1 through 2.7 successful results were captured in isolated workspaces and cleaned. Fixed `/tmp/list.txt` and `/tmp/errors.txt` were safely removed.
- 2026-08-25: `man` without an argument and the `grep string` and `/r*` examples returned non-zero and are reference-only. The source TERM form mismatch remains pending.
- 2026-08-25: Interactive nano validation was completed by the user on the replacement LABVM; no terminal transcript was captured.
- 2026-08-27: The assigned public host was reached as `ubuntu` with non-interactive key-only SSH. Its documented nested-VM SSH route rejected both public-key and documented course-password authentication despite an available non-interactive password utility. No nested-VM preflight, Chapter 3 training command, or remote mutation occurred. Chapter 3 remains blocked; its historical expected-result captures, command record entries, prerequisites, and navigation status remain unchanged.
- 2026-08-27: The documented two-hop route succeeded non-interactively. Chapter 3 preflight confirmed non-interactive sudo, unheld apt/dpkg locks, 57 MiB free on `/`, and absent `file1.txt` and `dirone` fixtures in `/home/ubuntu`. The documented `sudo apt install tree -y` command failed with unmet dependencies for `linux-image-6.8.0-138-generic` and `linux-tools-6.8.0-138-generic`; consequently all three `tree` commands failed because `tree` was unavailable. All remaining Chapter 3 commands succeeded, including `sudo apt clean` and verified fixture cleanup. Safe literal captures were recorded for successful commands; failed-command results remain pending. Chapter 3 remains Blocked. No MkDocs build was run.
- 2026-08-27: A package-repair retry initially returned `Permission denied, please try again.` through the documented two-hop route. This transitory authentication event was superseded by the subsequently successful documented route; no command was run during the failed attempt.
- 2026-08-27: The approved repair completed through the documented two-hop route. `sudo apt-get --fix-broken install -y` installed and configured the two missing dependencies, `linux-modules-6.8.0-138-generic` and `linux-tools-6.8.0-138`; `sudo dpkg --audit` then exited successfully with no output. The exact source `sudo apt install tree -y` succeeded, `sudo apt clean` completed, and all Chapter 3 commands are complete. The root filesystem then had 328 MiB available (87% used). Tree results were captured using disposable temporary files that were removed. No destructive cleanup was performed.

## :material-book-open-page-variant-outline: Session Log

### :material-application-edit-outline: 2026-08-24

- Replaced stale site identity, navigation, curriculum tracking, command history, and inventory claims with Ubuntu Basic structural records.
- Created unvalidated navigation targets for the ten source chapters, the Networking Appendix, and Prerequisites.
- Preserved `ubuntu_basic_lab.md`, `docs/assets/`, deployment artifacts, and `Dockerfile`.
- Updated copied Helm identity labels without changing chart versioning, image tags, or deployment behavior.
- Reset unvalidated descriptive or assumed expected-result bodies, including source-provided fixtures, to pending notices; no commands were executed and no output was captured.
- Positioned the Prerequisites page immediately after Home and reserved it for validated current lab-environment findings.
- Next action remains command-by-command validation.
- No lab commands or MkDocs build were run.
- Validated the BofA outer GCP host: `n2-standard-4` in `europe-west3-a`, Ubuntu `22.04.5 LTS` (`jammy`), kernel `6.8.0-1066-gcp`, 4 vCPUs, and `16,767,156,224` bytes of memory.
- Validated root storage: `/dev/sda1` on a 40 GiB (`42,949,672,960` bytes) non-rotational `PersistentDisk`; the GCP disk tier remains unverified.
- Validated virtualization: `/dev/kvm`, KVM acceleration, `kvm_intel`, active/enabled monolithic `libvirtd`, libvirt/`virsh` `8.0.0`, QEMU `6.2.0`, `virt-install` `4.0.0`, `bridge-utils` `1.7`, and `sshpass` `1.09`.
- Confirmed variance: functional QEMU/KVM packages are installed, but `qemu-kvm` and `virtqemud.service` are absent; monolithic `libvirtd` provides libvirt.
- Initial default-URI nested checks were superseded by the explicit system-URI validation recorded below.
- No source training commands or MkDocs build were run.
- Narrowed the Prerequisites page to the validated outer initial state shared by students. BofA-specific and nested-environment findings remain internal in this tracker and `playground.md`.
- Readiness validation queried `qemu:///system`: `cloud` is an active/autostarted NAT network, and `ubuntu` is an active/running/autostarted domain. The guest address was confirmed by SSH; the lease query returned no entry.
- Successfully ran the beginner readiness set: outer `lsb_release -d` and `lsblk`; guest `lsb_release -d`, `nproc`, `free -h`, `lsblk`, and `ping -c 3 ubuntu.com`. The Prerequisites page now contains their captured basic checks.
- Chapter 1 is ready for command-by-command validation on the LAB HOST.
- Validated all five Chapter 1 source commands on the LAB HOST with exit status 0: interactive SSH, `cat /etc/os-release`, `cat /etc/lsb-release`, `uname -a`, and `cat /proc/version_signature`.
- `/etc/lsb-release` is present and succeeded on this LAB HOST, so its portability fallback was not needed. Corrected the derived Ubuntu 23.10 release date from October 2024 to October 2023.
- Recorded only safe literal output and excerpts; no authentication prompts, credentials, connection wrappers, outer-host details, or tokens were documented.

### :material-application-edit-outline: 2026-08-25

- Synchronized the assignment inventory from the reference JSON. `playground.md` is the authoritative current execution context, and `commands.md` is historical only. No Chapter 1 command was run in this change.
- Restored the validated source-required LABVM password comment in Prerequisites and Chapter 1 so students can complete the inner-hop connection; this documentation correction does not complete Chapter 1.
- Defined `LABHOST` as the assigned GCP VM and `LABVM` as the nested student VM. Normalized student-facing validation notes so prior-environment captures are historical and the replacement `LABVM` requires revalidation; no replacement-`LABVM` validation was performed.
- Defined canonical student-facing terminology: `LABHOST` is the assigned GCP VM reached from the learner's local computer with configured SSH keys, and `LABVM` is the nested internal VM reached from LABHOST. Normalized student-facing derived documentation so all chapter exercises run on LABVM; the first `exit` returns to LABHOST and the second returns to the local machine.
- Resumed Chapter 2 validation through the assigned outer host as `ubuntu` and the LAB HOST using the confirmed source credential. The prior `radu` connection attempt was an execution error, not a lab-environment blocker.
- Validated the pending shell-variable subshell sequence: unexported `x` is empty in a child shell, while exported `x` retains value `5`; both `exit` commands and the `export` assignment produce no output.
- Completed Chapter 2 command validation. Derived-document corrections were validated for `ls my*`, the single `TERM` assignment, `date +%A`, and `/tmp`; standalone parameter tokens and high-volume glob demonstrations were retained as reference syntax.
- Reconciled the Chapter 2 command record with captured successful source-verbatim commands; generic syntax, failed commands, derived corrections, reference syntax, and duplicates remain excluded.
- Completed Chapter 3 validation through the assigned outer host and LAB HOST. Reclassified generic `cd` syntax and illustrative/unavailable navigation paths as reference prose without result blocks.
- Captured literal outputs or safe faithful excerpts for all actionable commands. Large `tree` output was captured temporarily: the home listing contained 13,576 lines and the root two-level listing contained 696 lines. Temporary captures were deleted.
- Installed `tree` using the source command. The package transaction also completed pending kernel-package maintenance; no services, networks, disks, or lab configuration were changed by validation.
- Recorded successful source-verbatim commands only, excluding generic/reference forms and duplicates. Chapter 4 is ready for validation; no MkDocs build was run.
- Completed Chapter 4 validation through the assigned outer host and LAB HOST. Captured literal results and safe excerpts for user, group, sudo, shell-transition, umask, and permission commands; interactive password entry was not recorded.
- Reclassified generic syntax, sudoers policy examples, placeholders, and sample IDs as reference content. Replaced the unsafe interactive sudoers exercise with `sudo visudo -c` and corrected the misleading `umask` forms.
- Removed the documented Chapter 4 identities and fixtures after validation. Chapter 5 is ready for validation; no MkDocs build was run.
- Completed Chapter 5 validation on the assigned LAB HOST. The documented non-forced and forced logrotate commands completed successfully; safe excerpts only were retained.
- The LAB HOST restricted unprivileged `dmesg` access, so the `vda` searches returned no output and `vda.txt` was preserved as created by the documented command. The `/var/lib/logrotate/status` file was initially absent.
- Before the documented `cron` stop/start sequence, `cron` was active. It was inactive after the stop and active again after the start; no recovery beyond the documented sequence was required.
- Verified two independent SSH sessions before the documented SSH restart. The restart completed and post-restart SSH access remained active. No SSH configuration was changed.
- Recorded successful source commands only. Chapter 6 is ready for validation; no MkDocs build was run.
- Completed Chapter 6 validation on the assigned LAB HOST. Every storage mutation was preceded by checks that restricted targets to the unmounted 10 GiB `/dev/vdb` and `/dev/vdc` devices; `/dev/vda` was not changed.
- Captured literal output or faithful excerpts for partitioning, ext4, and LVM commands. The final documented state remains in place: `/dev/vdb1` and `/dev/vdc1` are physical volumes in `ubuntu-vg`, and ext4 `lvmdata` is mounted at `/lvmdata`.
- Reclassified fstab configuration and unsafe or uncreated-device examples as reference content. Chapter 7 is ready for validation; no MkDocs build was run.
- Completed Chapter 7 validation on the assigned LAB HOST. Management-interface configuration and outer-host/libvirt networking were not changed. Read-only `ip`, route, neighbour, `ethtool`, resolver, ping, traceroute, MTR, DNS, and local netcat checks were bounded; MTR and netcat used a PTY, and the netcat listener was closed normally.
- Replaced unsafe `ens2` mutations with a validated temporary dummy-interface exercise, then deleted the dummy interface and test state. Reclassified unsupported, generic, environment-specific, unbounded, and active-management examples as reference guidance. Corrected the validated appendix IPv4/IP-prefix and Netplan facts. Chapter 8 is ready for validation; no MkDocs build was run.
- Started Chapter 8 validation on the assigned LAB HOST. Captured `ps`, `top`, process priority, job-control, cron-editor, cron, and `htop` results. `top`, `nano`, `crontab -e`, and `htop` were captured in PTYs and exited normally.
- Replaced generic syntax, placeholder PIDs, destructive cron/at examples, and the SSH-daemon priority/kill exercise with reference guidance or safe disposable-process equivalents. Every validation loop was stopped with `SIGTERM`; the owned disposable `sleep` process was the only `SIGKILL` target. No loop remains running.
- Installed and removed only a validation-created crontab entry for `/home/ubuntu/chapter8-validation/cron-ran`; it executed successfully and the original empty crontab was restored. No `at` job was created. The isolated Chapter 8 files are retained as documented.
- The exact source `sudo apt install at -y` failed because the LAB HOST was out of space. `at`/`atq` are additionally denied to `ubuntu`; the source `sudo apt install -y htop` was not retried. Chapter 8 remains Blocked and Chapter 9 remains Structured. No MkDocs build was run.
- Added the Chapter 3 student-facing `sudo apt clean` cache cleanup immediately after `tree` installation to prevent cache buildup before later package operations; its result remains pending replacement-environment validation.
- Replacement deployment date: 2026-08-25. Performed read-only readiness validation only; no package, training, cleanup, service, network, disk, libvirt-configuration, MkDocs, or Git operations were run.
- The prerequisite validation completed through the documented two-layer student route. The successful source commands are recorded, and Prerequisites contains only safe literal output or excerpts.
- `playground.md` contains only the compact JSON-synchronized current assignment; superseded history belongs in this tracker.
- Chapter 2 validation is in progress on the replacement environment; Chapters 3 through 8 remain Ready for validation. Chapter 9 and 10 states remain Structured.
- Validated all five Chapter 1 source commands on the replacement environment with exit status 0: interactive SSH, `cat /etc/os-release`, `cat /etc/lsb-release`, `uname -a`, and `cat /proc/version_signature`.
- Added literal student-facing shell result blocks for all five successful Chapter 1 commands.
- No remote mutation was performed during Chapter 1 validation.
- Chapter 2 is the next validation target.
- Stale Chapter 2 results were reset to the standard pending notice before replacement validation; no Chapter 2 command has yet been executed in this validation pass.
- Applied partial Chapter 2 replacement-environment evidence for sections 2.1 through 2.7. Successful source-verbatim commands were added to the historical record; reference-only, failed, derived, duplicate, and skipped commands were excluded.
- Retained pending results for the source TERM mismatch, host-state-dependent `/tmp` chaining examples, and all user-deferred nano items. Chapter 2 remains Validating (replacement environment); navigation remains in progress.
- User-confirmed interactive nano completion finalized Chapter 2 on the replacement LABVM; no terminal transcript was captured and no MkDocs build was run.
- Reached the assigned public host as `ubuntu` with non-interactive key-only SSH. The documented nested-VM SSH route rejected both public-key and documented course-password authentication despite an available non-interactive password utility. No nested-VM preflight, Chapter 3 training command, or remote mutation occurred. Chapter 3 remains Blocked on nested-VM authentication; historical expected-result captures, command record entries, prerequisites, and navigation status remain unchanged. Restore documented nested-VM authentication before retrying.
- Retried Chapter 3 through the documented nested-VM route. First-hop `sshpass` availability and password-based nested authentication succeeded. The preflight confirmed `sudo -n true`, unheld apt/dpkg locks, 57 MiB free on `/`, and no `file1.txt` or `dirone` collision in `/home/ubuntu`.
- Ran the non-interactive Chapter 3 command sequence in one shell. `sudo apt install tree -y` failed with unmet dependencies for `linux-image-6.8.0-138-generic` and `linux-tools-6.8.0-138-generic`; `tree`, `tree -L 1 /`, and `tree -L 2 /` then failed because the utility was unavailable. All other commands succeeded. `sudo apt clean` succeeded, and the disposable `file1.txt` and `dirone` lifecycle was cleaned and verified.
- Reset stale Chapter 3 result bodies before execution, then recorded safe literal captures or excerpts only for successful commands. The Chapter remains Blocked, its navigation status is unchanged, and no MkDocs build was run.
- The approved package-repair retry returned `Permission denied, please try again.` at the documented two-hop SSH route. Stopped immediately as required; no further remote commands or documentation validation updates were made.
- The previous authentication failure was superseded by a successful retry through the same documented two-hop route. The approved repair installed and configured `linux-modules-6.8.0-138-generic` and `linux-tools-6.8.0-138`; `sudo dpkg --audit` returned no output. The exact `tree` installation completed, its required results were captured through disposable temporary files and those files were removed, and `df -h /` reported 328 MiB available (87% used). No kernels, packages, logs, snaps, or files were removed, and no destructive cleanup was performed. Chapter 3 and all of its subsections are Complete; Chapter 4 is the next validation target.

### :material-application-edit-outline: 2026-08-28

- The full 27-command current-page sequence ran; normal/forced rotation were authorized and run; expected nonzero observational statuses occurred for two no-match greps and inactive cron status; `vda.txt` was removed; cron was restored active/enabled; SSH restart and separate recovery passed; all expected results except `journalctl` were captured; no journal output was published; user-authorized sudo changes remain documented while source is unchanged.
- Chapter 5 was reset to pending captured results, missing source section structure was restored, and replacement-environment validation is active; no Chapter 5 source-command history was added at this preparation stage.
- Reset obsolete prior-environment Chapter 4 captures to pending and began controlled replacement-VM validation; validation is not complete.
- Chapter 4 replacement-VM preflight passed: the nested environment was `ubuntu` in `/home/ubuntu`, non-interactive sudo worked, sufficient package-free workspace was available, `sshpass` was available on LABHOST, the original umask was captured as `0002`, and no requested group, account, home-directory, or fixture collision existed.
- `sudo visudo -c`, group creation and verification, user creation, passwd-entry verification, and disabled-password inspection ran before the password step. The documented `sudo passwd labuser` command did not complete because the available PTY transport echoed password input before the password prompt, making capture unsafe. Dependent Chapter 4 commands were not run; page results remain pending and no source-command record was added.
- Removed only the `labuser` account and `students` group created by this session. Verified that the account, home directory, group, and all four Chapter 4 permission fixtures are absent; the ordinary-shell umask is `0002`. Chapter 4 and all listed subsections are Blocked pending safe prompt transport.
- Retried the full Chapter 4 validation with a prompt-aware PTY. Preflight and collision detection passed, and the documented password command received input only after each verified password prompt; password update confirmation was received without echoing password input. The run then stopped at the `sudo su - labuser` login-shell prompt transition because that shell replaced the PTY synchronization prompt. Dependent commands were not run, page results and command history remain pending, and no navigation change was made.
- Removed the session-created `labuser` account, `students` group, and any Chapter 4 permission fixtures after the stopped run. Verified that the account, home directory, group, and fixtures are absent and restored the ordinary-shell umask to `0002`.
- A further full retry again passed preflight and collision detection and safely completed the password-update prompt exchange without echoed input. The PTY timed out while verifying the subsequent `labuser` login-shell output, so dependent commands were not documented. Cleanup was independently rerun and verified: the session-created account, home directory, group, and fixtures are absent and the ordinary-shell umask is `0002`. Chapter 4 remains Blocked; all page results and command-history entries remain pending.
- The final Chapter 4 retry completed from clean preflight through cleanup. The password input was sent only after each verified prompt with terminal echo disabled; nonsecret forced-TTY transcripts verified the `labuser` home and root transition. ANSI display controls were stripped only in-memory before parsing the three literal `ls -l` excerpts. All four fixtures, the session-created user and home, and the group were removed, and the original umask was restored and verified. Chapter 4 and all listed subsections are Complete; Chapter 5 is next. No MkDocs build was run.
- Chapter 5 replacement-LABVM preflight succeeded through LABHOST `sshpass` availability but stopped before every Chapter 5 source command because `/var/lib/logrotate/status` is not readable by the fixed student user `ubuntu`; the authoritative unprivileged `cat /var/lib/logrotate/status` command cannot succeed unchanged. No source command, service/log/file state change, or source-command history entry occurred, and all expected results remain pending.
- The user authorized the replacement-LABVM documentation adjustment from `cat /var/lib/logrotate/status` to `sudo cat /var/lib/logrotate/status` after validation confirmed the original was unreadable; the source is unchanged and full validation resumed.
- Replacement-LABVM preflight confirmed unprivileged kernel messages are restricted. The user authorized documented `sudo` prefixes for the four `dmesg` commands; the source remains unchanged and validation continues.
- Chapter 5 forced-logrotate preflight measured `/var/log` apparent size at 162031 KiB and available space at 222092 KiB, below the required 375262 KiB safety minimum (`2 * apparent size + 51200`); the condition failed. No source command, service, log rotation, or file-state action occurred, and no destructive cleanup was performed.
- User-authorized removal of only APT cache and package-index contents succeeded. Root free capacity changed from 222076 KiB to 532116 KiB, exceeding the 375262 KiB safety threshold. No Chapter 5 source command, logrotate operation, service change, or command-history entry occurred. Full preflight must resume.
