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

## `playWebcam.bash {target ip}`
Plays a gst pipe that streams video from all connected cameras via UDP on ports 8080, 8082, 8084, and 8086.

To run this script, simply input the ip of the DESTINATION computer: `bash playWebcam.bash {target's ip}`

## `receiveJpeg.bash`
Decodes M-JPEG encoded stream from UDP socket and displays it. Run this script on the target computer like so: `bash receiveJpeg.bash`. With this, it will automatically run receivers on all the ports mentioned previously.
