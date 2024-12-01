{ config, pkgs, theme, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  rofi-theme = with theme.colors; {
    "*" = {
      background-color = mkLiteral "transparent";
      border-color = mkLiteral accent."700";
    };
    "element" = {
      padding = mkLiteral "1px";
      cursor = mkLiteral "pointer";
      spacing = mkLiteral "5px";
      border = mkLiteral "0";
    };
    "element normal.normal" = {
      text-color = mkLiteral background."900";
      background-color = mkLiteral foreground."900";
    };
    "element normal.urgent" = {
      text-color = mkLiteral foreground."500";
      background-color = mkLiteral red."700";
    };
    "element normal.active" = {
      text-color = mkLiteral foreground."300";
      background-color = mkLiteral background."300";
    };
    "element selected.normal" = {
      text-color = mkLiteral foreground."500";
      background-color = mkLiteral background."100";
    };
    "element selected.urgent" = {
      background-color = mkLiteral red."500";
      text-color = mkLiteral foreground."300";
    };
    "element selected.active" = {
      text-color = mkLiteral foreground."100";
      background-color = mkLiteral background."100";
    };
    "element alternate.normal" = {
      text-color = mkLiteral foreground."500";
      background-color = mkLiteral background."500";
    };
    "element alternate.urgent" = {
      background-color = mkLiteral orange."500";
      text-color = mkLiteral foreground."300";
    };
    "element alternate.active" = {
      text-color = mkLiteral foreground."700";
      background-color = mkLiteral background."300";
    };
    "element-text" = {
      background-color = mkLiteral "transparent";
      cursor = mkLiteral "inherit";
      highlight = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };
    "element-icon" = {
      background-color = mkLiteral "transparent";
      size = mkLiteral "1em";
      cursor = mkLiteral "inherit";
      text-color = mkLiteral "inherit";
    };
    "window" = {
      padding = mkLiteral "5";
      background-color = mkLiteral background."700";
      border = mkLiteral "1";
    };
    "mainbox" = {
      padding = mkLiteral "0";
      border = mkLiteral "0";
    };
    "message" = {
      padding = mkLiteral "1px";
      border-color = mkLiteral accent."500";
      border = mkLiteral "2px dash 0px 0px";
    };
    "textbox" = {
      text-color = mkLiteral foreground."700";
    };
    "listview" = {
      padding = mkLiteral "2px 0px 0px";
      scrollbar = mkLiteral "true";
      border-color = mkLiteral accent."500";
      spacing = mkLiteral "2px";
      fixed-height = mkLiteral "0";
      border = mkLiteral "2px dash 0px 0px";
    };
    "scrollbar" = {
      width = mkLiteral "4px";
      padding = mkLiteral "0";
      handle-width = mkLiteral "8px";
      border = mkLiteral "0";
      handle-color = mkLiteral foreground."700";
    };
    "sidebar" = {
      border-color = mkLiteral accent."500";
      border = mkLiteral "2px dash 0px 0px";
    };
    "num-filtered-rows" = {
      expand = mkLiteral "false";
      text-color = mkLiteral foreground."100";
    };
    "num-rows" = {
      expand = mkLiteral "false";
      text-color = mkLiteral foreground."100";
    };
    "textbox-num-sep" = {
      expand = mkLiteral "false";
      str = "/";
      text-color = mkLiteral foreground."100";
    };
    inputbar = {
      padding = mkLiteral "1px";
      spacing = mkLiteral "0px";
      text-color = mkLiteral foreground."100";
      children = mkLiteral "[ 'prompt','textbox-prompt-colon','entry','num-filtered-rows','textbox-num-sep','num-rows','case-indicator' ]";
    };
    case-indicator = {
      spacing = mkLiteral "0";
      text-color = mkLiteral foreground."300";
    };
    entry = {
      text-color = mkLiteral foreground."700";
      cursor = mkLiteral "text";
      spacing = mkLiteral "0";
      placeholder-color = mkLiteral foreground."100";
      placeholder = "Type to filter";
    };
    prompt = {
      spacing = mkLiteral "0";
      text-color = mkLiteral foreground."700";
    };
    textbox-prompt-colon = {
      margin = mkLiteral "0px 0.3em 0em 0em";
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
