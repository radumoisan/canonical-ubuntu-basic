# Ubuntu Basic Migration Tracker

## :material-book-open-page-variant-outline: Current State

- Current phase: Chapters 1 through 3 complete; Chapter 4 ready for validation.
- Active target: Chapter 4.
- Next action: Validate Chapter 4 command-by-command on the LAB HOST.
- Two-layer student-environment readiness checks and Chapter 1 source commands are validated; no MkDocs build has been run.

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
| Networking Appendix | Structured |
| 1. What is Ubuntu | Complete |
| 2. CLI Environment | Complete |
| 3. Linux Filesystem Hierarchy | Complete |
| 4. Identity and Ownership | Ready for validation |
| 5. Logging and Initialization | Structured |
| 6. Storage | Structured |
| 7. Networking | Structured |
| 8. Process Management | Structured |
| 9. Backup and Recovery | Structured |
| 10. Software Management | Structured |

## :material-book-open-page-variant-outline: Chapter Subsections

| Chapter | Source subsections | Status |
| --- | --- | --- |
| 1. What is Ubuntu | 1.1 What is Linux?; 1.2 What is the Kernel?; 1.3 What is Ubuntu?; 1.4 The Release Cycle; 1.5 Ubuntu Lab | Complete (all source commands validated; `/etc/lsb-release` is present on this LAB HOST, so no portability correction was needed; Ubuntu 23.10 date corrected) |
| 2. CLI Environment | 2.1 Secure Shell; 2.2 CLI Commands; 2.2.1 CLI Commands Lab; 2.3 Getting Help; 2.3.1 Getting Help Lab; 2.4 Shell Environment Variables; 2.4.1 Shell Environment and Variables Lab; 2.5 Standard Streams; 2.5.1 Redirection Lab; 2.6 Command Chaining; 2.7 Return Values and Expansion; 2.7.1 Chaining and Expansion Lab; 2.8 Introduction to nano; 2.8.1 nano Lab | Complete |
| 3. Linux Filesystem Hierarchy | 3.1 The Filesystem Hierarchy Standard; 3.2 Required Root Filesystem Directories; 3.2.1 Directory Structure Lab; 3.3 Linux File Types; 3.3.1 File Types Lab | Complete (all actionable source commands validated) |
| 4. Identity and Ownership | 4.1 User Management; 4.2 Privilege Delegation; 4.2.1 User Management & Privileges Lab; 4.3 Permissions; 4.3.1 Permissions Lab | Structured |
| 5. Logging and Initialization | 5.1 System Logging; 5.1.1 System Logging Lab; 5.2 Boot Process Overview; 5.2.1 Boot Process Lab; 5.3 Systemd; 5.3.1 Systemd Lab | Structured |
| 6. Storage | 6.1 Partitioning; 6.1.1 Partitioning Lab; 6.2 File Systems; 6.2.1 Filesystems Lab; 6.3 LVM; 6.3.1 LVM Lab | Structured |
| 7. Networking | 7.1 Basic network commands; 7.1.1 ip Lab; 7.2 ethtool Command; 7.2.1 ethtool lab; 7.3 Network Troubleshooting Commands; 7.3.1 Networking Lab | Structured |
| 8. Process Management | 8.1 Process Administration; 8.2 Background Processes and priority; 8.3 Scheduling Processes; 8.3.1 Process Management Lab | Structured |
| 9. Backup and Recovery | 9.1 Using Archiving and Compression Utilities; 9.2 Tar archiving; 9.3 Using rsync; 9.4 Backup and Recovery Lab | Structured |
| 10. Software Management | 10.1 Debian Package Management; 10.2 Advanced Package Tool (Apt); 10.3 Snappy Package Management; 10.3.1 Software Management Lab | Structured |

## :material-book-open-page-variant-outline: Open Findings

- 2026-08-24: Explicit `qemu:///system` validation found the `cloud` NAT network active and autostarted on `192.168.100.0/24`, and the `ubuntu` domain running and autostarted. Guest SSH at `192.168.100.4`, resources, disks, operating system, and outbound DNS/ICMP connectivity are validated.
- 2026-08-24: GCP disk tier cannot be verified from the available local evidence.
- 2026-08-24: Package and service variance is confirmed: `qemu-kvm` and `virtqemud.service` are absent while functional QEMU/KVM packages and active monolithic `libvirtd` are present.
- 2026-08-24: Structural migration had introduced unvalidated descriptive or assumed expected-result bodies. They were reset to `Validation pending; no captured output is available.`, including source-provided fixtures, because no commands have been executed.
- Deployment artifacts are retained; chart versioning and image tags remain CI-managed.
- 2026-08-24: The derived Chapter 1 page corrects Ubuntu 23.10's release date from October 2024 to October 2023.
- 2026-08-24: The source `umask` default file-permissions semantics require command or factual validation before correction. They remain uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `umask 000 filename` command syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `visudo /etc/sudoers` syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The Networking appendix IPv4-only IP-address definition requires factual validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-25: Chapter 3 validation confirmed Ubuntu's merged `/usr` root symlinks and an empty `/usr/games`; directory, device, package, kernel, and home-directory listings are host-state-dependent. No source-derived command or path correction was needed. `tree` was installed as documented and remains installed; the documented file-type fixtures were removed successfully.

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
- Readiness validation queried `qemu:///system`: `cloud` is an active/autostarted NAT network on `192.168.100.0/24`, and `ubuntu` is an active/running/autostarted domain. The guest address was confirmed by SSH at `192.168.100.4`; the lease query returned no entry.
- Successfully ran the beginner readiness set: outer `lsb_release -d` and `lsblk`; guest `lsb_release -d`, `nproc`, `free -h`, `lsblk`, and `ping -c 3 ubuntu.com`. The Prerequisites page now contains their captured basic checks.
- Chapter 1 is ready for command-by-command validation on the LAB HOST.
- Validated all five Chapter 1 source commands on the LAB HOST with exit status 0: interactive SSH, `cat /etc/os-release`, `cat /etc/lsb-release`, `uname -a`, and `cat /proc/version_signature`.
- `/etc/lsb-release` is present and succeeded on this LAB HOST, so its portability fallback was not needed. Corrected the derived Ubuntu 23.10 release date from October 2024 to October 2023.
- Recorded only safe literal output and excerpts; no authentication prompts, credentials, connection wrappers, outer-host details, or tokens were documented.

### :material-application-edit-outline: 2026-08-25

- Resumed Chapter 2 validation through the assigned outer host as `ubuntu` and the LAB HOST using the confirmed source credential. The prior `radu` connection attempt was an execution error, not a lab-environment blocker.
- Validated the pending shell-variable subshell sequence: unexported `x` is empty in a child shell, while exported `x` retains value `5`; both `exit` commands and the `export` assignment produce no output.
- Completed Chapter 2 command validation. Derived-document corrections were validated for `ls my*`, the single `TERM` assignment, `date +%A`, and `/tmp`; standalone parameter tokens and high-volume glob demonstrations were retained as reference syntax.
- Reconciled the Chapter 2 command record with captured successful source-verbatim commands; generic syntax, failed commands, derived corrections, reference syntax, and duplicates remain excluded.
- Completed Chapter 3 validation through the assigned outer host and LAB HOST. Reclassified generic `cd` syntax and illustrative/unavailable navigation paths as reference prose without result blocks.
- Captured literal outputs or safe faithful excerpts for all actionable commands. Large `tree` output was captured temporarily: the home listing contained 13,576 lines and the root two-level listing contained 696 lines. Temporary captures were deleted.
- Installed `tree` using the source command. The package transaction also completed pending kernel-package maintenance; no services, networks, disks, or lab configuration were changed by validation.
- Recorded successful source-verbatim commands only, excluding generic/reference forms and duplicates. Chapter 4 is ready for validation; no MkDocs build was run.
