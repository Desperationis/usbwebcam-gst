# usbwebcam-gst
Simple bash scripts for streaming MJPEG from USB webcam to remote computer with low-latency.

# Requirements
* Debian-based Linux
* `sudo apt-get install gstreamer1.0*`
* v4l2 loopback installed with gstreamer

# Running

There are 3 very important scripts in this repo. Run them in order.

## `getCamInfo.bash`
This is the most important script to run first; it lists all supported resolutions, framerates, and output types. Since we are streaming a M-JPEG compressed stream of video, only get the resolution and fps.

## `playWebcam.bash`
Plays a gst pipe that streams video from the usb-camera streaming to /dev/video0 to a UDP port. 

To run this script, simply input the ip of the DESTINATION computer and the port: `bash playWebcam.bash {target's ip} {port}`

## `receiveJpeg.bash`
Decodes M-JPEG encoded stream from UDP socket and displays it. Run this script on the target computer like so: `bash receiveJpeg.bash {target's ip} {port}`. Note: when I mean target IP in this context, I mean the computer's own IP.
