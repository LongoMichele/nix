# ❄️ My NixOS configuration ❄️

## 📖 Table of Contents

- [Installation](#⚙️-installation)
- [Hosts](#🖥️-hosts)
- [Users](#👤-users)
- [To-Do Checklist](#✅-to-do-checklist)
- [Notes](#📝-notes)

## ⚙️ Installation

1.  Enable the experimental features nix-command and flakes
    ```bash
    export NIX_CONFIG="experimental-features = nix-command flakes"
    ```
2.  Run the `install.sh` script\
    The script will install `home-manager` and generate a new `hardware-configuration.nix` file.
3.  Rebuild the OS and the user environment
    ```bash
    sudo nixos-rebuild switch --flake .#[host]
    home-manager switch --flake .#[user]
    ```

### 🖥️ Hosts

This section lists the specific configurations for each NixOS host.

- **Fly**: is a lightweight machine that isn’t super powerful but is perfect for development. Great for quickly testing ideas without the overhead of a full setup.

- **Tower 🛠️ (WIP)**: is a more powerful machine. It packs a punch and is perfect for development as well as gaming.

### 👤 Users

This section includes the specific configurations for users.

- **Michele**: the go-to user for day-to-day tasks, handling everything from work to personal projects.

- **Player 🛠️ (WIP)**: the dedicated gaming user, set up for an optimal gaming experience.

## ✅ To-Do Checklist

Since I tend to forget things, here’s a list of tasks. Some might seem trivial, but I’m writing them down to avoid forgetting!

- 🖥️ **System Setup**

  - 🔊 **Audio & Display**
    - [x] Make sound work (including control keys)
    - [x] Add brightness controls
    - [x] Add bluetooth control packages and UI tool
    - [x] Add notification manager
  - 🔋 **Power Management**
    - [ ] Add battery management
    - [x] Add brightness and power management indicators to Waybar
  - ⚙️ **Boot & User Accounts**
    - [x] Update bootloader configuration
    - [ ] Add second user and configure host
  - 🔒 **Security & Access**
    - [x] Polkit setup
    - [x] Lock screen

- 🎨 **Interface & Display**

  - 🖼️ **Display Manager**
    - [x] Install and configure display manager
    - [ ] Add option to choose between GDM or SDDM
    - [ ] Customize GDM
    - [ ] Add option to choose SDDM theme
  - 🎭 **Themes & Appearance**
    - [x] Customize Firefox theme ([Textfox](https://github.com/adriankarlen/textfox))
    - [x] Update rofi theme
    - [x] Change from rofi theme file to config
    - [x] Customize Waybar
    - [x] Set system theme to dark
    - [x] Change cursor theme and add missing icons
    - [ ] Create custom grub theme

- 🛠️ **Developer Tools & Environment**

  - 📝 **Editor & Shell**
    - [x] Complete VScode setup
    - [ ] Add NeoVim
    - [x] Add NodeJS
    - [ ] Add powerlevel10k shell prompt theme
  - 📦 **Optional Packages**
    - [ ] Make installation of virt-manager optional
    - [ ] Nvidia drivers (optional)

- 🧩 **Configuration & Customization**
  - 🏠 **Home Manager Customizations**
    - [x] Add customization object in flake for easy theme and package management
    - [ ] Set up options for display manager and theme selection
  - 🌄 **Background & Visuals**
    - [x] Add custom background

## 📝 Notes

- **VS Code Extensions**: Extensions are automatically installed during the `home-manager` build process. They are sourced from `pkgs.vscode-extensions`. For extensions not available in that repository, the `mutableExtensionsDir` option is enabled, allowing manual installation when needed.
