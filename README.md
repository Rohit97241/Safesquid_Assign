#!/bin/bash

# Function to display top 10 most CPU and memory consuming applications
top_apps() {
    echo "Top 10 Most CPU and Memory Consuming Applications:"
    ps aux --sort=-%cpu,-%mem | head -n 11
    echo ""
}

# Function to monitor network resources
network_monitor() {
    echo "Network Monitoring:"
    echo "Concurrent connections:"
    ss -tun | wc -l
    echo "Packet drops:"
    netstat -i | grep -vE 'Kernel|Iface' | awk '{print $1 "\t" $4 "\t" $8}'
    echo "Network traffic (MB in/out):"
    ifconfig | grep 'RX packets\|TX packets' | awk '{print $2}'
    echo ""
}

# Function to display disk usage by mounted partitions
disk_usage() {
    echo "Disk Usage:"
    df -h | awk '$5 >= 80 {print "\033[0;31m" $0 "\033[0m"; next} 1'
    echo ""
}

# Function to display system load and CPU usage
system_load() {
    echo "System Load:"
    uptime
    echo "CPU Usage Breakdown:"
    mpstat | awk '$12 ~ /[0-9.]+/ { print "User: " $3 "%, System: " $5 "%, Idle: " $12 "%" }'
    echo ""
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage:"
    free -m
    echo ""
}

# Function to monitor active processes
process_monitor() {
    echo "Process Monitoring:"
    echo "Number of active processes: $(ps aux | wc -l)"
    echo "Top 5 Processes by CPU and Memory:"
    ps aux --sort=-%cpu,-%mem | head -n 6
    echo ""
}

# Function to monitor essential services
service_monitor() {
    echo "Service Monitoring:"
    services=(sshd nginx apache2 iptables)
    for service in "${services[@]}"; do
        if systemctl is-active --quiet $service; then
            echo "$service is running"
        else
            echo "$service is not running"
        fi
    done
    echo ""
}

# Display help message
help_message() {
    echo "Usage: $0 [OPTION]"
    echo "Monitor system resources and present them in a dashboard format."
    echo ""
    echo "Options:"
    echo "  -a, --all          Display all system resources"
    echo "  -cpu               Display CPU and system load"
    echo "  -memory            Display memory usage"
    echo "  -network           Display network monitoring"
    echo "  -disk              Display disk usage"
    echo "  -process           Display process monitoring"
    echo "  -services          Display service monitoring"
    echo "  -help              Display this help message"
    echo ""
    exit 1
}

# Main program logic with command-line switches
case "$1" in
    -a|--all)
        top_apps
        network_monitor
        disk_usage
        system_load
        memory_usage
        process_monitor
        service_monitor
        ;;
    -cpu)
        system_load
        ;;
    -memory)
        memory_usage
        ;;
    -network)
        network_monitor
        ;;
    -disk)
        disk_usage
        ;;
    -process)
        process_monitor
        ;;
    -services)
        service_monitor
        ;;
    -help|*)
        help_message
        ;;
esac
