{ config, pkgs, host, ... }:
{
  imports = [
    ../../commons.nix
    ../../services/sddm/sddm.nix
    ../../packages/virt-manager.nix
    ../../packages/tmux.nix
    ../../packages/steam.nix
    ../../hw/nvidia.nix
  ];

  programs.hyprland.enable = true;

  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];
}
