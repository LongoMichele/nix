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
    theme = rec {
      backgroundImage = "${configurationRoot}/assets/bg.jpg";
      colors = rec {
        background = {
          "900" = "#1C2025";
          "700" = "#23272E";
          "500" = "#282C34";
          "300" = "#323845";
          "100" = "#3C4451";
        };
        bg = background;
        foreground = {
          "900" = "#868D98";
          "700" = "#97A0B0";
          "500" = "#ABB2BF";
          "300" = "#C2C7D4";
          "100" = "#D9DDE5";
        };
        fg = foreground;
        red = {
          "700" = "#B0525E";
          "500" = "#E06C75";
          "300" = "#F28B8C";
        };
        orange = {
          "700" = "#A4734E";
          "500" = "#D19A66";
          "300" = "#E6B480";
        };
        yellow = {
          "700" = "#B29C60";
          "500" = "#E5C07B";
          "300" = "#F3D59A";
        };
        green = {
          "700" = "#6C9256";
          "500" = "#98C379";
          "300" = "#B4D2A0";
        };
        cyan = {
          "700" = "#3C8A9E";
          "500" = "#56B6C2";
          "300" = "#77CDD6";
        };
        blue = {
          "700" = "#3D7096";
          "500" = "#61AFEF";
          "300" = "#81C1F5";
        };
        purple = {
          "700" = "#9257A7";
          "500" = "#C678DD";
          "300" = "#DFA1EC";
        };
        gray = {
          "700" = "#3E4451";
          "500" = "#5C6370";
          "300" = "#6C7685";
        };
        grey = gray;
        accent = purple;
        selection = "#3E4451";
        cursor = "#528BFF";
      };
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
