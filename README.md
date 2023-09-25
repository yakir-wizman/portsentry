# PortSentry

## Overview
`PortSentry` is an automated tool designed for security researchers and network administrators. It performs an initial fast scan using Masscan to find open ports and follows it up with a detailed Nmap scan.

## Features
- Fast initial port scanning with Masscan
- Detailed secondary scanning with Nmap
- Supports single IP, multiple IPs, or a list from a file
- Easy to use and fully automated
- Supports additional Nmap arguments

## Requirements
- Masscan
- Nmap

## Installation

1. Clone this repository or download the `PortSentry.sh` script.
2. Make the script executable:

    ```bash
    chmod +x PortSentry.sh
    ```

## Usage

You can run the script with the following command:

```bash
./PortSentry.sh <target_file_or_ip> <ports> [nmap_arguments]
```

### Parameters

- `<target_file_or_ip>`: A single IP address or a file containing a list of IP addresses.
- `<ports>`: Ports to be scanned. Can be a single port (e.g., 80), multiple ports separated by commas (e.g., 80,443), or a range (e.g., 0-65535).
- `[nmap_arguments]`: (Optional) Additional Nmap arguments like `-sV`, `-O`, etc.

### Examples

- To scan a single IP with specific ports and no additional Nmap arguments:

    ```bash
    ./PortSentry.sh 192.168.1.1 80,443
    ```

- To scan multiple IPs from a file with all ports and additional Nmap arguments:

    ```bash
    ./PortSentry.sh targets.txt 0-65535 -sV -O
    ```

## Legal Disclaimer

This tool is intended for security researchers and network administrators. By using this tool, you agree that you have permission from the network owner to perform scanning. Unauthorized scanning is illegal.
