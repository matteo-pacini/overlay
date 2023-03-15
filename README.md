# Zi0P4tch0 Gentoo Overlay

Welcome to the my personal Gentoo overlay! 🎉 This repository contains the following packages:

* `app-misc/1password-8.10.0`: The popular password manager 1Password 😊
* `games-util/mangohud-0.6.8`: A Vulkan and OpenGL overlay for monitoring FPS, temperatures, and more 🖥️
* `games-util/proton-ge-custom-bin-7.49`: Proton-GE (GloriousEggroll) custom build for better compatibility with certain games on Steam 🎮

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
sudo eselect repository add zi0p4tch0 git https://github.com/<your-username>/zi0p4tch0.git
```

Replace `<your-username>` with your actual GitHub username.

2. Sync the repository:

```sh
sudo emerge --sync zi0p4tch0
```
