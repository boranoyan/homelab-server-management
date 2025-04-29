#!/bin/bash

# ============================
# Encrypted Backup Automation (Secure Double-Confirm Version)
# Author: Bora Noyan
# ============================

# Configuration
SOURCE="/etc"                   # Directory to backup (change if needed)
DEST="/home/username/backups"    # Where to save backups (change if needed)

# Create destination directory if it doesn't exist
mkdir -p "$DEST"

# Date format for backup file
DATE=$(date +%F)

# Backup filenames
FILENAME="backup-$DATE.tar.gz"
ENCRYPTED_FILENAME="$FILENAME.gpg"

# Prompt for passphrase twice
echo "[*] Please enter a passphrase to encrypt the backup:"
read -s PASSPHRASE1
echo "[*] Please re-enter the passphrase for confirmation:"
read -s PASSPHRASE2

# Check if passphrases match
if [ "$PASSPHRASE1" != "$PASSPHRASE2" ]; then
  echo "[!] Passphrases do not match. Exiting without creating backup."
  exit 1
fi

# Create compressed archive
echo "[*] Creating backup archive..."
tar -czvf "$DEST/$FILENAME" "$SOURCE"

# Encrypt the archive
echo "$PASSPHRASE1" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 "$DEST/$FILENAME"

# Remove the unencrypted archive
rm "$DEST/$FILENAME"

echo "[+] Backup and encryption completed successfully: $DEST/$ENCRYPTED_FILENAME"
