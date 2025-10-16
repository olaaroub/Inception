#!/bin/bash
set -e

# Create FTP user if it doesn't exist
# -d: Set home directory to WordPress files
# -s: Set shell (we use /bin/false because FTP-only, no SSH)
if ! id "$FTP_USER" &>/dev/null; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

    # Add user to the allowed users list
    echo "$FTP_USER" > /etc/vsftpd.userlist

    echo "FTP user created successfully"
else
    echo "FTP user already exists"
fi

# Ensure correct permissions on WordPress directory
chown -R "$FTP_USER:$FTP_USER" /var/www/html

echo "Starting vsftpd..."
exec "$@"
