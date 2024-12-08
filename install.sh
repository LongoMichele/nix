#!/usr/bin/env bash

export NIX_CONFIG="experimental-features = nix-command flakes"

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Regenerate hardware-configuration.nix
nixos-generate-config --show-hardware-config > system/hardware-configuration.nix
