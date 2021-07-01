gst-launch-1.0 -e -v udpsrc address=192.168.1.189 port=8080 ! application/x-rtp, payload=96 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
