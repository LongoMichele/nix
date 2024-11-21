{
  description = "My first flake ^^";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, textfox, nix-colors, ... }:
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
    theme = rec {
      backgroundImage = "${configurationRoot}/assets/bg.jpg";
      colors = {
        background = "#282C34";
        foreground = "#ABB2BF";
        cursor = "#528BFF";

        red = "#E06C75";
        orange = "#D19A66";
        yellow = "#E5C07B";
        green = "#98C379";
        cyan = "#56B6C2";
        blue = "#61AFEF";
        purple = "#C678DD";

        dark-gray = "#3E4451";
        light-gray = "#5C6370";
        selection = "#3E4451";
        comment = "#5C6370";
      };
      aliases = {
        lightbg = "${colors.dark-gray}";
        lightfg = "${colors.foreground}";
        border = "${colors.foreground}";
        accent = "${colors.blue}";
      };
      colorScheme = nix-colors.colorSchemes.dracula;
    };
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
