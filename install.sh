#!/bin/bash

# ===============================================================
#          Arch Linux on WSL - Initialization Script
#
# This script will:
# 1. Initialize pacman and update the system.
# 2. Set timezone to Asia/Shanghai and locale to en_US.UTF-8.
# 3. Install essential packages like sudo, git, and base-devel.
# 4. Prompt for a new username, create it, and grant sudo access.
# 5. Configure WSL to use systemd for better service management.
#
# ===============================================================

# --- Script Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e

# --- Hardcoded System Defaults ---
TIMEZONE="Asia/Shanghai"
PRIMARY_LOCALE="zh_CN.UTF-8"
FALLBACK_LOCALE="en_US.UTF-8"
HOSTNAME="archlinux"

# --- Main Script Body ---

echo "========================================="
echo "  Arch Linux on WSL Initial Setup"
echo "========================================="
echo

# --- Step 0: Get User Input ---
# Loop until a non-empty username is provided.
while [ -z "$USERNAME" ]; do
  read -p "Please enter the username for the new user: " USERNAME
  if [ -z "$USERNAME" ]; then
    echo "Username cannot be empty. Please try again."
  fi
done
echo "User '$USERNAME' will be created."
echo

# --- Step 1: Pacman and System Update ---
echo ">>> [1/6] Initializing Pacman keyring and updating the system..."
pacman-key --init
pacman-key --populate archlinux
pacman -Syu --noconfirm
echo "System update complete."
echo

# --- Step 2: System Configuration (Timezone, Locale, Hostname) ---
echo ">>> [2/6] Configuring system timezone, locale, and hostname..."
# Set Timezone
ln -sf "/usr/share/zoneinfo/${TIMEZONE}" /etc/localtime

# Set Locale
echo "${PRIMARY_LOCALE} UTF-8" > /etc/locale.gen
echo "${FALLBACK_LOCALE} UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=${PRIMARY_LOCALE}" > /etc/locale.conf

# Set Hostname
echo "$HOSTNAME" > /etc/hostname
echo "System configured."
echo

# --- Step 3: Install Essential Packages ---
echo ">>> [3/6] Installing essential packages (sudo, git, neovim...)"
# --needed prevents re-installing packages that are already up-to-date.
pacman -S --noconfirm --needed sudo git neovim
echo "Packages installed."
echo

# --- Step 4: Create User and Configure Sudo ---
echo ">>> [4/6] Creating user '$USERNAME' and configuring sudo access..."
# Create the user with a home directory (-m), add to wheel group (-G)
useradd -m -G wheel -s /bin/bash "$USERNAME"

# Prompt to set the password for the new user
echo "Please set a password for the new user '$USERNAME':"
passwd "$USERNAME"

# Grant sudo access to the 'wheel' group by uncommenting the line in sudoers
# This is a safe way to do it programmatically.
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
echo "User '$USERNAME' created and granted sudo rights."
echo

# --- Step 5: Configure WSL for Systemd ---
echo ">>> [5/6] Enabling systemd for WSL..."
# This allows services like Docker or sshd to run correctly.
cat <<EOF > /etc/wsl.conf
[boot]
systemd=true

[user]
default=$USERNAME
EOF
echo "WSL configuration for systemd created."
echo

# --- Step 6: Final Instructions ---
echo ">>> [6/6] Finalizing..."
echo
echo "================================================================="
echo "✅  Arch WSL initialization is complete!"
echo "-----------------------------------------------------------------"
echo "‼️  IMPORTANT: You must now perform the following actions:"
echo
echo "   1. Close this Arch Linux window."
echo "   2. Open PowerShell or CMD and run this command to shut down WSL:"
echo "      wsl --shutdown"
echo
echo "   3. Restart Arch Linux. You will be logged in as '$USERNAME'."
echo
echo "================================================================="