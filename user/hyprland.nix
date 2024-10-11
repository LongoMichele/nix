{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ",preferred,auto,1.00";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        layout = "dwindle";
        "col.active_border" = "rgba(468484ee) rgba(64a49dee) 45deg";
        "col.inactive_border" = "rgba(64a49d99)";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      bezier = [  "myBezier, 0.05, 0.9, 0.1, 1.05"  ];
      animations = {
        enabled = true;
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      input = {
        kb_layout = "it";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_touch = true;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = false;
      };

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      bind = [
        "CTRL, Space, exec, rofi -show run"
        "CTRL, q, killactive"
        "CTRL SHIFT, q, exit"

        "ALT, t, exec, $terminal"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, Space, togglefloating"
        "$mod, J, togglesplit"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i: [
          "$mod, ${toString (i + 1)}, workspace, ${toString (i + 1)}"
          "$mod SHIFT, ${toString (i + 1)}, movetoworkspace, ${toString (i + 1)}"
        ]) 9)
      );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizeindow"
      ];
    };
  };
}
