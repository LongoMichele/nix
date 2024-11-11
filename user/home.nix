{ config, lib, pkgs, userSettings, ... }:
{
  imports = [
    ./sh.nix
    ./kitty.nix
    ./vscode.nix
    ./waybar/waybar.nix
    ./firefox.nix
    ./hyprland.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home = {
    username = userSettings.username;
    homeDirectory = userSettings.home;
    stateVersion = "24.05";
    packages = with pkgs; [
      rofi-wayland
    ];

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
  programs.home-manager.enable = true;
}
