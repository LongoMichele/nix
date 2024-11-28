{ config, lib, pkgs, userSettings, theme, ... }:
let
  removeHash = hex: lib.strings.removePrefix "#" hex;
in {
  home = {
    packages = with pkgs; [
      swaybg
    ];
  };

  wayland.windowManager.hyprland = with theme; {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = ",preferred,auto,1.00";

      exec-once = [
        "waybar &"
        "swaybg -i ${backgroundImage} &"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = true;
        layout = "dwindle";
        "col.active_border" = "rgba(${removeHash colors.gray."700"}aa) rgba(${removeHash colors.foreground."500"}bb) 45deg";
        "col.inactive_border" = "rgba(${removeHash colors.gray."700"}bb)";
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
        "col.shadow" = "rgba(${removeHash colors.background."500"}ee)";

        blur = {
          enabled = true;
        };
      };

      windowrulev2 = [
        "float, class:(blueman)"
        "float, title:^(Volume Control)$"
      ];
      windowrule = [
        "noblur, ^(?!kitty$).*"
      ];

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
        numlock_by_default = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_touch = true;
        workspace_swipe_distance = 500;
        workspace_swipe_invert = false;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$lock" = "hyprlock";
      bind = [
        "CTRL, Space, exec, rofi -show drun"
        "CTRL, q, killactive"
        "CTRL SHIFT, q, exit"

        "ALT, t, exec, $terminal"
        "$mod, l, exec, $lock"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, Space, togglefloating"
        "$mod, J, togglesplit"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i: [
          "$mod, ${toString (i + 1)}, workspace, ${toString (i + 1)}"
          "$mod SHIFT, ${toString (i + 1)}, movetoworkspace, ${toString (i + 1)}"
        ]) userSettings.hyprland.minWorkspaces)
      );

      bindel = [
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+ --limit 1"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%- --limit 1"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizeindow"
      ];
    };
  };

  programs.hyprlock = with theme; {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = {
        path = "${backgroundImage}";
        blur_passes = 3;
        blur_size = 2;
      };

      input-field = {
        size = "300, 30";
        outline_thickness = 0;
        dots_size = "0.25";
        dots_spacing = "0.55";
        dots_center = true;
        outer_color = "rgba(${removeHash colors.gray."500"}ee)";
        inner_color = "rgba(${removeHash colors.background."500"}ff)";
        font_color =  "rgba(${removeHash colors.foreground."500"}ff)";
        fade_on_empty = false;
        hide_input = false;
        check_color = "rgba(${removeHash colors.accent."500"}55)";
        fail_color = "rgba(${removeHash colors.red."500"}ff)";
        fail_text = "$FAIL <b>($ATTEMPTS)</b>";
        fail_transition = 300;
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1;
        invert_numlock = false;
        swap_font_color = true;
        position = "0, -330";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(${removeHash colors.foreground."500"}ff)";
          font_size = 20;
          font_family = "UbuntuSans NFP";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(date +\"%k:%M\")\"";
          color = "rgba(${removeHash colors.foreground."500"}ff)";
          font_size = 90;
          font_family = "UbuntuSans NFP SemiBold";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        {
          text = "$USER";
          color = "rgba(${removeHash colors.foreground."500"}ff)";
          font_size = 15;
          font_family = "UbuntuSans NFP SemiBold";
          position = "0, -300";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
