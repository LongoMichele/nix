{ config, pkgs, host, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ../../commons.nix
    ../../hardware-configuration.nix
    ../../grub/grub.nix
    ../../services/sddm/sddm.nix
    ../../packages/virt-manager.nix
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  programs.hyprland.enable = true;

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };

    openssh = {
      enable = true;
      ports = [ 22 ];
    };

    blueman.enable = true;
  };

  environment.shells = with pkgs; [ bash zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" ];
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    alsa-utils
    pavucontrol
    tmux
    neovim
  ];
}
