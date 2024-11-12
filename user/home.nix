{ config, lib, pkgs, userSettings, ... }:
{
  imports = [
    ./sh.nix
    ./kitty.nix
    ./vscode.nix
    ./waybar/waybar.nix
    ./firefox.nix
    ./hyprland.nix
    ./git.nix
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
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    sessionVariables.GTK_THEME = "palenight";
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.libsForQt5.breeze-qt5;
    };
  };

  programs.home-manager.enable = true;
}
