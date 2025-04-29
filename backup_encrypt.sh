#!/bin/bash

# ============================
# Encrypted Backup Automation
# Author: Bora Noyan
# ============================

# Configuration
SOURCE="/etc"                   # Directory to backup (change if needed)
DEST="/home/username/backups"    # Where to save backups (change if needed)
PASSPHRASE="YourStrongPassphrase" # Change to a secure passphrase (or use GPG prompt)

# Create destination directory if it doesn't exist
mkdir -p "$DEST"

# Date format for backup file
DATE=$(date +%F)

# Backup filenames
FILENAME="backup-$DATE.tar.gz"
ENCRYPTED_FILENAME="$FILENAME.gpg"

# Create compressed archive
echo "[*] Creating backup archive..."
tar -czvf "$DEST/$FILENAME" "$SOURCE"

# Encrypt the archive
echo "[*] Encrypting the backup file..."
echo "$PASSPHRASE" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 "$DEST/$FILENAME"

# Remove the unencrypted archive
rm "$DEST/$FILENAME"

echo "[+] Backup and encryption completed: $DEST/$ENCRYPTED_FILENAME"
