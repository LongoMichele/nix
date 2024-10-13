{ config, lib, pkgs, userSettings, ... }:
let
  styles = builtins.readFile ./style.css;
in {
  home.packages = with pkgs; [ waybar font-awesome ];
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "battery" ];

        "hyprland/workspaces" = {
          persistent-workspaces = {
            "*" = builtins.genList (i: i + 1) userSettings.hyprland.minWorkspaces;
          };
          show-special = false;
        };
      };
    };

    style = styles;
  };
}
