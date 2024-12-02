{ config, pkgs, host, ... }:
{
  imports = [
    ../../commons.nix
    ../../services/sddm/sddm.nix
    ../../services/bluetooth.nix
    ../../packages/virt-manager.nix
  ];

  programs.hyprland.enable = true;

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    tmux
    neovim
  ];
}
