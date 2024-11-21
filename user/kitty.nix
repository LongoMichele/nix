{ config, pkgs, theme, ... }:
{
  programs.kitty = with theme.colors; {
    enable = true;
    settings = {
      font_size = "11.0";
      cursor = cursor;
      cursor_shape = "beam";
      cursor_shape_unfocused = "unchanged";
      cursor_beam_thickness = "1.5";
      url_color = blue;
      underline_hyperlinks = "always";
      window_padding_width = "5";
      window_margin_width = "0";
      foreground = foreground;
      background = background;
      background_opacity = "0.4";
      background_blur = "0";
      selection_foreground = background;
      selection_background = yellow;
    };
    shellIntegration.enableZshIntegration = true;
  };
}
