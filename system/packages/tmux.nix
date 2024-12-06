{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "s";
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -g mouse on

      set-option -sg escape-time 10

      set -g default-terminal "tmux-256color"
      set -g terminal-overrides ',xterm-256color:Tc'
    '';
  };
}
