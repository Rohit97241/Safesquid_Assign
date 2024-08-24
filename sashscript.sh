#!/bin/bash

# Security Audit and Server Hardening Script
# Author: Your Name
# Date: 2024-08-24
# Description: This script performs security audits and hardens the server.

# Load configuration file
source config.cfg

# Function to check users with UID 0 (root privileges)
check_root_users() {
    echo "[INFO] Checking users with UID 0:"
    awk -F: '($3 == 0) { print $1 }' /etc/passwd
    echo ""
}

# Function to check for world-writable files
check_world_writable_files() {
    echo "[INFO] Checking world-writable files:"
    find / -perm -002 -type f -exec ls -ld {} \; 2>/dev/null
    echo ""
}

# Function to check running services
check_running_services() {
    echo "[INFO] Checking running services:"
    for service in "${CRITICAL_SERVICES[@]}"; do
        if systemctl is-active --quiet $service; then
            echo "[INFO] Critical service $service is running."
        else
            echo "[WARNING] Critical service $service is not running!"
        fi
    done
    echo ""
}

# Function to check open ports
check_open_ports() {
    echo "[INFO] Checking open ports:"
    ss -tuln | awk 'NR>1 {print $1, $4}' | while read -r line; do
        echo "[INFO] $line"
    done
    echo ""
}

# Function to disable IPv6 if required
disable_ipv6() {
    if [ "$DISABLE_IPV6" == "yes" ]; then
        echo "[INFO] Disabling IPv6..."
        sysctl -w net.ipv6.conf.all.disable_ipv6=1
        sysctl -w net.ipv6.conf.default.disable_ipv6=1
        echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
        echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
    fi
    echo ""
}

# Function to configure firewall
configure_firewall() {
    echo "[INFO] Configuring firewall..."
    bash firewall_rules.sh
    echo ""
}

# Function to check for security updates
check_security_updates() {
    echo "[INFO] Checking for security updates..."
    apt-get update && apt-get -s upgrade | grep -i security
    echo ""
}

# Function to check for suspicious logs
check_suspicious_logs() {
    echo "[INFO] Checking for suspicious log entries..."
    grep "Failed password" /var/log/auth.log | tail -n 10
    echo ""
}

# Function to generate the report
generate_report() {
    echo "[INFO] Generating report..."
    {
        check_root_users
        check_world_writable_files
        check_running_services
        check_open_ports
        disable_ipv6
        configure_firewall
        check_security_updates
        check_suspicious_logs
    } > security_report.txt
    echo "[INFO] Report generated: security_report.txt"
}

# Main
generate_report

