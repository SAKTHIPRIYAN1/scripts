#!/bin/bash

# Script to change the primary camera

echo "Available camera devices:"
echo "-------------------------"
v4l2-ctl --list-devices
echo "-------------------------"

# Ask user for camera device
read -p "Enter the video device you want to make primary (e.g. /dev/video2): " DEVICE

# Validate input
if [[ ! "$DEVICE" =~ ^/dev/video[0-9]+$ ]]; then
    echo "Invalid input. Please enter a device like /dev/video2"
    exit 1
fi

# Check if device exists
if [[ ! -e "$DEVICE" ]]; then
    echo "Device $DEVICE not found!"
    exit 1
fi

echo
echo "Selected camera: $DEVICE"
echo "Changing primary camera..."

# Backup current video0
sudo mv /dev/video0 /dev/videoOld

# Move selected camera to video0
sudo mv "$DEVICE" /dev/video0

echo "Camera changed successfully!"
echo
echo "Current devices:"
v4l2-ctl --list-devices
