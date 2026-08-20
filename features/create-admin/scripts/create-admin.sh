#!/usr/bin/env bash

set -euo pipefail

USERNAME="admin"
PASSWORD="admin"

# Create the account if it doesn't already exist
if ! id "$USERNAME" &>/dev/null; then
    useradd \
        --create-home \
        --shell /bin/bash \
        "$USERNAME"
fi

# Set the development password
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Grant administrative privileges
usermod -aG wheel "$USERNAME"

# Make sure the home directory has the correct ownership
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME"

# Restore SELinux labels
restorecon -RF "/home/$USERNAME" || true