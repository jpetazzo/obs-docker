# OBS Docker

**⚠️WARNING⚠️**

**This is not intended to be an "easy" way to run OBS Studio.
If you're new to OBS, Linux, or Docker, DO NOT USE THIS.
Use your distriution's OBS package instead, I guarantee
that it will be much, much easier.**

That being said ...


## What is this?

This repository holds a Compose file, a few Dockerfiles, as well
as various scripts (shell and Python) to use [OBS Studio] in
containers. Features include:

- Upstream OBS Studio (because it has NVENC support)
- Elgato Stream Deck support to switch scenes, turn lights on
  and off, start countdowns (e.g. "Let's have a 5 min break"),
  change webcam parameters;
- V4L2 output plugin, so that OBS Studio shows up as a virtual
  webcam usable in any application like Zoom, Skype, etc.;
- WebSocket plugin (to control OBS from the Stream Deck or
  from anything else);
- gphoto2 + ffmpeg pipeline to use some compatible DSLR as
  a webcam.


## Why?

Half of these components can be installed very easily on
most distros (I did ArchLinux, Debian, Ubuntu). The other half
(in particular the OBS plugins) required manual compilation,
or requires to run scripts in the background (e.g. the countdown
generator).

I had initially set up OBS Studio on my ArchLinux machine.
Then I decided to move it to another machine with faster CPU
and GPU, but that machine was running Debian. Instead of
redoing the work for Debian, I decided to put everything
in containers.

Some parts are annoying (see "caveats" below),
but the trade-offs work for me.


## Caveats

Things that don't work or could be better ...

- Hotplugging devices (webcams or Stream Deck)
  requires to restart their respective containers
  (solution: bind-mount `/dev` to the container?)
- Suspend / resume generally requires to restart
  containers (probably because of the previous point)
- Some work is still needed on the host
  (V4L2 loopback module install; udev rules for
  Stream Deck)
- Add ffmpeg multi-stream encoder (I currently
  run it directly on the host because reasons)
- Make sure that the OBS Dockerfile works correctly
  both with and without NVIDIA GPU


## How to use this

1. Install or compile v4l2loopback kernel module (perhaps via v4l2loopback-dkms).
2. Install udev rules for Stream Deck (check the [streamdeck_ui page]
   for details).
3. `docker-compose up`.
   (It will tells you to export an environment variable, do it and try again.)


## Details

All the containers run in privileged mode (so that they have
access to all devices). Most processes will be started with `su`
though, but if you're not comfortable with that, do not use this
project.

Most containers will share their network through the `networksandbox`
container, so that they can communicate over `localhost` (e.g.
so that the Stream Deck UI can send commands to OBS using WebSockets).

Some containers are not strictly necessary (e.g. `tuning` and `alsaloopback`)
and they will probably be removed or adapted in future versions.

The `bin` directory contains a bunch of scripts that are mounted in
the `streamdeck` container so that they can be used in Stream Deck
actions. These scripts include the countdown scripts and the script
to control the Elgato Key Lights.

The `data` directory contains YAML files to configure the lights,
and the files for the countdown script.

There are multiple Dockerfiles for `obs` because I tried different
approaches. I tried Debian, but the Debian packages do not support
NVENC (NVIDIA GPU-accelerated encoding). I tried Nix but I wasn't
able to figure out how to compile the plugins. Ubuntu eventually
worked. The `obs` container currently copies NVIDIA userland
libraries from the host. This is required, because NVIDIA userland
libraries have to match the exact kernel driver that you're using,
so it's impossible to just ship them in the container. In the
immortal words of the asshole in chief, "Fuck you, NVIDIA".
I am aware that there is a thing called "NVIDIA Docker" that is
supposed to help with that, but after witnessing the chaos and
havoc caused by the NVIDIA drivers themselves on this machine,
I decided to not push my luck too far.


[OBS Studio]: https://obsproject.com/
[streamdeck_ui]: https://timothycrosley.github.io/streamdeck-ui/#linux-quick-start
