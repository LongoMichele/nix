{ config, lib, pkgs,  user, ... }:
{
  imports = [
    ../../commons.nix
    ../../utility/node.nix
    ../../wm/hyprland.nix
    ../../packages/vscode.nix
    ../../packages/firefox.nix
  ];
  home = {
    packages = with pkgs; [
      google-chrome
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
}
