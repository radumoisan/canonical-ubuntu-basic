# 7. Networking

!!! abstract
    Inspect interfaces, routes, Ethernet settings, and connectivity without disrupting the active connection.

## :material-book-open-page-variant-outline: 7.1 Basic Network Commands

`ip` inspects and modifies interface addresses, links, routes, neighbours, and virtual devices. Use it without `sudo` for inspection. Changes require `sudo` and can disconnect a remote system when applied to its management interface.

### :material-application-edit-outline: Inspect the current configuration

```bash
# List network interfaces.
ip link show
```
??? example "Expected result"
    ens2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000

```bash
# Show addresses for the management interface.
ip addr show dev ens2
```
??? example "Expected result"
    ens2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    altname enp0s2

```bash
# Show basic link statistics for the management interface.
ip -s link show dev ens2
```
??? example "Expected result"
    ens2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    RX:  bytes packets errors dropped  missed   mcast
     368363847  216111      0  185579       0       0
    TX:  bytes packets errors dropped carrier collsns
       2857444   24323      0       0       0       0
    altname enp0s2

```bash
# Show detailed link statistics for the management interface.
ip -s -s link show ens2
```
??? example "Expected result"
    ens2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    RX:  bytes packets errors dropped  missed   mcast
     368365269  216120      0  185579       0       0
    RX errors:  length    crc   frame    fifo overrun
                     0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
       2858614   24330      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       2
    altname enp0s2

```bash
# Display the routing table.
ip route show
```
??? example "Expected result"
    default via

```bash
# Display cached neighbour entries.
ip neigh show
```
??? example "Expected result"
    REACHABLE

```bash
# Show the route selected for a public address.
ip route get 8.8.8.8
```
??? example "Expected result"
        cache

### :material-application-edit-outline: Safe address and VLAN practice

The source examples that add `10.1.2.3/16` or `10.1.2.3/15`, create `vlan42`, or change the MAC address on `ens2` are reference syntax. Do not use them on an active management interface. The validated lab equivalent used the disposable `labdummy0` interface and the private benchmarking range `198.18.0.0/24`; it was deleted after the exercise.

```bash
# Create a temporary dummy interface.
sudo ip link add labdummy0 type dummy
```
??? example "Expected result"
    No output.

```bash
# Enable the temporary dummy interface.
sudo ip link set labdummy0 up
```
??? example "Expected result"
    No output.

```bash
# Add a temporary test address to the dummy interface.
sudo ip addr add 198.18.0.1/24 dev labdummy0
```
??? example "Expected result"
    No output.

```bash
# Verify the temporary test address.
ip addr show dev labdummy0
```
??? example "Expected result"
    labdummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000

```bash
# Create a temporary VLAN above the dummy interface.
sudo ip link add dev labdummy42 link labdummy0 type vlan id 42
```
??? example "Expected result"
    No output.

```bash
# Verify the temporary VLAN configuration.
ip -d link show dev labdummy42
```
??? example "Expected result"
    labdummy42@labdummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    vlan protocol 802.1Q id 42 <REORDER_HDR> addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536

```bash
# Delete the temporary VLAN.
sudo ip link delete labdummy42
```
??? example "Expected result"
    No output.

```bash
# Remove the temporary test address.
sudo ip addr delete 198.18.0.1/24 dev labdummy0
```
??? example "Expected result"
    No output.

```bash
# Delete the temporary dummy interface.
sudo ip link delete labdummy0
```
??? example "Expected result"
    No output.

## :material-book-open-page-variant-outline: 7.2 ethtool Command

`ethtool` displays or changes Ethernet link settings, ring buffers, driver information, statistics, and offload features. Virtual NICs can report limited hardware data.

```bash
# Install ethtool.
sudo apt install -y ethtool
```
??? example "Expected result"
    Reading package lists...
    Building dependency tree...
    Reading state information...
    ethtool is already the newest version (1:6.7-1build1).

```bash
# Show link settings for the management interface.
ethtool ens2
```
??? example "Expected result"
    Settings for ens2:
    Supported ports: [  ]
    Supported link modes:   Not reported
    Supports auto-negotiation: No
    Speed: Unknown!
    Duplex: Unknown! (255)
    Auto-negotiation: off
    Link detected: yes

```bash
# Show ring-buffer sizes for the management interface.
ethtool -g ens2
```
??? example "Expected result"
    Ring parameters for ens2:
    Pre-set maximums:
    RX:			256
    TX:			256
    Current hardware settings:
    RX:			256
    TX:			256
    TX Push:		off
    RX Push:		off

```bash
# Show driver information for the management interface.
ethtool -i ens2
```
??? example "Expected result"
    driver: virtio_net
    version: 1.0.0
    firmware-version:
    expansion-rom-version:
    bus-info: 0000:00:02.0
    supports-statistics: yes
    supports-test: no

```bash
# Show extended interface statistics.
ethtool -S ens2
```
??? example "Expected result"
    NIC statistics:
         rx_queue_0_packets: 216591
         rx_queue_0_bytes: 368437855
         rx_queue_0_drops: 0
         tx_queue_0_packets: 24634
         tx_queue_0_bytes: 2918992
         tx_queue_0_xdp_tx_drops: 0
         tx_queue_0_tx_timeouts: 0

```bash
# Show current interface features.
ethtool -k ens2
```
??? example "Expected result"
    Features for ens2:
    rx-checksumming: on [fixed]
    tx-checksumming: on
    tx-checksum-ipv4: off [fixed]
    tx-checksum-ip-generic: on
    scatter-gather: on
    tcp-segmentation-offload: on
    generic-segmentation-offload: on
    generic-receive-offload: on
    rx-vlan-filter: on [fixed]

```bash
# Show the permanent hardware address.
ethtool -P ens2
```
??? example "Expected result"
    Permanent address:

The source `ens20` feature example is unsupported in this lab and is reference syntax; substitute the interface selected on the target system. The source commands that set speed, change TX ring size, toggle GRO, or use `ifdown`/`ifup` are also reference syntax. Schedule those changes locally during an approved maintenance window; never apply them to an active management interface.

## :material-book-open-page-variant-outline: 7.3 Network Troubleshooting Commands

`ping` tests ICMP reachability, `traceroute` shows hops, `mtr` combines route and loss information, `nc` tests TCP or UDP connectivity, and `dig` queries DNS. ICMP and trace probes can be filtered by networks or firewalls.

```bash
# Send three pings to ubuntu.com.
ping -c 3 ubuntu.com
```
??? example "Expected result"
    3 packets transmitted, 3 received, 0% packet loss, time 2003ms

```bash
# Send numeric-only pings to ubuntu.com.
ping -c 3 -n ubuntu.com
```
??? example "Expected result"
    3 packets transmitted, 3 received, 0% packet loss, time 2002ms

```bash
# Limit ping runtime to canonical.com.
ping -w 2 canonical.com
```
??? example "Expected result"
    2 packets transmitted, 2 received, 0% packet loss, time 1001ms

```bash
# Query DNS for ubuntu.com.
dig ubuntu.com
```
??? example "Expected result"
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32597
    ;; Query time: 0 msec

```bash
# Install traceroute.
sudo apt install -y traceroute
```
??? example "Expected result"
    Reading package lists...
    Building dependency tree...
    Reading state information...

```bash
# Send four pings to Google.
ping -c 4 www.google.com
```
??? example "Expected result"
    4 packets transmitted, 4 received, 0% packet loss, time 3030ms

```bash
# Run a bounded numeric traceroute to Google.
traceroute -n -m 3 -w 2 www.google.com
```
??? example "Expected result"
    traceroute

```bash
# Run a bounded MTR report to Google.
mtr -n -r -c 2 www.google.com
```
??? example "Expected result"
    Start:

```bash
# Query DNS for Google.
dig www.google.com
```
??? example "Expected result"
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 62617
    ;; Query time: 1 msec

The unbounded source `ping`, `traceroute`, and `mtr` examples, the topology-specific `ping 10.0.1.98`, and standalone `nc` listener/client examples are reference syntax. Use explicit packet, hop, or cycle limits for diagnostics. A validated coordinated local `nc` test passed with no output and closed its listener normally; arrange that test locally rather than opening an unattended listener.
