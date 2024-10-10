{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,1.00";

      "$mod" = "SUPER";
      bind = [
        "CTRL, Space, exec, rofi -show run"
        "CTRL, q, killactive"
        "CTRL SHIFT, q, exit"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i: [
          "$mod, ${toString (i + 1)}, workspace, ${toString (i + 1)}"
          "$mod SHIFT, ${toString (i + 1)}, movetoworkspace, ${toString (i + 1)}"
        ]) 9)
      );

      input = {
        kb_layout = "it";
      };
    };
  };
}
