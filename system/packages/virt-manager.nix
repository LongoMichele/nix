{ config, lib, pkgs, host, ... }:
{
  environment.systemPackages = [ pkgs.virt-manager ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users = builtins.listToAttrs (map (el: {
    name = el.name;
    value = {
      extraGroups = [ "libvirtd" ];
    };
  }) host.users);
}
