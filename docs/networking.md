# 7. Networking

!!! note
    Structured from the source material. Command validation is pending.

!!! abstract
    Inspect interfaces, use ethtool, and diagnose network connectivity.

## :material-book-open-page-variant-outline: 7.1 Basic Network Commands

`ip` and `ethtool` inspect and modify basic network configuration. `ip` manages interfaces, addresses, routing, neighbours, and virtual devices. `ethtool` manages low-level device settings. Any user can usually inspect configuration, but only the superuser can modify it.

`ip` subcommands include `address`, `neighbour`, `link`, and `route`. Options include `-4` for IPv4, `-6` for IPv6, `-s` for statistics, `-d` for extra detail, and `-r` to resolve host names.

```bash
# Show addresses for ens2
ip addr show dev ens2
```
??? example "Expected result"
    Address information for `ens2` is displayed.

```bash
# Add an address to ens2
sudo ip addr add 10.1.2.3/16 dev ens2
```
??? example "Expected result"
    No output on success. An associated subnet route is added automatically.

```bash
# Show link statistics for ens2
ip -s link show dev ens2
```
??? example "Expected result"
    Link and device statistics are displayed.

```bash
# Create VLAN 42 above ens2
sudo ip link add dev vlan42 link ens2 type vlan id 42
```
??? example "Expected result"
    No output on success. The `vlan42` virtual device is created.

```bash
# Change the ens2 MAC address
sudo ip link set dev ens2 address 02:42:43:44:45:56
```
??? example "Expected result"
    No output on success.

### :material-application-edit-outline: 7.1.1 ip Lab

```bash
# List network interfaces
ip link show
```
??? example "Expected result"
    Available network interfaces are listed.

```bash
# Show ens2 addresses
ip addr show ens2
```
??? example "Expected result"
    IP address information for `ens2` is displayed.

```bash
# Add the lab address
sudo ip addr add 10.1.2.3/15 dev ens2
```
??? example "Expected result"
    No output on success.

```bash
# Verify the additional address
ip addr show ens2
```
??? example "Expected result"
    `10.1.2.3/15` appears on `ens2`.

```bash
# Show basic ens2 statistics
ip -s link show ens2
```
??? example "Expected result"
    Interface statistics are displayed.

```bash
# Show detailed ens2 statistics
ip -s -s link show ens2
```
??? example "Expected result"
    Extended statistics, including errors, are displayed.

```bash
# Remove the lab address
sudo ip addr delete 10.1.2.3/15 dev ens2
```
??? example "Expected result"
    No output on success.

```bash
# Show the routing table
ip route show
```
??? example "Expected result"
    The system routing table is displayed.

```bash
# Show cached neighbour entries
ip neigh show
```
??? example "Expected result"
    Cached neighbour addresses are displayed.

```bash
# Show the route to 8.8.8.8
ip route get 8.8.8.8
```
??? example "Expected result"
    The route, selected interface, and source address are displayed.

## :material-book-open-page-variant-outline: 7.2 ethtool Command

Ethernet interfaces are commonly named `ethX` or `ensX`; the first is typically `eth0` or `ens2`. `ethtool` can inspect or modify physical link settings, transmit and receive rings, driver information, statistics, and protocol-offload features.

```bash
# Show ens2 link settings
ethtool ens2
```
??? example "Expected result"
    Link speed, duplex, and other interface settings are displayed.

```bash
# Set ens2 link speed
sudo ethtool -s ens2 speed 1000
```
??? example "Expected result"
    No output on success.

```bash
# Show ens2 ring sizes
ethtool -g ens2
```
??? example "Expected result"
    RX and TX ring parameters are displayed.

```bash
# Set the ens2 TX ring size
sudo ethtool -G ens2 tx 1024
```
??? example "Expected result"
    No output on success.

```bash
# Show ens2 driver information
ethtool -i ens2
```
??? example "Expected result"
    Driver, version, firmware, bus, and capability information are displayed.

```bash
# Show extended ens2 statistics
ethtool -S ens2
```
??? example "Expected result"
    Extended hardware statistics are displayed.

```bash
# Show ens20 feature settings
ethtool -k ens20
```
??? example "Expected result"
    Device feature settings are displayed if `ens20` exists.

```bash
# Enable generic receive offload on ens2
ethtool -K ens2 gro on
```
??? example "Expected result"
    No output on success.

!!! warning
    Bringing an interface down interrupts its network connection.

```bash
# Disable ens2
sudo ifdown ens2
```
??? example "Expected result"
    The interface is brought down.

```bash
# Enable ens2
sudo ifup ens2
```
??? example "Expected result"
    The interface is brought up.

### :material-application-edit-outline: 7.2.1 ethtool Lab

```bash
# Install ethtool
sudo apt install -y ethtool
```
??? example "Expected result"
    Package installation completes successfully.

```bash
# Show ens2 hardware information
ethtool ens2
```
??? example "Expected result"
    Link settings for `ens2` are displayed.

```bash
# Show ens2 driver information
ethtool -i ens2
```
??? example "Expected result"
    Driver information is displayed.

```bash
# Show ens2 statistics
ethtool -S ens2
```
??? example "Expected result"
    Interface statistics are displayed.

```bash
# Show ens2 features
ethtool -k ens2
```
??? example "Expected result"
    Current device feature settings are displayed.

```bash
# Show the permanent ens2 MAC address
ethtool -P ens2
```
??? example "Expected result"
    The permanent hardware address is displayed.

## :material-book-open-page-variant-outline: 7.3 Network Troubleshooting Commands

`ping` tests reachability by name or address, although ICMP can be blocked by firewalls. `traceroute` traces the path and latency to a host; use `-T` for TCP, `-U` for UDP, and `-n` to prevent reverse lookups. `mtr` combines continuous ping and traceroute statistics; `-c` limits cycles, `-T` uses TCP, and `-u` uses UDP.

```bash
# Ping a host by address
ping 10.0.1.98
```
??? example "Expected result"
    ICMP replies are shown when the host and ICMP are reachable.

```bash
# Ping a host by name
ping www.google.com
```
??? example "Expected result"
    ICMP replies are shown when DNS, routing, and ICMP are available.

```bash
# Ping canonical.com
ping canonical.com
```
??? example "Expected result"
    Continuous ICMP results are displayed until interrupted.

```bash
# Send three pings to ubuntu.com
ping -c 3 ubuntu.com
```
??? example "Expected result"
    Three ICMP results and summary statistics are displayed.

```bash
# Send numeric-only pings to ubuntu.com
ping -c 3 -n ubuntu.com
```
??? example "Expected result"
    Three ICMP results and summary statistics are displayed without reverse lookups.

```bash
# Limit ping runtime to canonical.com
ping -w 2 canonical.com
```
??? example "Expected result"
    Ping ends after the specified deadline.

```bash
# Trace the route to google.com
traceroute google.com
```
??? example "Expected result"
    Network hops and latency measurements are displayed; blocked hops may show timeouts.

```bash
# Trace the route to ubuntu.com continuously
mtr ubuntu.com
```
??? example "Expected result"
    Live route and packet-loss statistics are displayed; press `q` to exit.

`nc` reads and writes data across TCP or UDP connections. `dig` queries DNS servers; its output contains QUESTION and ANSWER sections plus query details.

```bash
# Listen with netcat on port 2389
nc -l 2389
```
??? example "Expected result"
    Netcat waits for an incoming connection.

```bash
# Connect to the local netcat listener
nc localhost 2389
```
??? example "Expected result"
    A connection is attempted to the listener on port 2389.

```bash
# Query DNS for ubuntu.com
dig ubuntu.com
```
??? example "Expected result"
    DNS query output includes QUESTION and ANSWER sections when resolution succeeds.

### :material-application-edit-outline: 7.3.1 Networking Lab

```bash
# Install traceroute
sudo apt install -y traceroute
```
??? example "Expected result"
    Package installation completes successfully.

```bash
# Send four pings to Google
ping -c 4 www.google.com
```
??? example "Expected result"
    Four ICMP results and packet-loss statistics are displayed when reachable.

```bash
# Trace the path to Google
traceroute www.google.com
```
??? example "Expected result"
    Route hops and latency measurements are displayed.

```bash
# Run an MTR trace to Google
mtr www.google.com
```
??? example "Expected result"
    Live route statistics are displayed; press `q` to exit.

```bash
# Query Google DNS information
dig www.google.com
```
??? example "Expected result"
    DNS query output is displayed.

```bash
# Check ens2 packet-drop statistics
ethtool -S ens2
```
??? example "Expected result"
    Source fixture: `NIC statistics:` includes `rx_queue_0_drops: 0`. Values and field names vary by driver; nonzero drops can indicate that the ring buffer needs increasing.
