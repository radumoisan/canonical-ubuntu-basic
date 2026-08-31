# Ubuntu Basic Migration Tracker

## :material-book-open-page-variant-outline: Purpose And Scope

- This file tracks only the initial migration from `ubuntu_basic_lab.md`: chapter/source coverage, structure and formatting readiness, source-material migration work, and migration history.
- Migration readiness does not imply validation. All validation activity, results, statuses, findings, blockers, attempts, environment facts, ongoing lab state, and the dated validation log are tracked solely in `validation.md`.
- Public pages carry no tracker content; student-facing pages follow the public documentation standards in `AGENTS.md`.

## :material-book-open-page-variant-outline: Status Legend

Migration statuses describe source-material migration readiness only:

- `Not started` - chapter content not yet migrated into a page.
- `Structured` - source content placed into the page with chapter/section structure.
- `Formatting` - structure in place; formatting normalization from the source is in progress.
- `Ready for validation` - migration work for the page is finished; the page is complete for migration purposes and awaits command validation, which is tracked in `validation.md`.

## :material-book-open-page-variant-outline: Page Coverage

| Page | Source material | Migration status |
| --- | --- | --- |
| Home | Source introduction | Ready for validation |
| Prerequisites | Reference page reserved for validated current lab-environment details and confirmed requirements | Ready for validation |
| Networking Appendix | Source appendix "Networking" | Ready for validation |
| 1. What is Ubuntu | Source chapter 1 | Ready for validation |
| 2. CLI Environment | Source chapter 2 | Ready for validation |
| 3. Linux Filesystem Hierarchy | Source chapter 3 | Ready for validation |
| 4. Identity and Ownership | Source chapter 4 | Ready for validation |
| 5. Logging and Initialization | Source chapter 5 | Ready for validation |
| 6. Storage | Source chapter 6 | Ready for validation |
| 7. Networking | Source chapter 7 | Ready for validation |
| 8. Process Management | Source chapter 8 | Ready for validation |
| 9. Backup and Recovery | Source chapter 9 | Ready for validation |
| 10. Software Management | Source chapter 10 | Ready for validation |

## :material-book-open-page-variant-outline: Chapter Subsections

| Chapter | Source subsections | Migration status |
| --- | --- | --- |
| 1. What is Ubuntu | 1.1 What is Linux?; 1.2 What is the Kernel?; 1.3 What is Ubuntu?; 1.4 The Release Cycle; 1.5 Ubuntu Lab | Ready for validation |
| 2. CLI Environment | 2.1 Secure Shell; 2.2 CLI Commands; 2.2.1 CLI Commands Lab; 2.3 Getting Help; 2.3.1 Getting Help Lab; 2.4 Shell Environment Variables; 2.4.1 Shell Environment and Variables Lab; 2.5 Standard Streams; 2.5.1 Redirection Lab; 2.6 Command Chaining; 2.7 Return Values and Expansion; 2.7.1 Chaining and Expansion Lab; 2.8 Introduction to nano; 2.8.1 nano Lab | Ready for validation |
| 3. Linux Filesystem Hierarchy | 3.1 The Filesystem Hierarchy Standard; 3.2 Required Root Filesystem Directories; 3.2.1 Directory Structure Lab; 3.3 Linux File Types; 3.3.1 File Types Lab | Ready for validation |
| 4. Identity and Ownership | 4.1 User Management; 4.2 Privilege Delegation; 4.2.1 User Management & Privileges Lab; 4.3 Permissions; 4.3.1 Permissions Lab | Ready for validation |
| 5. Logging and Initialization | 5.1 System Logging; 5.1.1 System Logging Lab; 5.2 Boot Process Overview; 5.2.1 Boot Process Lab; 5.3 Systemd; 5.3.1 Systemd Lab | Ready for validation |
| 6. Storage | 6.1 Partitioning; 6.1.1 Partitioning Lab; 6.2 File Systems; 6.2.1 Filesystems Lab; 6.3 LVM; 6.3.1 LVM Lab | Ready for validation |
| 7. Networking | 7.1 Basic network commands; 7.1.1 ip Lab; 7.2 ethtool Command; 7.2.1 ethtool lab; 7.3 Network Troubleshooting Commands; 7.3.1 Networking Lab | Ready for validation |
| 8. Process Management | 8.1 Process Administration; 8.2 Background Processes and priority; 8.3 Scheduling Processes; 8.3.1 Process Management Lab | Ready for validation |
| 9. Backup and Recovery | 9.1 Using Archiving and Compression Utilities; 9.2 Tar archiving; 9.3 Using rsync; 9.4 Backup and Recovery Lab | Ready for validation |
| 10. Software Management | 10.1 Debian Package Management; 10.2 Advanced Package Tool (Apt); 10.3 Snappy Package Management; 10.3.1 Software Management Lab | Ready for validation |

## :material-book-open-page-variant-outline: Migration History

### :material-application-edit-outline: 2026-08-24

- Replaced stale site identity, navigation, curriculum tracking, command history, and inventory claims with Ubuntu Basic structural records.
- Created unvalidated navigation targets for the ten source chapters, the Networking Appendix, and Prerequisites.
- Preserved `ubuntu_basic_lab.md`, `docs/assets/`, deployment artifacts, and `Dockerfile`.
- Updated copied Helm identity labels without changing chart versioning, image tags, or deployment behavior.
- Reset unvalidated descriptive or assumed expected-result bodies, including source-provided fixtures, to pending notices.
- Positioned the Prerequisites page immediately after Home and reserved it for validated current lab-environment findings.
- Deployment artifacts are retained; chart versioning and image tags remain CI-managed.

### :material-application-edit-outline: 2026-08-31

- Tracker split: this file now records only the source-material migration described above. All prior validation state, statuses, open findings, and session-log evidence were moved to `validation.md` without deletion; validation content is no longer tracked here.
