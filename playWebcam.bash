#!/usr/bin/env bash

# This script runs multiple gstreamer pipelines from all connected webcams to a
# remote linux system, all as a daemon.

# Handle SIGINT
cleanup() {
	echo "Closing all gst-streamer instances.."
	stty echo
	pkill -P $$
	exit 0
}

trap cleanup SIGINT


# Check number of arguments
if [[ $# -ne 1 ]]
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

	for i in {0..6..2}
	do
		camera="/dev/video${i}"
		port="808${i}"

		if [[ -e "$camera" ]]
		then
			echo "$camera exists, starting gst-launch-1.0 daemon on port ${port}..."
			gst-launch-1.0 v4l2src device=$camera ! image/jpeg,framerate=30/1,width=800,height=600 ! rtpjpegpay quality=100 ! udpsink host=$ip port=$port > /dev/null & 
		fi

	done
else
	echo "Could not ping $1. Exiting..."
	stty echo
	exit 1
fi

# Idle until SIGINT is raised
sleep infinity
