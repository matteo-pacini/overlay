# Zi0P4tch0 Gentoo Overlay

Welcome to the my personal Gentoo overlay! 🎉 This repository contains the following packages:

* `app-misc/1password`: The popular password manager 1Password 😊
* `games-util/mangohud`: A Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more.

Follow the instructions below to install the repository via `eselect-repository`.

## Prerequisites

Before we begin, you will need `eselect-repository` to manage your overlay repositories. If you don't have it installed already, follow these steps:

1. Update the portage tree:

```sh
sudo emerge --sync
```

2. Install the `eselect-repository` package:

```sh
sudo emerge -av app-eselect/eselect-repository
```

## Adding the Repository

Follow these steps to add the Zi0P4tch0 Gentoo overlay to your system:

1. Add the repository using `eselect-repository`:

```sh
sudo eselect repository add zi0p4tch0 git https://github.com/Zi0P4tch0/overlay.git
```

2. Sync the repository:

```sh
sudo emerge --sync zi0p4tch0
```
