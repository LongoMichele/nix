{ pkgs, ... }:
{
  imports = [
    ../../commons.nix
    ../../services/sddm/sddm.nix
    ../../services/bluetooth.nix
    ../../packages/virt-manager.nix
    ../../packages/tmux.nix
  ];

  programs.hyprland.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      brightnessctl
      neovim
    ]; 
  };

}
