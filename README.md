### README for System Resource Monitoring Script

---

# System Resource Monitoring Script

This script is designed to monitor various system resources on a proxy server and display them in a dashboard format. It provides real-time updates every few seconds and allows users to view specific parts of the dashboard individually using command-line switches.

## Features

- **Top 10 Most Used Applications**: Displays the top 10 applications consuming the most CPU and memory.
- **Network Monitoring**:
  - Number of concurrent connections to the server.
  - Packet drops.
  - Network traffic in/out (MB).
- **Disk Usage**: Shows the disk space usage by mounted partitions, highlighting those using more than 80% of the space.
- **System Load**: Displays the current system load and a breakdown of CPU usage.
- **Memory Usage**: Shows total, used, and free memory, along with swap memory usage.
- **Process Monitoring**: Displays the number of active processes and the top 5 processes by CPU and memory usage.
- **Service Monitoring**: Monitors the status of essential services like `sshd`, `nginx/apache`, `iptables`, etc.
- **Custom Dashboard**: Allows users to view specific parts of the dashboard using command-line switches.

## Prerequisites

Ensure that the following utilities are installed on your system:

- `ps`
- `ss` (or `netstat` for older systems)
- `df`
- `mpstat`
- `free`
- `awk`
- `systemctl` (for service monitoring)

## Usage

### Running the Script

1. Make the script executable:
   ```bash
   chmod +x monitor.sh
   ```

2. To run the script and display all system resources:
   ```bash
   ./monitor.sh -a
   ```

3. To refresh the dashboard every few seconds, use a loop:
   ```bash
   watch -n 5 ./monitor.sh -a
   ```
   This will update the dashboard every 5 seconds.

### Viewing Specific Parts of the Dashboard

You can view individual sections of the dashboard by using specific command-line switches:

- **CPU and System Load**:
  ```bash
  ./monitor.sh -cpu
  ```
  Example Output:
  ```
  System Load:
   15:10:12 up 2 days,  3:45,  2 users,  load average: 0.10, 0.14, 0.13
  CPU Usage Breakdown:
   User: 5.0%, System: 2.0%, Idle: 93.0%
  ```

- **Memory Usage**:
  ```bash
  ./monitor.sh -memory
  ```
  Example Output:
  ```
  Memory Usage:
               total        used        free      shared  buff/cache   available
  Mem:         32042        5419       20315          58        6307       25832
  Swap:        16384          29       16355
  ```

- **Network Monitoring**:
  ```bash
  ./monitor.sh -network
  ```
  Example Output:
  ```
  Network Monitoring:
  Concurrent connections: 56
  Packet drops:
  eth0    Packet drops: 0
  lo      Packet drops: 0
  Network traffic (MB in/out):
  RX bytes: 4896176 (4.8 MB)  TX bytes: 672975 (672 KB)
  ```

- **Disk Usage**:
  ```bash
  ./monitor.sh -disk
  ```
  Example Output:
  ```
  Disk Usage:
  Filesystem      Size  Used Avail Use% Mounted on
  /dev/sda1        50G   40G  10G  80% /
  /dev/sda2        50G   30G  20G  60% /home
  ```

- **Process Monitoring**:
  ```bash
  ./monitor.sh -process
  ```
  Example Output:
  ```
  Process Monitoring:
  Number of active processes: 187
  Top 5 Processes by CPU and Memory:
  USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
  root      1234  0.5  1.0 500000 50000 ?        S    10:00   0:05 /usr/bin/myapp
  ```

- **Service Monitoring**:
  ```bash
  ./monitor.sh -services
  ```
  Example Output:
  ```
  Service Monitoring:
  sshd is running
  nginx is running
  apache2 is not running
  iptables is running
  ```

### Extending the Script

The script can be customized and extended to monitor additional services or resources. To add more services to monitor, modify the `services` array in the `service_monitor` function:

```bash
services=(sshd nginx apache2 iptables mycustomservice)
```

## Performance and Efficiency

The script is designed to efficiently retrieve and display system metrics using lightweight commands and filtering. For real-time monitoring, the `watch` command is recommended, which minimizes the load on the system while providing timely updates.

## Conclusion

This Bash script provides a comprehensive monitoring solution for system resources on a proxy server. It offers flexibility in viewing different parts of the dashboard and can be easily extended to meet additional requirements.
