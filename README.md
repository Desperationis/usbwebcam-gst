# gst-webcam
Simple bash scripts for streaming MJPEG from USB webcam to remote computer with low-latency.

# Requirements
* Debian-based Linux
* `sudo apt-get install gstreamer1.0*`
* v4l2 loopback installed with gstreamer

# Running

There are 3 very important scripts in this repo. Run them in order.

## `getCamInfo.bash {camera}`
This is the most important script to run first; it lists all supported resolutions, framerates, and output types. If by chance playWebcam.bash lists the incorrect resolution and protocol, this is where you'd look to see what it supported. `{camera}` is a number that represents the /dev/video file, where any number such as 0 corresponds do /dev/video0.

## `playWebcam.bash {target ip} {ignore}`
Plays a gst pipe that streams video from all connected cameras via UDP on ports 8080-8089. 

To run this script, simply input the ip of the DESTINATION computer: `bash playWebcam.bash {target's ip} {ignore}`. `ignore` is an optional integer that will ignore a certain v4l2 video file; A value of 2 would ignore /dev/video2. This is useful in the case a camera is currently in use.

## `receiveJpeg.bash`
Decodes UDP M-JPEG encoded streams from ports 8080-8089 and displays it. Run this script on the target computer like so: `bash receiveJpeg.bash`. 
