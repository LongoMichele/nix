{ user, ... }:
{
  imports = [
    ./utility/git.nix
    ./utility/shell/shell.nix
    ./utility/neovim/neovim.nix
  ];

  home = {
    username = user.name;
    homeDirectory = "/home/${user.name}";
      stateVersion = "24.11";
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
