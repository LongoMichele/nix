{ pkgs, host, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./hardware-configuration.nix
    ./grub/grub.nix
    ./services/audio.nix
    ./packages/shell.nix
  ];

  fonts.packages = with pkgs; [
    fira-code
    nerdfonts
    font-awesome
    meslo-lgs-nf
  ];

  security.rtkit.enable = true;

  boot = {
    kernel.sysctl."kernel.sysrq" = 502;
    kernelPackages = pkgs.linuxPackages_latest;
  };

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

  services.xserver = {
    xkb = {
      layout = host.keyboardLayout;
      variant = "";
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
    lf
    unzip
  ];

  system.stateVersion = "24.05";
}
