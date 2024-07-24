#!/bin/bash

echo "this is to change default camera.."
echo " check the available options"

echo ""
v4l2-ctl --list-devices
echo ""

echo " here all time webcam C270 is at /dev/video1"
echo "changing default /dev/video0 as /dev/video1 (link) "

echo ""

#removing default (already)...
sudo rm /dev/video0

#changinfg link...
#
# soft link ...
#
 ln -s /dev/video1 /dev/video0

 echo "check if link is crt (see the link points to video1 (ls -l /dev/video0)) "

 #checking....
 ls -l /dev/video0
