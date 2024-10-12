{ config, lib, pkgs, userSettings, ... }:
{
  environment.systemPackages = [ pkgs.virt-manager ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
}
