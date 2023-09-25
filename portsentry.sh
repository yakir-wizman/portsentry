#!/bin/bash

echo "############################################"
echo "#                                          #"
echo "#           Welcome to PortSentry          #"
echo "#   Automated Masscan and Nmap Scanning    #"
echo "#                                          #"
echo "############################################"

# Check if enough arguments are passed
if [ "$#" -lt 2 ]; then
    echo "Usage: ./PortSentry.sh <target_file_or_ip> <ports> [nmap_arguments]"
    exit 1
fi

# Define variables
TARGET=$1
PORTS=$2
shift 2  # Remove the first two arguments

# Remaining arguments are for Nmap
NMAP_ARGS="$@"

# Check if the target is a file or single IP
if [ -f $TARGET ]; then
    MASSCAN_TARGETS="-iL $TARGET"
    NMAP_TARGETS="-iL $TARGET"
else
    MASSCAN_TARGETS="$TARGET"
    NMAP_TARGETS="$TARGET"
fi

# Run Masscan and save output to a temporary file
masscan -p$PORTS $MASSCAN_TARGETS --rate=1000 -oG masscan_output.txt

# Parse Masscan output to extract open ports, sort them, and remove duplicates
awk '/Ports:/ {print $7}' masscan_output.txt | cut -d'/' -f 1 | sort -u | tr '\n' ',' | sed 's/,$//' > parsed_ports.txt

# Read parsed ports
PARSED_PORTS=$(cat parsed_ports.txt)

# Run Nmap scan with user-provided arguments except targets and ports
if [ ! -z "$PARSED_PORTS" ]; then
    echo "Running Nmap scan..."
    nmap -p $PARSED_PORTS $NMAP_ARGS $NMAP_TARGETS
else
    echo "No open ports found. Skipping Nmap scan."
fi

# Cleanup
rm masscan_output.txt parsed_ports.txt
