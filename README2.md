## README for Security Audit and Server Hardening Script

---

# Security Audit and Server Hardening Script

This Bash script automates the security audit and hardening process for Linux servers. It is designed to be modular and reusable, making it easy to deploy across multiple servers to ensure compliance with stringent security standards. The script checks for common security vulnerabilities, IPv4/IPv6 configurations, public vs. private IP identification, and implements server hardening practices.

## Features

### Security Audits

1. **User and Group Audits**:
   - Lists all users and groups with UID 0 (root privileges).
   - Reports any non-standard users with root privileges.
   - Checks for users without passwords or with weak passwords.

2. **File and Directory Permissions**:
   - Scans for files and directories with world-writable permissions.
   - Ensures `.ssh` directories have secure permissions.

3. **Service Audits**:
   - Lists all running services and checks for any unnecessary or unauthorized services.
   - Ensures critical services (e.g., `sshd`, `iptables`) are running and properly configured.
   - Checks that no services are listening on non-standard or insecure ports.

4. **Firewall and Network Security**:
   - Verifies that a firewall (e.g., `iptables`, `ufw`) is active and configured to block unauthorized access.
   - Reports any open ports and their associated services.
   - Reports any IP forwarding or other insecure network configurations.

5. **IP and Network Configuration Checks**:
   - Identifies whether the server's IP addresses are public or private.
   - Provides a summary of all IP addresses assigned to the server, specifying which are public and which are private.

6. **Security Updates and Patching**:
   - Checks for and reports any available security updates or patches.
   - Ensures that the server is configured to receive and install security updates regularly.

7. **Log Monitoring**:
   - Checks for any recent suspicious log entries that may indicate a security breach, such as failed login attempts on SSH.

### Server Hardening Steps

1. **SSH Configuration**:
   - Implements SSH key-based authentication and disables password-based login for root.
   - Ensures that SSH keys are adequately secured and managed.

2. **Disabling IPv6 (if not required)**:
   - Disables IPv6 if it is not in use, following best practices.
   - Updates services like SafeSquid to listen on the correct IPv4 addresses after disabling IPv6.

3. **Securing the Bootloader**:
   - Sets a password for the GRUB bootloader to prevent unauthorized access to boot parameters.

4. **Firewall Configuration**:
   - Implements recommended `iptables` rules and specific port allowances.

5. **Automatic Updates**:
   - Configures unattended upgrades to automatically apply security updates and remove unused packages.

### Custom Security Checks

- The script is modular and can be easily extended with custom security checks.
- A configuration file allows for the definition and management of custom checks.

### Reporting and Alerting

- The script generates a summary report of the security audit and hardening process, highlighting any issues that need attention.

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/security-audit-hardening.git
   cd security-audit-hardening
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x security_audit_hardening.sh
   ```

3. **Install Required Packages**:
   Ensure the following packages are installed on your system:
   - `awk`
   - `ss` or `netstat`
   - `iptables` or `ufw`
   - `unattended-upgrades` (for automatic updates)
   - `passwd`

   You can install them using your package manager:
   ```bash
   sudo apt-get install -y net-tools iptables ufw unattended-upgrades
   ```

## Usage

1. **Running the Script**:
   ```bash
   sudo ./security_audit_hardening.sh
   ```

2. **Reviewing the Report**:
   After the script completes, a summary report will be generated in the current directory:
   ```bash
   cat security_report.txt
   ```

3. **Custom Checks**:
   To add custom security checks, modify the `custom_checks.sh` file included in the repository. You can define your own checks based on your organization’s security policies.

## Configuration

The script uses a configuration file `config.cfg` where you can set various options:

- **SSH Configuration**:
  - `DISABLE_SSH_PASSWORD_AUTH`: Set to `yes` to disable password authentication for SSH.
  - `SSH_PORT`: Set the SSH port if it differs from the default `22`.

- **IPv6 Configuration**:
  - `DISABLE_IPV6`: Set to `yes` to disable IPv6.

- **Firewall Rules**:
  - You can define specific firewall rules in the `firewall_rules.sh` file.

## Example Outputs

### User and Group Audits

```bash
[INFO] Checking users with UID 0:
root:x:0:0:root:/root:/bin/bash
[WARNING] Non-standard root users found: customrootuser
```

### File and Directory Permissions

```bash
[INFO] Checking world-writable files:
-rwxrwxrwx 1 user user 1234 Aug 24 12:34 /tmp/world_writable_file
```

### Service Audits

```bash
[INFO] Checking running services:
[INFO] Critical service sshd is running.
[WARNING] Unauthorized service found: telnet
```

### IP and Network Configuration

```bash
[INFO] Checking IP addresses:
Public IP: 203.0.113.10
Private IP: 192.168.1.10
```https://github.com/yourusername/security-audit-hardening

## Modularity and CustomizationOA

This script is designed to be modular. You can easily extend or modify the script by adding new functions or updating existing ones. The script is well-commented to help you understand each part and make the necessary adjustments.

## Version Control

- **GitHub Repository**: [Link to the GitHub Repository](https://github.com/Rohit97241/Safesquid_assign.git)
- **Commits**: The repository is version-controlled, with well-documented commits that explain the changes made at each step.

## Conclusion

This script provides a comprehensive solution for automating security audits and server hardening on Linux servers. It is designed to be easy to use, customizable, and extendable to meet the specific needs of different server environment.
