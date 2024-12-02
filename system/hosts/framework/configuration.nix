{ config, pkgs, host, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ../../hardware-configuration.nix
    ../../grub/grub.nix
    ../../services/sddm/sddm.nix
    ../../packages/virt-manager.nix
  ];

  fonts.packages = with pkgs; [
    fira-code
    nerdfonts
    font-awesome
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.hyprland.enable = true;
  networking.hostName = host.name;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Rome";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  console.keyMap = host.keyboardLayout;

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

    xserver = {
      xkb = {
        layout = host.keyboardLayout;
        variant = "";
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

  users.users = builtins.listToAttrs (map (el: {
    name = el.name;
    value = {
      isNormalUser = true;
      description = el.description;
      extraGroups = [ "networkmanager" "wheel" ];
    };
  }) host.users);

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    brightnessctl
    alsa-utils
    pavucontrol
    lf
    unzip
    tmux
    neovim
  ];

  system.stateVersion = "24.05";
}
