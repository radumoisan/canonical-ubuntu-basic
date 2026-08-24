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
    Validation pending; no captured output is available.

```bash
# Add an address to ens2
sudo ip addr add 10.1.2.3/16 dev ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show link statistics for ens2
ip -s link show dev ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Create VLAN 42 above ens2
sudo ip link add dev vlan42 link ens2 type vlan id 42
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Change the ens2 MAC address
sudo ip link set dev ens2 address 02:42:43:44:45:56
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List network interfaces
ip link show
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 addresses
ip addr show ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add the lab address
sudo ip addr add 10.1.2.3/15 dev ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Verify the additional address
ip addr show ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show basic ens2 statistics
ip -s link show ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show detailed ens2 statistics
ip -s -s link show ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the lab address
sudo ip addr delete 10.1.2.3/15 dev ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the routing table
ip route show
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show cached neighbour entries
ip neigh show
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the route to 8.8.8.8
ip route get 8.8.8.8
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 link settings
ethtool ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set ens2 link speed
sudo ethtool -s ens2 speed 1000
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 ring sizes
ethtool -g ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Set the ens2 TX ring size
sudo ethtool -G ens2 tx 1024
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 driver information
ethtool -i ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show extended ens2 statistics
ethtool -S ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens20 feature settings
ethtool -k ens20
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Enable generic receive offload on ens2
ethtool -K ens2 gro on
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Disable ens2
sudo ifdown ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Enable ens2
sudo ifup ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install ethtool
sudo apt install -y ethtool
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 hardware information
ethtool ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 driver information
ethtool -i ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 statistics
ethtool -S ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show ens2 features
ethtool -k ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the permanent ens2 MAC address
ethtool -P ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Ping a host by address
ping 10.0.1.98
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Ping a host by name
ping www.google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Ping canonical.com
ping canonical.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Send three pings to ubuntu.com
ping -c 3 ubuntu.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Send numeric-only pings to ubuntu.com
ping -c 3 -n ubuntu.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Limit ping runtime to canonical.com
ping -w 2 canonical.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Trace the route to google.com
traceroute google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Trace the route to ubuntu.com continuously
mtr ubuntu.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Listen with netcat on port 2389
nc -l 2389
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Connect to the local netcat listener
nc localhost 2389
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Query DNS for ubuntu.com
dig ubuntu.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install traceroute
sudo apt install -y traceroute
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Send four pings to Google
ping -c 4 www.google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Trace the path to Google
traceroute www.google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Run an MTR trace to Google
mtr www.google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Query Google DNS information
dig www.google.com
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Check ens2 packet-drop statistics
ethtool -S ens2
```
??? example "Expected result"
    Validation pending; no captured output is available.
