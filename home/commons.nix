{ user, ... }:
{
  imports = [
    ./utility/git.nix
    ./utility/shell/shell.nix
  ];

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;
}
