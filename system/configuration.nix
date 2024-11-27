{ config, pkgs, systemSettings, userSettings, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./hardware-configuration.nix
    ./virt-manager.nix
    ./sddm/sddm.nix
  ];

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
    };

    efi = {
      canTouchEfiVariables = true;
    };
  };

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

  programs.hyprland.enable = true;
  networking.hostName = systemSettings.hostname; 
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

  console.keyMap = "it";

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
        layout = "it";
        variant = "";
      };
    };

    openssh = {
      enable = systemSettings.openssh.enable;
      ports = [ systemSettings.openssh.port ];
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

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.description;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

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
  ];

  system.stateVersion = "24.05";
}
