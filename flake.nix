{
  description = "My first flake ❄️";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { self, nixpkgs, home-manager, textfox, ... }:
  let
    systemSettings = {
      hostname = "fly";
      system = "x86_64-linux";
      openssh = {
        enable = false;
        port = 22;
      };
    };
    userSettings = rec {
      username = "michele";
      email = "michele.longo@domain.com";
      description = "Michele Longo";
      home = "/home/${username}";
      hyprland = {
        minWorkspaces = 5;
      };
    };
    configurationRoot = "${userSettings.home}/nix";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
    theme = import ./theme.nix;
  in {
    nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
      system = systemSettings.system;
      modules = [ ./system/configuration.nix ];
      specialArgs = {
        inherit systemSettings;
        inherit userSettings;
      };
    };
    homeConfigurations.${userSettings.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./user/home.nix
        textfox.homeManagerModules.default
      ];
      extraSpecialArgs = {
        inherit userSettings configurationRoot theme;
      };
    };
  };
}
