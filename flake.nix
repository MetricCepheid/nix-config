{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    waterfox.url = "github:Hythera/nix-waterfox";
    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    waterfox,
    copyparty
  }@inputs: let
  system = "x86_64-linux";
  in {
    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        desktop/blarp/configuration.nix
      ];
    };

    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        laptop/blarp/configuration.nix
      ];
    };
  };
}
