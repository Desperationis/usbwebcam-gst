gst-launch-1.0 -e -v udpsrc address=${1} port=${2} ! application/x-rtp, payload=96 ! rtpjpegdepay ! jpegdec ! autovideosink sync=false
