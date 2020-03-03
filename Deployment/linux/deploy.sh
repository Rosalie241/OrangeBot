#!/usr/bin/env bash
#
# This script deploys OrangeBot to my raspberry pi 3b+
#
set -e

TARGET_USER=orangebot
TARGET_ADDR=192.168.2.199

OUT_DIR="$(pwd)/out"

rm -rf "$OUT_DIR"

dotnet publish OrangeBot/OrangeBot.csproj \
    -c Release \
    -r linux-arm \
    -o "$OUT_DIR"

# Stop service
ssh -t "$TARGET_USER@$TARGET_ADDR" 'sudo systemctl stop OrangeBot@*.service'

# Copy build result to target
scp -r out/* "$TARGET_USER@$TARGET_ADDR:./"

# Start service
ssh -t "$TARGET_USER@$TARGET_ADDR" 'sudo systemctl start OrangeBot@*.service'
