# Encrypted Backup Automation Script

This project automates backing up a selected directory and encrypting it with GPG AES-256 encryption on a Linux server.

## 🛠️ Features
- Compresses a specified source directory into a `.tar.gz` archive.
- Encrypts the archive using strong AES-256 symmetric encryption.
- Deletes unencrypted archives after encryption for security.
- Easy to schedule with `cron` for daily or weekly backups.

## 🚀 Usage

1. **Edit the Script**  
   Update these variables inside `backup_encrypt.sh`:
   - `SOURCE`: Directory you want to back up.
   - `DEST`: Destination folder for storing backups.
   - `PASSPHRASE`: Your encryption passphrase (or modify to prompt for passphrase).

2. **Make the Script Executable**
   ```bash
   chmod +x backup_encrypt.sh
