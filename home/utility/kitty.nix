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
      url_color = blue."500";
      underline_hyperlinks = "always";
      window_padding_width = "5";
      window_margin_width = "0";
      foreground = foreground."500";
      background = background."500";
      background_opacity = "0.4";
      background_blur = "0";
      selection_foreground = background."500";
      selection_background = yellow."500";
    };
    shellIntegration.enableZshIntegration = true;
  };
}
