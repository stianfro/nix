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
    let
      revision = self.rev or self.dirtyRev or null;
      config_default = import ./config/default.nix;
      config_darwin = import ./config/darwin.nix;
    in
    {
      darwinConfigurations.m1 = nix-darwin.lib.darwinSystem {
        modules = [
          config_default
          config_darwin
          nix-homebrew.darwinModules.nix-homebrew
          {
            nixpkgs.hostPlatform = "aarch64-darwin";
            system.configurationRevision = revision;
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "stianfroystein";
              autoMigrate = true;
            };
            nix.settings.experimental-features = "nix-command flakes";
            system.stateVersion = 5;
          }
        ];
      };
    };
}
