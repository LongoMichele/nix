{ config, lib, pkgs, ... }:
{
  boot.loader = {
    systemd-boot.enable = false;

    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      extraEntries = ''
        menuentry "Firmware settings" {
          fwsetup
        }
      '';
      theme = pkgs.stdenv.mkDerivation {
        pname = "My Grub theme";
        version = "0.1";
        src = ./theme;
        installPhase = ''
          mkdir -p $out
          cp -r * $out
        '';
      };
    };

    efi = {
      canTouchEfiVariables = true;
    };
  };
}
