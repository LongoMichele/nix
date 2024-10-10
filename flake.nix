{
  description = "My first flake ^^";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    systemSettings = {
      hostname = "fly";
      system = "x86_64-linux";
    };
    system = systemSettings.hostname;
    userSettings = rec {
      username = "michele";
      description = "Michele Longo";
      home = "/home/${username}";
    };
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
      inherit system;
      modules = [ ./system/configuration.nix ];
      specialArgs = {
        inherit systemSettings;
        inherit userSettings;
      };
    };
    homeConfigurations.${userSettings.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./user/home.nix ];
      extraSpecialArgs = {
        inherit userSettings;
      };
    };
  };
}