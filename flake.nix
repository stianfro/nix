{
  description = "Stian's darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations.m1 = nix-darwin.lib.darwinSystem {
        modules = [
          ./config/darwin.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "stianfroystein";
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
