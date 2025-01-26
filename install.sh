#!/usr/bin/env bash

if [ ! -f /etc/os-release ]; then
  echo "Cannot find file /etc/os-release. Unknown OS, aborting."
  exit 1
fi
DISTRO="$(cat /etc/os-release | grep -E -i '^NAME=' | cut -d '=' -f 2)"

if [ -z $(command -v nix) ]; then
  echo "Cannot find nix command. Nix is not installed, aborting."
  exit 1
fi

if [ "$DISTRO" != "NixOS" ]; then
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
fi

export NIX_CONFIG="experimental-features = nix-command flakes"

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Regenerate hardware-configuration.nix
nixos-generate-config --show-hardware-config > system/hardware-configuration.nix
