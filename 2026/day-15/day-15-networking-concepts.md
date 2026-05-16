# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Task 1: DNS – How Names Become IPs
Q. What happens when you type google.com in browser?
Ans:--> 
 - When we type `google.com` then the browser take the url and search in local cache if not found it search in OS cache then the local dns to find out if any ip address is attched to it or not.
 - If it fails to resolve the name locally, it goes to ISP(Internet Service Provider) resolver, if not found then it go to external DNS resolver server (TLD-Top Level Domain) to identify (name resolution).

### DNS Record Types
|DNS Record| Meaning                                        |
|----------|------------------------------------------------|
| A        | Maps domain name to IPv4 address               |
| AAAA     | Maps domain name to IPv6 address               |
| CNAME    | Alias from one domain to another               |
| MX       | Mail server responsible for receiving emails   | 
| NS       | Defines authoritative name servers for a doman |

### Command Output

```bash
dig google.com
```

![dig google.com]()

A Record IP: 192.178.211.101
TTL: 202 seconds

---
## Task 2: IP Addressing

### 1. What is an IPv4 address? How is it structured? (e.g., 192.168.1.10)

- An IP address is an unique label assigned to every device connected to a network. Think of it like a phone number of a device so if we want to call a friend then the signal knows which phone in the world to ring, without the number we can't connect.
- An IPv4 address (Internet Protocol version 4) is a 32-bit numerical label assigned to every device in the network.
- The structure of an IPv4 address:
    - An IPv4 address ex: 192.168.1.10 is made of four sections called octets(0–255) separated by dots (because it represents 8bit of data in each section).
    - It has 2 logical parts: (a.) Network part --> Identifies the network. (b.) Host part → Identifies the device inside that network.
    - Here, 192.168.1 --> Network and 10 --> device/host
### 2. Difference between public and private IPs — give one example of each.
- Public IP:
    - Public IP is internet-facing. Anyone on the internet can reach that IP (if firewall/security rules allow).
    - Example: 8.8.8.8

- Private IP:
    - Private IP is used inside a local network and is accessible only within that network.
    - Example: 192.168.1.10

### 3. What are the private IP ranges?

10.x.x.x, 172.16.x.x – 172.31.x.x, 192.168.x.x

Private IP Ranges: 

10.0.0.0 – 10.255.255.255
172.16.0.0 – 172.31.255.255
192.168.0.0 – 192.168.255.255

### 4. Run: ip ```addr show``` — identify which of your IPs are private.

These are the private ip's of my system::
- 192.168.1.14 --> Private IP used by my local WiFi network
- 172.17.0.1 --> Private IP used by Docker bridge network
- 127.0.0.1 --> Loopback IP (localhost)

![ip-addr-show]()

## Task 3: CIDR & Subnetting
### 1. What does /24 mean in 192.168.1.0/24?
- /24 is the subnet mask for the ip address.
- The IPv4 addr has 32 bits divided in 4 sections, each consisting 8bit. Now in that the number after '/' represents the number of bit's used for N/W addr and remaning are used for host.
- /24  means --> Total 32 - 24 = 8 --> $ 2^{8} $ = 256
- So we have 256 number of IP address avilable.
- Out of total number of IP 2 are reserved.
    - 1. First IP address for N/W ID.
    - 2. Last IP addr. used as broadcast address.

### 2. How many usable hosts in a /24? a /16? a /28?
- Usable hosts 
    - /24 is 32 - 24 = 8  --> $ 2^{8} $  = 256-2 = 254 Ip's
    - /16 is 32 - 16 = 16 --> $ 2^{16} $ = 65,536-2 = 65,534 Ip's
    - /28 is 32 - 28 = 4  --> $ 2^{4} $  = 16-2 = 14 Ip's

### 3. Explain in your own words: why do we subnet?
- Subnetting is used to divide a large network into smaller logical networks. It helps organize devices properly, improves network performance, reduces unnecessary traffic, and increases security by isolating different parts of the network.

### Quick exercise — fill in:

| CIDR | Subnet Mask	 |  Total IPs |  Usable Hosts |
|------|-----------------|------------|---------------|
| /24  | 255.255.255.0   |   256      |     254       |
| /16  | 255.255.0.0     |  65536     |    65534      |
| /28  | 255.255.255.240 |   16       |     14        |

---

## Task 4: Ports – The Doors to Services
### 1. What is a port? Why do we need them?
- A port is a logical communication endpoint used by applications and services on a computer. Ports help the system identify which service should receive incoming network traffic. For example, port 80 is used for HTTP and port 22 is used for SSH. Without ports, the computer would not know which application the data belongs to.   

### 2. Some common ports:

| Port | Service |
|------|---------|
| 22   | SSH     |
| 80   | http    |
| 443  | https   |
| 53   | DNS     |
| 3306 | MySQL   |
| 6379 | Redis   |
| 27017| MongoDB |

### 3. Run `ss -tulpn` — match at least 2 listening ports to their services


