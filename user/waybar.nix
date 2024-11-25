{ config, lib, pkgs, theme, userSettings, ... }:
{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "backlight"
        "battery"
        "tray"
      ];
      "hyprland/workspaces" = {
        persistent-workspaces = {
          "*" = builtins.genList (i: i + 1) userSettings.hyprland.minWorkspaces;
        };
        show-special = true;
      };
      tray = {
        icon-size = 21;
        spacing = 10;
      };
      clock = {
        interval = 1;
        format = "{:%H:%M}";
        tooltip-format = "<big>{:%B %d %Y}</big>\n<tt><small>{calendar}</small></tt>";
      };
      cpu = {
        format = "{usage}%  ";
        tooltip = false;
      };
      memory = {
        format = "{}%  ";
      };
      backlight = {
        format = "{percent}%  {icon}";
        format-icons = [ "󰃞" "󰃟" "󰃠" ];
        tooltip = false;
      };
      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        interval = 1;
        format = "{capacity}%  {icon}";
        format-full = "{capacity}%  {icon}";
        format-charging = "{capacity}%  ";
        format-plugged = "{capacity}%  ";
        format-alt = "{time}  {icon}";
        format-icons = [ "" "" "" ];
        tooltip = false;
      };
      network = {
        format-wifi = "{essid}  ";
        format-ethernet = "{ipaddr}/{cidr}  ";
        format-linked = "{ifname} (No IP)  ";
        format-disconnected = "Disconnected  ";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        tooltip-format = "Signal: {signalStrength}%";
      };
      pulseaudio = {
        scroll-step = 5;
        format = "{volume}%  {icon}";
        format-bluetooth = "{volume}%  {icon}";
        format-bluetooth-muted = "  {icon}";
        format-muted = "{volume}% ";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
        tooltip = false;
      };
    };

    style = with theme.colors; ''
      * {
        font-family: "UbuntuSans NFP", FontAwesome, Roboto, sans-serif;
        font-weight: 500;
        font-size: 16px;
        border: none;
        border-radius: 4px;
        transition: all 250ms;
      }

      window#waybar {
        color: ${fg."700"};
        background-color: ${bg."700"};
        border-radius: 0;
        transition: all 500ms;
      }

      window#waybar > box {
        padding: 4px 8px;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #backlight,
      #battery,
      #tray {
        color: ${fg."300"};
        background-color: ${bg."300"};
        font-weight: 600;
        padding: 4px 8px;
        margin: 0 4px;
      }

      #network.disconnected {
        color: ${fg."300"};
        background-color: ${yellow."700"};
      }

      #pulseaudio.muted {
        color: ${gray."300"};
      }

      #battery.charging {
        background-color: ${green."700"};
      }

      #battery.critical {
        background-color: ${orange."700"};
      }

      #battery.critical:not(.charging):not(.plugged) {
        background-color: ${red."700"};
        animation: blink 0.5s linear infinite alternate;
      }

      #workspaces button {
        color: ${fg."300"};
        font-weight: 600;
        min-width: 1em;
        background-color: ${bg."300"};
        box-shadow: inset 0 -3px transparent;
        padding: 4px;
        margin: 0 2px;
      }

      #workspaces button:hover {
        background-color: ${bg."100"};
        box-shadow: inset 0 -3px ${accent."700"};
      }

      #workspaces button.active,
      #workspaces button:not(.empty) {
        box-shadow: inset 0 -3px ${accent."700"};
      }

      #workspaces button.active {
        background-color: ${bg."100"};
      }

      #workspaces button.urgent {
        background-color: ${red."700"};
        box-shadow: inset 0 -3px ${accent."300"};
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: ${orange."700"};
        }
      }
    '';
  };
}
