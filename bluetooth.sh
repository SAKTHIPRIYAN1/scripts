#!/bin/bash

status=$(systemctl is-active bluetooth.service)

echo "The previous status is" $status
act="active"

if [ $status != $act ];
then
	#enable bluetooth...
	systemctl start bluetooth.service

	#starting manager...
	blueman-manager

	echo "bluetooth started..."
else
	systemctl stop bluetooth.service
	echo "blutooth stopped..."
fi




