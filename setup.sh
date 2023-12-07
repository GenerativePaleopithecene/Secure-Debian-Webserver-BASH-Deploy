#!/bin/bash

# Make sure you look through the script and change things to your needed settings.
# It works well on a fresh Debian server install.
# It uses many secure functions including setting up fail2ban and auditd
# The SSL hardening uses Diffie-Hellman change it if you need something different.
# Created by https://github.com/GenerativePaleopithecene
# Add what you need!
# Licensed under GPL3


# Ensure the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update and Upgrade the System
apt update && apt upgrade -y

# Install Nginx
apt install nginx -y

# Start and enable Nginx
systemctl start nginx
systemctl enable nginx

# Install Let's Encrypt client (certbot) and obtain an SSL certificate
apt install certbot python3-certbot-nginx -y
# Replace 'your_domain.com' with your actual domain name
certbot --nginx -d your_domain.com

# Harden SSL Configuration
# Create a strong Diffie-Hellman group
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Replace Nginx SSL configuration
cat > /etc/nginx/snippets/ssl-params.conf << EOF
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/ssl/certs/dhparam.pem;
ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384';
ssl_ecdh_curve secp384r1;
ssl_session_timeout  10m;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
EOF

# Apply the SSL configuration to Nginx
cat >> /etc/nginx/sites-available/default << EOF
server {
    listen 80;
    server_name your_domain.com;
    return 301 https://\$server_name\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your_domain.com;

    include snippets/ssl-params.conf;
    ssl_certificate /etc/letsencrypt/live/your_domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your_domain.com/privkey.pem;

    # Rest of your server block
}
EOF

# Restart Nginx to apply changes
systemctl restart nginx

# Harden SSH Configuration
sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config
sed -i 's/X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# Install and configure firewall (ufw)
apt install ufw -y
ufw default deny incoming
ufw default allow outgoing
ufw allow 2222/tcp    # SSH port
ufw allow 80/tcp      # HTTP
ufw allow 443/tcp     # HTTPS
ufw enable

# Install and configure Fail2Ban
apt install fail2ban -y
cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5

[sshd]
enabled = true
port = 2222
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 1d

[nginx-http-auth]
enabled = true

[nginx-botsearch]
enabled = true
EOF

systemctl restart fail2ban

# Install and configure Auditd for auditing system activities
apt install auditd -y

# Adding key audit rules (modify as needed for your environment)
cat > /etc/audit/rules.d/audit.rules << EOF
-w /var/log/nginx/ -k nginx_log
-w /etc/ssh/sshd_config -k sshd_config
-w /etc/nginx/nginx.conf -k nginx_conf
-w /etc/nginx/sites-available/ -k nginx_sites
EOF

systemctl restart auditd

echo "Web server setup completed."
