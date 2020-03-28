# OBS Docker

Compose file + Dockerfiles to start all these things in containers:

- OBS Studio
- V4L2 output plugin
- WebSocket remote control plugin
- Elgato Stream Deck UI
- gphoto2 + ffmpeg pipeline (to use compatible DSLR as webcam)

Stuff that is NOT containerized, and that you MUST do first:

- Compile v4l2loopback kernel module (perhaps via v4l2loopback-dkms)
- Install udev rules for Stream Deck (look for streamdeck_ui on GitHub)

More doc to come later.
