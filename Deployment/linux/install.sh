#!/usr/bin/env bash
set -e

CONFIG_DIR=/etc/OrangeBot
INSTALL_DIR=/opt/OrangeBot
INSTALL_USR=orangebot
INSTALL_BIN=/usr/local/bin
INSTALL_SRV=/lib/systemd/system/OrangeBot@.service

if [ "$UID" != "0" ]
then
    echo "this script required root!"
    exit 1
fi

# return when sourced
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && return

if [ -d "$INSTALL_DIR" ]
then
    echo "already installed, run uninstall.sh to uninstall"
    exit 1
fi

script_dir=$(realpath "$(dirname "$0")")

#
# Create orangebot user (with login because scp)
#
useradd -m -d "$INSTALL_DIR" "$INSTALL_USR"

# Generate password
password=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 40)

# Change password for $INSTALL_USR
echo "$INSTALL_USR:$password" | chpasswd
echo "$INSTALL_USR: password=$password"

#
# Install
#

# Install service
install "$script_dir/files/OrangeBot@.service"     "$INSTALL_SRV"

# Configure service
sed -i "s|@DEPLOY_LOCATION@|$INSTALL_DIR|g" "$INSTALL_SRV"
sed -i "s|@CONFIG_LOCATION@|$CONFIG_DIR|g"  "$INSTALL_SRV"

# Create config dir
mkdir -p "$CONFIG_DIR"

echo "Completed, put the config files in $CONFIG_DIR"
echo "Optionally add this line to /etc/sudoers:"
echo "$INSTALL_USR ALL=(ALL) NOPASSWD: $(which systemctl) stop OrangeBot@*.service,$(which systemctl) start OrangeBot@*.service"
