{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    waterfox.url = "github:Hythera/nix-waterfox";
    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-rpcs3.url = "github:NixOS/nixpkgs/9cadaf6932b7";
  };
  outputs = {
    self,
    nixpkgs,
    waterfox,
    copyparty,
    nixpkgs-rpcs3
  }@inputs: let
  system = "x86_64-linux";
  in {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        desktop/configuration.nix
      ];
    };

    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        copyparty.nixosModules.default
        laptop/configuration.nix
      ];
    };
  };
}
