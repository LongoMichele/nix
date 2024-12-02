{ pkgs, host, ... }:
{
  fonts.packages = with pkgs; [
    fira-code
    nerdfonts
    font-awesome
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

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
    kitty
    lf
    unzip
  ];

  system.stateVersion = "24.05";
}