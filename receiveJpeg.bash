ip=$(hostname -I | cut -d " " -f 1)

gst-launch-1.0 -e -v udpsrc address=$ip port=8081 ! application/x-rtp, payload=96 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
