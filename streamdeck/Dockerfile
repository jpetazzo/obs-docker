FROM debian:buster
RUN apt-get update
RUN apt-get install build-essential libgl1 libhidapi-hidraw0 libqt5widgets5 libudev-dev libusb-1.0-0-dev python3-pip v4l-utils -y
RUN pip3 install streamdeck_ui
RUN pip3 install obs-websocket-py
RUN pip3 install leglight
RUN pip3 install pyyaml

