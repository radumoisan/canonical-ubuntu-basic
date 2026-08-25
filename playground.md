# Lab Machine Inventory

## :material-book-open-page-variant-outline: BofA Lab Assignment

### :material-application-edit-outline: Replacement Assignment

- Replacement deployment date: 2026-08-25.
- Role: `LABHOST`, the GCE nested-virtualization/libvirt host.
- LABHOST SSH: key-based SSH was confirmed.
- LABHOST operating system: Ubuntu `22.04.5 LTS`.
- LABHOST capacity: 4 vCPUs, approximately 15 GiB memory, and 34 GiB free on the 39 GiB root filesystem.
- LABHOST storage: non-rotational 40 GiB `PersistentDisk`; root is on `sda1`.
- Virtualization: `/dev/kvm` is present, `kvm_intel` is loaded, and `libvirtd` is active and enabled.
- System libvirt: the persistent `cloud` network is active and autostarted; the persistent `ubuntu` domain is running and autostarted with 2 vCPUs and 4 GiB memory.
- LABVM endpoint: the running private LABVM is reachable; neither the system-libvirt guest-agent nor DHCP-lease source reported an address.
- LABVM SSH: the public key was rejected. The course password remains required for the documented tutorial connection and was not tested by this task. LABVM operating-system, capacity, disk, free-space, outbound-connectivity, and `at` checks remain unvalidated.
- Package-installation viability: not determined because LABVM root capacity could not be inspected.

### :material-application-edit-outline: Superseded Environment History

- The 2026-08-24 `LABHOST` and `LABVM` validation records are superseded by the replacement deployment.
- The prior `LABVM` captured chapter output must not be treated as validation evidence for the replacement `LABHOST` or `LABVM`.
