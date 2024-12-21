{ pkgs, ... }:
{
  imports = [
    ../../commons.nix
    ../../services/sddm/sddm.nix
    ../../services/bluetooth.nix
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

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      neovim
    ];
 };
}
