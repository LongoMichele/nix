{ config, pkgs, theme, ... }:
{
  home.packages = [ pkgs.libnotify ];

  services.mako = with theme.colors; {
    enable = true;

    anchor = "top-right";
    defaultTimeout = 10000;
    layer = "overlay";
    maxVisible = 5;

    width = 300;
    height = 150;
    font = "UbuntuSans 10";
    textColor = "${foreground."900"}ff";
    backgroundColor = "${background."300"}ff";
    borderColor = "${foreground."900"}ff";
    borderSize = 2;
    borderRadius = 10;
    progressColor = "over ${accent."500"}";
    padding = "5";
    margin = "22";

    extraConfig = ''
      [urgency=low]
      border-color=${foreground."900"}ff

      [urgency=normal]
      border-color=${accent."500"}ff

      [urgency=high]
      border-color=${red."500"}ff
    '';
  };
}
