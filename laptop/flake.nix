{
  # test
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";

    waterfox.url = "github:Hythera/nix-waterfox";
  };

  outputs = { self, nixpkgs, copyparty, waterfox }@inputs: let
  system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        copyparty.nixosModules.default
          ./blarp/configuration.nix
      ];
    };
  };
}
