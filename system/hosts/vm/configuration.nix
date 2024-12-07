{ config, pkgs, host, ... }:
{
  imports = [
    ../../commons.nix
    ../../packages/tmux.nix
  ];

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
  ];
}
