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
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    flakeRoot = toString ./.;
    defaultUserConfig = {
      fullName = "Michele Longo";
      description = "Michele Longo";
      email = "michele.longo@domain.com";
      hyprland.minWorkspaces = 10;
    };

    users = [
      (defaultUserConfig // {
        name = "michele";
        fullName = "Michele Longo";
        description = "Michele Longo";
        email = "michele.longo@domain.com";
        hyprland.minWorkspaces = 5;
      })
    ];
    findUser = name: lib.filter (u: u.name == name) users;
    hosts = [
      {
        name = "fly";
        system = "x86_64-linux";
        users = lib.concatMap findUser [ "michele" "second" ];
      }
    ];
    theme = import ./config/theme.nix {
      inherit flakeRoot;
    };
  in {
    nixosConfigurations = builtins.listToAttrs (map (el: {
      name = el.name;
      value = lib.nixosSystem {
        system = el.system;
        modules = [ ./system/hosts/${el.name}/configuration.nix ];
        specialArgs = {
          host = el;
        };
      };
    }) hosts);

    homeConfigurations = builtins.listToAttrs (map (el: {
      name = el.name;
      value = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/users/${el.name}/home.nix
          textfox.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit theme;
          user = el;
        };
      };
    }) users);
  };
}
