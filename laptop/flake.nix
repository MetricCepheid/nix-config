{
  # test
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, copyparty }:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	copyparty.nixosModules.default
        ./blarp/configuration.nix        
      ];
    };
  };
}
