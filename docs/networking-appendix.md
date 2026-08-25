# Appendix: Networking

!!! abstract
    Reference concepts and Ubuntu 24.04 network configuration guidance.

## :material-book-open-page-variant-outline: Networking Concepts - TCP/IP

The Transmission Control Protocol and Internet Protocol (TCP/IP) is a standard set of protocols developed in the late 1970s by the Defense Advanced Research Projects Agency (DARPA) as a means of communication between different types of computers and computer networks. TCP/IP is the driving force of the Internet, and thus it is the most popular set of network protocols on Earth.

The two protocol components of TCP/IP deal with different aspects of computer networking. Internet Protocol, the "IP" of TCP/IP is a connectionless protocol which deals only with network packet routing using the IP Datagram as the basic unit of networking information. The IP Datagram consists of a header followed by a message. The Transmission Control Protocol, the "TCP", enables network hosts to establish connections which may be used to exchange data streams. TCP also guarantees that the data between connections is delivered and arrives in the same order as it was sent.

The TCP/IP protocol configuration consists of several elements which must be set by editing the appropriate configuration files or deploying solutions such as the Dynamic Host Configuration Protocol (DHCP) server. The DHCP can be configured to provide the proper TCP/IP configuration settings to network clients automatically. These configuration values must be set correctly to ensure the proper network operation of your Ubuntu system.

The common configuration elements of TCP/IP and their purposes are as follows:

- Network interfaces are logical constructs that represent a network device. The interface contains the L2 (physical network) and L3 (IPv4 or IPv6 protocol layer) address information, configuration information, and device state.
- Network devices, frequently called NIC, are physical hardware that connects to a network. Virtual devices emulate a physical network facility in software, (ex. a bond is a virtual device that aggregates together a set of network interfaces.)
- The neighbour subsystem manages information and configuration for L2 (link layer) destinations.
- Routing is the act of sending traffic originating on one subnet to a second subnet.
- The routing layer manages information and configuration for L3 protocol forwarding. This allows L3 subnets to communicate with one another.
- An IP address identifies an interface at the network layer. IPv4 addresses use four decimal octets from 0 to 255 (32 bits total), while IPv6 addresses use 128 bits written in colon-separated hexadecimal groups. Addresses can be assigned statically or dynamically, for example through DHCP.
- A subnet (for this document) is the extent of the L3 (i.e., IPv4 or IPv6) network segment that delineates the set of destinations to which an IP datagram may be delivered without being routed.
- The Subnet Mask (or netmask) is a local bit mask, or set of flags which separates the portions of an IP address significant to the network from the bits significant to the subnetwork. The standard netmask 255.255.255.0 masks the first 3 bytes and allows the last byte to remain available to specify hosts on the subnetwork.
- The Network Address represents the address bits selected by the prefix length. For example, `12.128.1.2/8` has network address `12.0.0.0`; the prefix length is required to determine the network address.
- Gateway is synonymous with router; it is responsible for the connection of two or more subnets by passing L3 protocol traffic between them.
- The Broadcast Address is an IP address which allows network data to be sent simultaneously to all hosts on a given subnetwork rather than specifying a particular host. For example, on 192.168.1.0, the broadcast address is 192.168.1.255. Broadcast messages are typically produced by network protocols such as the Address Resolution Protocol (ARP) and the Routing Information Protocol (RIP).
- A Gateway Address is the IP address through which a particular network, or host on a network, may be reached. If one network host wishes to communicate with another network host, and that host is not located on the same network, then a gateway must be used (ex. a router on the same network).
- Nameserver Addresses represent the IP addresses of Domain Name Service (DNS) systems, which resolve network hostnames into IP addresses. In order for your system to be able to resolve network hostnames into their corresponding IP addresses, you must specify valid Nameserver Addresses which you are authorized to use in your system's TCP/IP configuration. In many cases, these addresses can and will be provided by your network service provider, but many free and publicly accessible nameservers are available.

## :material-book-open-page-variant-outline: IP Routing

IP routing is a means of specifying and discovering paths in a TCP/IP network along which network data may be sent. Routing uses a set of routing tables to direct the forwarding of network data packets from their source to the destination, via many intermediary network nodes known as routers. The primary forms are Static Routing and Dynamic Routing.

`Static routing` involves manually adding IP routes to the system's routing table with the route command. It has the advantage of simplicity of implementation on smaller networks, predictability (the routing table is always computed in advance so the route is the same each time), and low overhead on other routers and network links due to the lack of a dynamic routing protocol. The disadvantages are that it is limited to small networks and does not scale well. It also fails completely to adapt to network outages and failures along the route due to the fixed nature of the route.

`Dynamic routing` depends on large networks with multiple possible IP routes from a source to a destination and makes use of special routing protocols, such as the Router Information Protocol (RIP), which handle the automatic adjustments in routing tables that make dynamic routing possible. It has several advantages over static routing: superior scalability; the ability to adapt to failures and outages along network routes; and less manual configuration of the routing tables (routers learn from one another about their existence and available routes eliminating human errors). The disadvantages are complexity and additional network overhead from router communications, which consumes network bandwidth.

## :material-book-open-page-variant-outline: Network Configuration Files

In Ubuntu 24.04, Netplan reads YAML configuration files from `/etc/netplan/`. The filename is installation-specific: cloud-init commonly creates `50-cloud-init.yaml`, while an installer or administrator can use another `.yaml` filename. Cloud-init-managed configuration can be regenerated, so make persistent changes using the system's intended Netplan and cloud-init workflow. Netplan can configure addresses, routes, and DNS options.
