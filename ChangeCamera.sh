# this is the Script to Change the Primary Camera in My system from in-built camera to external camera..

# list Devices...
v4l2-ctl --list-devices

# Get the device name matching 'C720' and extract its corresponding /dev/videoX device
DEVICE=$(v4l2-ctl --list-devices | grep -A 1 'C270' | tail -n 1 | tr -d '\t')

# Check if a device was found
if [[ -n "$DEVICE" ]]; then
    echo "C270 Webcam found at: $DEVICE"
    echo "Changing The /dev/video0 to C270 ..."
    
    # Change the Primary Camera...
     sudo mv /dev/video0 /dev/videoOld
     sudo mv $DEVICE /dev/video0

else
    echo "C270 Webcam not found!"
    exit 1
fi
