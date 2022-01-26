# Zephyr Build System Within Docker
This repository includes a docker setup for building [Zephyr](https://github.com/zephyrproject-rtos/zephyr) based projects.
It's based on Ubuntu 20.04 and lighter than the (semi-)official image.
Mainly because it only installs the SDK-included toolschains doens't run an X.org or VNC server.

## Create a Project
To create a new project, start the container:

```bash
host> docker-compose run builder bash
```

You now have a shell inside the build environment. 
The folder `workspaces` within the container is shared with the host.

To create a new project use `west` within the container:

```bash
container> cd workspaces
container> west init myproject
container> cd myproject
container> west update
container> west zephyr-export
```
On the host-side you'll probably have to align the permissions, e.g. with:

```bash
host> sudo chown $(whoami): -R zerphyr_workspaces/myproject
```

Now you can edit the files in your project on you host machine.
Building can then be done in the container.

## Build Example
To build, for example, the blinky sample for the [Giant Gecko board](https://www.silabs.com/documents/public/user-guides/ug287-stk3701.pdf), do a:

```bash
container> cd myproject/zephyr/
container> west build -p auto -b efm32gg_stk3701a samples/basic/blinky
```

On the host you can now flash `zephyr_workspaces/myproject/zephyr/build/zephyr/zephyr.bin` onto the board.
