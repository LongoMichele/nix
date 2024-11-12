{ config, pkgs, userSettings, ... }:

{
  programs.git = {
    enable = true;
    userName = userSettings.description;
    userEmail = userSettings.email;
    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}