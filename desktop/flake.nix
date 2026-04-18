{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    waterfox.url = "github:Hythera/nix-waterfox";
  };
  outputs = {
    self,
    nixpkgs,
    waterfox
  }@inputs: let
  system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./blarp/configuration.nix
      ];
    };
  };
}
