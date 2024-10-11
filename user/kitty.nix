{ config, lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "11.0";
      cursor = "#eeeeee";
      cursor_shape = "beam";
      cursor_shape_unfocused = "unchanged";
      cursor_beam_thickness = "1.5";
      url_color = "#0087bd";
      underline_hyperlinks = "always";
      window_padding_width = "5";
      window_margin_width = "0";
      foreground = "#dddddd";
      background = "#333333";
      background_opacity = "0.4";
      background_blur = "0";
      selection_foreground = "#000000";
      selection_background = "#fffacd";
    };
    shellIntegration.enableZshIntegration = true;
  };
}
