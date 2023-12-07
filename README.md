# Secure-Debian-Webserver-BASH-Deploy


This script automates the process of setting up a secure web server with Nginx, SSL encryption, and enhanced security configurations on a Linux system. It is designed for use in the Free and Open Source Software (FOSS) community and is licensed under the GNU General Public License, version 3.0 (GPL-3.0).

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Key Reminders](#key-reminders)
- [SSL Configuration](#ssl-configuration)
- [Security Enhancements](#security-enhancements)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Description

This script simplifies the process of setting up a web server with the following components:

- Nginx web server.
- SSL encryption using Let's Encrypt.
- Enhanced security configurations, including SSH hardening, firewall setup (ufw), and Fail2Ban for intrusion prevention.

By using this script, you can quickly deploy a secure web server suitable for hosting websites, web applications, or other online stuff. It's also a good script to learn from if you are just starting out. 

## Features

- Automated installation and configuration of Nginx.
- Automatic SSL certificate generation using Let's Encrypt.
- SSL security hardening with recommended configurations.
- Enhanced SSH security settings.
- Firewall (ufw) configuration to allow only necessary ports.
- Fail2Ban setup for protection against brute force attacks.
- Auditd configuration for system activity auditing.



### Automated Installation and Configuration of Nginx

This script automates the installation and configuration of the Nginx web server. 

The script ensures that Nginx is installed with the necessary dependencies and sets up a basic configuration to get your web server up and running quickly. You can further customize Nginx settings according to your specific requirements by editing the Nginx configuration files located in `/etc/nginx/`. Currently, this configuration is set up to serve static html content. 

### Automatic SSL Certificate Generation using Let's Encrypt

Secure Socket Layer (SSL) certificates are essential for encrypting data transmitted between the web server and clients, ensuring the privacy and integrity of web communication. This script streamlines the process of obtaining SSL certificates using Let's Encrypt, a widely trusted certificate authority.

Let's Encrypt provides free SSL certificates, and this script automates the certificate issuance and renewal process. It configures Nginx to use these certificates for secure HTTPS connections. Your website will benefit from enhanced security and user trust without the need for manual certificate management.

### SSL Security Hardening with Recommended Configurations

The script implements recommended SSL security configurations to enhance the overall security of your web server. It includes best practices for TLS protocol versions and ciphers to ensure strong encryption and protection against known vulnerabilities.

By utilizing modern TLS versions (TLSv1.2 and TLSv1.3) and secure ciphers, your server will provide robust security for data in transit, guarding against potential attacks and ensuring compliance with contemporary security standards.

### Enhanced SSH Security Settings

Secure Shell (SSH) is a critical component of server administration, allowing secure remote access to your server. To bolster security, this script enhances SSH settings to mitigate common security risks:

- **Port Change:** The default SSH port is changed from the standard 22 to a custom port (e.g., 2222). This reduces the visibility of your SSH service and helps deter automated scanning for vulnerable SSH servers.
- **Root Login Disabled:** Direct root login is disabled, requiring users to log in as regular users and use sudo for administrative tasks. This mitigates the risk of brute-force attacks targeting the root account.

These measures strengthen the security of your server against unauthorized access and brute force attacks.

### Firewall (ufw) Configuration to Allow Only Necessary Ports

Uncomplicated Firewall (ufw) is used to configure the server's firewall rules, allowing you to control incoming and outgoing network traffic. The script configures ufw to allow only the essential ports for web services and SSH access, enhancing server security while minimizing attack surface:

- **SSH Port:** Only the custom SSH port (e.g., 2222) is open for SSH access.
- **HTTP and HTTPS Ports:** Ports 80 (HTTP) and 443 (HTTPS) are open to serve web content securely.
- **Additional Ports:** Additional ports can be opened as needed for specific services or applications.

This selective port configuration strengthens your server's defense against unauthorized access and network-based attacks.

### Fail2Ban Setup for Protection Against Brute Force Attacks

Fail2Ban is a powerful intrusion prevention tool that monitors server logs for repeated failed login attempts and automatically blocks IP addresses associated with suspicious activity. By implementing Fail2Ban, the script provides an additional layer of security against brute-force attacks on services like SSH.

Fail2Ban configuration includes parameters for defining the maximum number of login failures allowed within a specific timeframe, ban durations, and customized filters for different services. This dynamic protection mechanism helps safeguard your server from unauthorized access attempts.

### Auditd Configuration for System Activity Auditing

The script sets up the Audit Daemon (`auditd`) to perform system activity auditing. Auditd logs various system events and activities, allowing you to monitor and investigate potential security incidents.

Audit rules are defined in `/etc/audit/rules.d/audit.rules` to specify which events to log and how to handle them. By auditing system activities, you gain insights into user and process actions, aiding in security analysis and compliance with auditing requirements.

These comprehensive security features collectively ensure that your web server is well-protected and meets modern security standards. They are designed to minimize security risks and provide a robust defense against various threats commonly encountered in server environments.

## Getting Started

Follow these instructions to get it up and running on your local machine, vps, vm and bare metal server. Probably best to start with a fresh Debian minimal server install.

### Prerequisites

Before running this script, ensure that you have:

- A Linux-based operating system (e.g., Ubuntu, Debian).
- Root access to the server.
- A domain name pointed to your server's IP address.

### Installation

1. Clone the repository to your server:

   ```bash
   git clone https://github.com/GenerativePaleopithecene/Secure-Debian-Webserver-BASH-Deploy.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Secure-Debian-Webserver-BASH-Deploy
   ```

3. Makethe script executable:

   ```bash
   chmod +x setup.sh
   ```

4. Run the script as root:

   ```bash
   sudo ./setup.sh
   ```

## Usage

After running the script, your web server will be set up with Nginx, SSL encryption, and security configurations. You can now deploy your website or web application on the server.

### Key Reminders

- **Change Domain Name:** By default, the script is configured for the domain name `your_domain.com`. After running the script, update the Nginx configuration file located at `/etc/nginx/sites-available/default` to reflect your actual domain name.

- **Fresh Install:** For optimal results, it's recommended to use this script on a fresh installation of your chosen Linux distribution. Running it on a production server with existing configurations may lead to unexpected issues.

## SSL Configuration

The script automatically generates SSL certificates using Let's Encrypt. The SSL configuration can be found in the Nginx configuration file at `/etc/nginx/sites-available/default`.

You can further customize the SSL settings as needed.

## Security Enhancements

This script includes security enhancements, such as SSH hardening, firewall setup with ufw, and Fail2Ban for intrusion prevention. These measures help protect your server from common security threats.

## Contributing

If you would like to contribute to this project, please open an issue or submit a pull request on GitHub.

## License

This project is licensed under the GNU General Public License, version 3.0 (GPL-3.0) - see the [LICENSE](LICENSE) file for details.

## Contact
- [Karp](https://github.com/GenerativePaleopithecene/Secure-Debian-Webserver-BASH-Deploy))
- 
```

This revised README.md provides more detailed information and emphasizes key reminders such as changing the domain name and using the script on a fresh installation. Customize the sections as needed to provide comprehensive instructions and guidance for users of your script.
