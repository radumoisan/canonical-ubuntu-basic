# Lab Machine Inventory

## :material-book-open-page-variant-outline: BofA Lab Assignment

### :material-application-edit-outline: Validated Outer Host

- Validation date: 2026-08-24.
- Hostname: `radumoisan.cloudbase.internal`.
- Role: GCP nested-virtualization/libvirt host.
- Public IP: `34.159.241.17`.
- Machine type and zone: `n2-standard-4`, `europe-west3-a`.
- Operating system and kernel: Ubuntu `22.04.5 LTS` (`jammy`), `6.8.0-1066-gcp`.
- Resources: 4 vCPUs and `16,767,156,224` bytes of memory (approximately 16 GB).
- Root storage: `/dev/sda1` on `/dev/sda`; `PersistentDisk`, `42,949,672,960` bytes (40 GiB), `ROTA=0`.
- GCP disk tier: not verifiable from local evidence.
- KVM: `/dev/kvm` exists, KVM acceleration is confirmed, and `kvm_intel` is loaded.
- Libvirt: `libvirtd` is active and enabled; libvirt and `virsh` are `8.0.0`.
- Tools: QEMU `6.2.0`, `virt-install` `4.0.0`, `bridge-utils` `1.7`, and `sshpass` `1.09`; functional QEMU/KVM packages are installed.
- Variance: `qemu-kvm` is absent. `virtqemud.service` is absent because monolithic `libvirtd` is active.

### :material-application-edit-outline: Nested Guest `ubuntu`

- Validation date: 2026-08-24.
- System-libvirt network: `cloud` uses NAT with `192.168.100.0/24` (`192.168.100.1` netmask `255.255.255.0`); it is active, persistent, and autostarted.
- System-libvirt domain: `ubuntu` is active/running, persistent, and autostarted.
- Guest address: `192.168.100.4`, confirmed by successful SSH as `ubuntu`. `domifaddr --source lease` returned no lease entry during validation.
- Resources: 2 vCPUs; `4194304 KiB` maximum and used memory (4 GiB).
- Guest operating system: Ubuntu `24.04.2 LTS`.
- Disks: `vda` maps to `noble-server-cloudimg-amd64.img` and reports 3.5G; `vdb` and `vdc` map to `ubuntu-disk1.raw` and `ubuntu-disk2.raw` and each report 10G with no partitions.
- Guest outbound DNS and ICMP connectivity: validated with three successful replies to `ubuntu.com` and 0% packet loss.
