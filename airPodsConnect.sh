#!/bin/bash

set -e

echo "=== Updating package lists ==="
sudo apt update

echo "=== Reinstalling Bluetooth packages ==="
sudo apt install --reinstall bluez bluetooth pulseaudio-module-bluetooth -y

echo "=== Restarting Bluetooth service ==="
sudo systemctl restart bluetooth

echo "=== Restarting audio services ==="
systemctl --user restart pipewire pipewire-pulse wireplumber 2>/dev/null || true
pulseaudio -k 2>/dev/null || true

echo
echo "========================================="
echo "Put your AirPods in pairing mode now:"
echo "1. Put AirPods in the case"
echo "2. Open the lid"
echo "3. Hold the back button until LED blinks white"
echo "========================================="
echo

read -p "Press Enter when ready..."

echo
echo "Scanning for Bluetooth devices for 15 seconds..."
timeout 15 bluetoothctl scan on >/dev/null 2>&1 || true

echo
echo "Discovered devices:"
bluetoothctl devices

echo
read -p "Enter MAC address to pair: " MAC

echo
echo "Pairing with $MAC ..."

bluetoothctl <<EOF
power on
agent on
default-agent
pair $MAC
trust $MAC
connect $MAC
exit
EOF

echo
echo "=== Device Info ==="
bluetoothctl info "$MAC"

echo
echo "Done."
