#!/usr/bin/env bash

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

# Regenerate hardware-configuration.nix
nixos-generate-config --show-hardware-config > system/hardware-configuration.nix
