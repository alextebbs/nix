{
  description = "alextebbs home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }:
    let
      mkHome = { system, username, homeDirectory }:
        let
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfreePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [ "claude-code" ];
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit username homeDirectory; };
          modules = [
            nixvim.homeManagerModules.nixvim
            ./home.nix
          ];
        };
    in {
      homeConfigurations."alextebbs" = mkHome {
        system = "aarch64-darwin";
        username = "alextebbs";
        homeDirectory = "/Users/alextebbs";
      };
      homeConfigurations."squire" = mkHome {
        system = "x86_64-linux";
        username = "squire";
        homeDirectory = "/home/squire";
      };
    };
}
