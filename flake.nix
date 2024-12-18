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

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }: {
    darwinConfigurations.m1 = nix-darwin.lib.darwinSystem {
      modules = [
        ./config/default.nix
        ./config/darwin.nix

        {
          nixpkgs.hostPlatform = "aarch64-darwin";

          nix.settings.experimental-features = "nix-command flakes";
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "stianfroystein";
            autoMigrate = true;
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.stianfroystein = import ./config/home.nix;

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
        }

        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
      ];
    };
  };
}
