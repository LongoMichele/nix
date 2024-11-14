{ config, pkgs, theme, ... }:
let
  # inherit (config.lib.formats.rasi) mkLiteral;
  # rofi-theme = with theme.colorScheme.palette; {
  #   window = {
  #     background-color = "#2e3440";
  #     location = mkLiteral "center";
  #     width = mkLiteral "1024";
  #   };
  # };
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./theme.rafi;
    # theme = rofi-theme;
  };
}