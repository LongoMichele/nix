{ config, lib, pkgs, userSettings, ... }:
{
  imports = [
    ./sh.nix
    ./hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home = {
    username = userSettings.username;
    homeDirectory = userSettings.home;
    stateVersion = "24.05";
    packages = with pkgs; [
      rofi-wayland
      google-chrome
      vscode.fhs
    ];
  };

  programs.home-manager.enable = true;
}