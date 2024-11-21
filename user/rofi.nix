{ config, pkgs, theme, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  rofi-theme = with theme; {
    "*" = {
      red = mkLiteral "${theme.colors.red}";
      selected-active-foreground = mkLiteral "@background";
      lightfg = mkLiteral "${theme.aliases.lightfg}";
      separatorcolor = mkLiteral "@foreground";
      urgent-foreground = mkLiteral "@red";
      alternate-urgent-background = mkLiteral "@lightbg";
      lightbg = mkLiteral "${theme.aliases.lightbg}";
      background-color = mkLiteral "transparent";
      border-color = mkLiteral "@foreground";
      normal-background = mkLiteral "@background";
      selected-urgent-background = mkLiteral "@red";
      alternate-active-background = mkLiteral "@lightbg";
      spacing = mkLiteral "2";
      blue = mkLiteral "${theme.colors.blue}";
      alternate-normal-foreground = mkLiteral "@foreground";
      urgent-background = mkLiteral "@background";
      selected-normal-foreground = mkLiteral "@lightbg";
      active-foreground = mkLiteral "@blue";
      background = mkLiteral "${theme.colors.background}";
      selected-active-background = mkLiteral "@blue";
      active-background = mkLiteral "@background";
      selected-normal-background = mkLiteral "@lightfg";
      alternate-normal-background = mkLiteral "@lightbg";
      foreground = mkLiteral "${theme.colors.foreground}";
      selected-urgent-foreground = mkLiteral "@background";
      normal-foreground = mkLiteral "@foreground";
      alternate-urgent-foreground = mkLiteral "@red";
      alternate-active-foreground = mkLiteral "@blue";
    };
    "element" = {
      padding = mkLiteral "1px";
      cursor = mkLiteral "pointer";
      spacing = mkLiteral "5px";
      border = mkLiteral "0";
    };
    "element normal.normal" = {
      background-color = mkLiteral "@normal-background";
      text-color = mkLiteral "@normal-foreground";
    };
    "element normal.urgent" = {
      background-color = mkLiteral "@urgent-background";
      text-color = mkLiteral "@urgent-foreground";
    };
    "element normal.active" = {
      background-color = mkLiteral "@active-background";
      text-color = mkLiteral "@active-foreground";
    };
    "element selected.normal" = {
      background-color = mkLiteral "@selected-normal-background";
      text-color = mkLiteral "@selected-normal-foreground";
    };
    "element selected.urgent" = {
      background-color = mkLiteral "@selected-urgent-background";
      text-color = mkLiteral "@selected-urgent-foreground";
    };
    "element selected.active" = {
      background-color = mkLiteral "@selected-active-background";
      text-color = mkLiteral "@selected-active-foreground";
    };
    "element alternate.normal" = {
      background-color = mkLiteral "@alternate-normal-background";
      text-color = mkLiteral "@alternate-normal-foreground";
    };
    "element alternate.urgent" = {
      background-color = mkLiteral "@alternate-urgent-background";
      text-color = mkLiteral "@alternate-urgent-foreground";
    };
    "element alternate.active" = {
      background-color = mkLiteral "@alternate-active-background";
      text-color = mkLiteral "@alternate-active-foreground";
    };
    "element-text" = {
      background-color = mkLiteral "transparent";
      cursor = mkLiteral "inherit";
      highlight = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };
    "element-icon" = {
      background-color = mkLiteral "transparent";
      size = mkLiteral "1.0000em";
      cursor = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };
    "window" = {
      padding = mkLiteral "5";
      background-color = mkLiteral "@background";
      border = mkLiteral "1";
    };
    "mainbox" = {
      padding = mkLiteral "0";
      border = mkLiteral "0";
    };
    "message" = {
      padding = mkLiteral "1px";
      border-color = mkLiteral "@separatorcolor";
      border = mkLiteral "2px dash 0px 0px";
    };
    "textbox" = {
      text-color = mkLiteral "@foreground";
    };
    "listview" = {
      padding = mkLiteral "2px 0px 0px";
      scrollbar = mkLiteral "true";
      border-color = mkLiteral "@separatorcolor";
      spacing = mkLiteral "2px";
      fixed-height = mkLiteral "0";
      border = mkLiteral "2px dash 0px 0px";
    };
    "scrollbar" = {
      width = mkLiteral "4px";
      padding = mkLiteral "0";
      handle-width = mkLiteral "8px";
      border = mkLiteral "0";
      handle-color = mkLiteral "@normal-foreground";
    };
    "sidebar" = {
      border-color = mkLiteral "@separatorcolor";
      border = mkLiteral "2px dash 0px 0px";
    };
    "button" = {
      cursor = mkLiteral "pointer";
      spacing = mkLiteral "0";
      text-color = mkLiteral "@normal-foreground";
    };
    "button selected" = {
      background-color = mkLiteral "@selected-normal-background";
      text-color = mkLiteral "@selected-normal-foreground";
    };
    "num-filtered-rows" = {
      expand = mkLiteral "false";
      text-color = mkLiteral "Gray";
    };
    "num-rows" = {
      expand = mkLiteral "false";
      text-color = mkLiteral "Gray";
    };
    "textbox-num-sep" = {
      expand = mkLiteral "false";
      str = "/";
      text-color = mkLiteral "Gray";
    };
    inputbar = {
      padding = mkLiteral "1px";
      spacing = mkLiteral "0px";
      text-color = mkLiteral "@normal-foreground";
      children = mkLiteral "[ 'prompt','textbox-prompt-colon','entry','num-filtered-rows','textbox-num-sep','num-rows','case-indicator' ]";
    };
    case-indicator = {
      spacing = mkLiteral "0";
      text-color = mkLiteral "@normal-foreground";
    };
    entry = {
      text-color = mkLiteral "@normal-foreground";
      cursor = mkLiteral "text";
      spacing = mkLiteral "0";
      placeholder-color = mkLiteral "Gray";
      placeholder = "Type to filter";
    };
    prompt = {
      spacing = mkLiteral "0";
      text-color = mkLiteral "@normal-foreground";
    };
    textbox-prompt-colon = {
      margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
      expand = mkLiteral "false";
      str = ":";
      text-color = mkLiteral "inherit";
    };
    configuration = {
      modes = mkLiteral "[ drun, run ]";
    };
  };
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = rofi-theme;
  };
}