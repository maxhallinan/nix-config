{
  description = "maxhallinan-nix-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    darwin,
    nixpkgs,
    ...
  } @ inputs: {
    darwinConfigurations = {
      "maxhallinan-m1" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [./darwin/configuration.nix];
        specialArgs = inputs;
      };
    };
  };
}
