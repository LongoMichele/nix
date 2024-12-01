{ config, lib, pkgs, ... }:
let
  sddm-theme = pkgs.libsForQt5.callPackage ./themes/tokyo-night.nix { };
in {
  services = {
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "tokyo-night-sddm";
    };
  };

  environment.systemPackages = with pkgs; [ sddm-theme ];
}
