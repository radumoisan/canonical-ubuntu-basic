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
    Literal excerpt: `state UP`. Interface names, MAC addresses, and link details vary by system.

```bash
# Show addresses for the management interface.
ip addr show dev ens2
```
??? example "Expected result"
    Literal excerpt: `scope global ens2`. Address and MAC values vary by environment.

```bash
# Show basic link statistics for the management interface.
ip -s link show dev ens2
```
??? example "Expected result"
    Literal excerpt: `RX:  bytes packets errors dropped`. Counters change while the interface is in use.

```bash
# Show detailed link statistics for the management interface.
ip -s -s link show ens2
```
??? example "Expected result"
    Literal excerpt: `RX errors:  length    crc   frame    fifo overrun`. Counter values vary.

```bash
# Display the routing table.
ip route show
```
??? example "Expected result"
    Literal excerpt: `default via`. Routes and addresses are environment-specific.

```bash
# Display cached neighbour entries.
ip neigh show
```
??? example "Expected result"
    Literal excerpt: `REACHABLE`. Entries and link-layer addresses vary with recent traffic.

```bash
# Show the route selected for a public address.
ip route get 8.8.8.8
```
??? example "Expected result"
    Literal excerpt: `cache`. The selected source address and next hop vary by environment.

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
    Literal excerpt: `inet 198.18.0.1/24 scope global labdummy0`.

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
    Literal excerpt: `vlan protocol 802.1Q id 42`.

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
    Literal excerpt: `ethtool is already the newest version`.

```bash
# Show link settings for the management interface.
ethtool ens2
```
??? example "Expected result"
    Literal excerpt: `Link detected: yes`. A virtual NIC may report `Speed: Unknown!` and a netlink permission warning.

```bash
# Show ring-buffer sizes for the management interface.
ethtool -g ens2
```
??? example "Expected result"
    Literal excerpt: `Current hardware settings:`. Available sizes are driver-specific.

```bash
# Show driver information for the management interface.
ethtool -i ens2
```
??? example "Expected result"
    Literal excerpt: `driver: virtio_net`. Driver and bus information vary by system.

```bash
# Show extended interface statistics.
ethtool -S ens2
```
??? example "Expected result"
    Literal excerpt: `rx_queue_0_drops: 0`. Statistic names and values vary by driver and traffic.

```bash
# Show current interface features.
ethtool -k ens2
```
??? example "Expected result"
    Literal excerpt: `generic-receive-offload: on`. Feature availability varies by driver.

```bash
# Show the permanent hardware address.
ethtool -P ens2
```
??? example "Expected result"
    Literal excerpt: `Permanent address:`. The address is intentionally omitted because it is environment-specific.

The source `ens20` feature example is unsupported in this lab and is reference syntax; substitute the interface selected on the target system. The source commands that set speed, change TX ring size, toggle GRO, or use `ifdown`/`ifup` are also reference syntax. Schedule those changes locally during an approved maintenance window; never apply them to an active management interface.

## :material-book-open-page-variant-outline: 7.3 Network Troubleshooting Commands

`ping` tests ICMP reachability, `traceroute` shows hops, `mtr` combines route and loss information, `nc` tests TCP or UDP connectivity, and `dig` queries DNS. ICMP and trace probes can be filtered by networks or firewalls.

```bash
# Send three pings to ubuntu.com.
ping -c 3 ubuntu.com
```
??? example "Expected result"
    Literal excerpt: `3 packets transmitted, 3 received, 0% packet loss`. Resolved addresses and timings vary.

```bash
# Send numeric-only pings to ubuntu.com.
ping -c 3 -n ubuntu.com
```
??? example "Expected result"
    Literal excerpt: `3 packets transmitted, 3 received, 0% packet loss`. Numeric addresses and timings vary.

```bash
# Limit ping runtime to canonical.com.
ping -w 2 canonical.com
```
??? example "Expected result"
    Literal excerpt: `2 packets transmitted, 2 received, 0% packet loss`. Results vary.

```bash
# Query DNS for ubuntu.com.
dig ubuntu.com
```
??? example "Expected result"
    Literal excerpt: `status: NOERROR`. Answer records, TTLs, resolver, and query time vary.

```bash
# Install traceroute.
sudo apt install -y traceroute
```
??? example "Expected result"
    Literal excerpt: `traceroute is already the newest version`.

```bash
# Send four pings to Google.
ping -c 4 www.google.com
```
??? example "Expected result"
    Literal excerpt: `4 packets transmitted, 4 received, 0% packet loss`. Resolved addresses and timings vary.

```bash
# Run a bounded numeric traceroute to Google.
traceroute -n -m 3 -w 2 www.google.com
```
??? example "Expected result"
    Literal excerpt: `3 hops max, 60 byte packets`. Hop addresses and timeouts vary.

```bash
# Run a bounded MTR report to Google.
mtr -n -r -c 2 www.google.com
```
??? example "Expected result"
    Literal excerpt: `Loss%   Snt   Last   Avg`. A non-responding hop can display `???`; this alone does not prove packet loss.

```bash
# Query DNS for Google.
dig www.google.com
```
??? example "Expected result"
    Literal excerpt: `status: NOERROR`. Answer records, TTLs, resolver, and query time vary.

The unbounded source `ping`, `traceroute`, and `mtr` examples, the topology-specific `ping 10.0.1.98`, and standalone `nc` listener/client examples are reference syntax. Use explicit packet, hop, or cycle limits for diagnostics. A validated coordinated local `nc` test passed with no output and closed its listener normally; arrange that test locally rather than opening an unattended listener.
