# ❄️ My NixOS configuration ❄️

## 📖 Table of Contents

- [Installation](#⚙️-installation)
- [Hosts](#🖥️-hosts)
- [Users](#👤-users)
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

## 📝 Notes
