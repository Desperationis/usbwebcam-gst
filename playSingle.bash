#!/usr/bin/env bash

# This script runs multiple gstreamer pipelines from all connected webcams to a
# remote linux system, all as a daemon. There is an option to ignore a specific 
# video feed.
#
# Usage: "bash playWebcam.bash target-IP [ignore]", where target-IP is the IP of the 
# computer you want to receive the video feed from and [ignore] is an optional integer
# that determines which video feed to ignore; A value of 1 would ignore /dev/video1.

# Handle SIGINT
cleanup() {
	echo "Closing all gst-streamer instances.."
	stty echo
	pkill -P $$
	exit 0
}

trap cleanup SIGINT


# Check number of arguments
if [[ $# -gt 2 ]]
then
	echo "Error: Illegal number of parameters. Please make sure you only input 1 IP address as the target destination."
	exit 1
fi

ip=$1

# Check IP address format
if ! [[ $ip =~ [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]]
then
	echo "Error: IP address is not in the correct format. Please use IPv4 addressing."
	exit 1
fi

stty -echo

# Test if target is reachable before running pipeline
if ping -W 3 -c 1 $ip > /dev/null 
then
	echo "Target exists, starting pipeline(s)..."

	i=$2
	camera="/dev/video${i}"
	port="808${i}"

	if [[ -e "$camera" ]] && [[ $i -ne $ignore ]]
	then
		echo "$camera exists, starting gst-launch-1.0 daemon on port ${port}..."
		if ! gst-launch-1.0 v4l2src device=$camera ! image/jpeg,framerate=30/1,width=800,height=600 ! rtpjpegpay quality=100 ! udpsink host=$ip port=$port > /dev/null 2>&1 & 
		then
			echo "Unable to start $camera. Skipping..."
		fi
	fi
else
	echo "Could not ping $1. Exiting..."
	stty echo
	exit 1
fi

# Idle until SIGINT is raised
sleep infinity
