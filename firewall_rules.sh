#!/bin/bash

# Firewall Rules for Security Audit and Hardening Script

# Flush existing rules
iptables -F

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH on specified port
iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT

# Allow other necessary services here
# Example: Allow HTTP and HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Log dropped packets (optional)
iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: "

# Save the rules
iptables-save > /etc/iptables/rules.v4

