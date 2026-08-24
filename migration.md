# Ubuntu Basic Migration Tracker

## :material-book-open-page-variant-outline: Current State

- Current phase: Structural migration
- Active page: Ubuntu Basic site foundation
- Next action: Command-by-command validation
- No lab machine validation, source-command validation, or MkDocs build has been run.

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
| Home | Structured |
| Prerequisites | Structured |
| Networking Appendix | Structured |
| 1. What is Ubuntu | Structured |
| 2. CLI Environment | Structured |
| 3. Linux Filesystem Hierarchy | Structured |
| 4. Identity and Ownership | Structured |
| 5. Logging and Initialization | Structured |
| 6. Storage | Structured |
| 7. Networking | Structured |
| 8. Process Management | Structured |
| 9. Backup and Recovery | Structured |
| 10. Software Management | Structured |

## :material-book-open-page-variant-outline: Chapter Subsections

| Chapter | Source subsections | Status |
| --- | --- | --- |
| 1. What is Ubuntu | 1.1 What is Linux?; 1.2 What is the Kernel?; 1.3 What is Ubuntu?; 1.4 The Release Cycle; 1.5 Ubuntu Lab | Structured |
| 2. CLI Environment | 2.1 Secure Shell; 2.2 CLI Commands; 2.2.1 CLI Commands Lab; 2.3 Getting Help; 2.3.1 Getting Help Lab; 2.4 Shell Environment Variables; 2.4.1 Shell Environment and Variables Lab; 2.5 Standard Streams; 2.5.1 Redirection Lab; 2.6 Command Chaining; 2.7 Return Values and Expansion; 2.7.1 Chaining and Expansion Lab; 2.8 Introduction to nano; 2.8.1 nano Lab | Structured |
| 3. Linux Filesystem Hierarchy | 3.1 The Filesystem Hierarchy Standard; 3.2 Required Root Filesystem Directories; 3.2.1 Directory Structure Lab; 3.3 Linux File Types; 3.3.1 File Types Lab | Structured |
| 4. Identity and Ownership | 4.1 User Management; 4.2 Privilege Delegation; 4.2.1 User Management & Privileges Lab; 4.3 Permissions; 4.3.1 Permissions Lab | Structured |
| 5. Logging and Initialization | 5.1 System Logging; 5.1.1 System Logging Lab; 5.2 Boot Process Overview; 5.2.1 Boot Process Lab; 5.3 Systemd; 5.3.1 Systemd Lab | Structured |
| 6. Storage | 6.1 Partitioning; 6.1.1 Partitioning Lab; 6.2 File Systems; 6.2.1 Filesystems Lab; 6.3 LVM; 6.3.1 LVM Lab | Structured |
| 7. Networking | 7.1 Basic network commands; 7.1.1 ip Lab; 7.2 ethtool Command; 7.2.1 ethtool lab; 7.3 Network Troubleshooting Commands; 7.3.1 Networking Lab | Structured |
| 8. Process Management | 8.1 Process Administration; 8.2 Background Processes and priority; 8.3 Scheduling Processes; 8.3.1 Process Management Lab | Structured |
| 9. Backup and Recovery | 9.1 Using Archiving and Compression Utilities; 9.2 Tar archiving; 9.3 Using rsync; 9.4 Backup and Recovery Lab | Structured |
| 10. Software Management | 10.1 Debian Package Management; 10.2 Advanced Package Tool (Apt); 10.3 Snappy Package Management; 10.3.1 Software Management Lab | Structured |

## :material-book-open-page-variant-outline: Open Findings

- No validation results, lab-machine assignments, or command records exist.
- 2026-08-24: Structural migration had introduced unvalidated descriptive or assumed expected-result bodies. They were reset to `Validation pending; no captured output is available.`, including source-provided fixtures, because no commands have been executed.
- Deployment artifacts are retained; chart versioning and image tags remain CI-managed.
- 2026-08-24: The source statement that Ubuntu 23.10 was released in October 2024 requires factual validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `umask` default file-permissions semantics require command or factual validation before correction. They remain uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `umask 000 filename` command syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The source `visudo /etc/sudoers` syntax requires command validation before correction. It remains uncorrected in derived documentation because source validation is pending.
- 2026-08-24: The Networking appendix IPv4-only IP-address definition requires factual validation before correction. It remains uncorrected in derived documentation because source validation is pending.

## :material-book-open-page-variant-outline: Session Log

### :material-application-edit-outline: 2026-08-24

- Replaced stale site identity, navigation, curriculum tracking, command history, and inventory claims with Ubuntu Basic structural records.
- Created unvalidated navigation targets for the ten source chapters, the Networking Appendix, and Prerequisites.
- Preserved `ubuntu_basic_lab.md`, `docs/assets/`, deployment artifacts, and `Dockerfile`.
- Updated copied Helm identity labels without changing chart versioning, image tags, or deployment behavior.
- Reset unvalidated descriptive or assumed expected-result bodies, including source-provided fixtures, to pending notices; no commands were executed and no output was captured.
- Next action remains command-by-command validation.
- No lab commands or MkDocs build were run.
