{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    # --- NixOS system ---
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix
	  ./sh.nix
      ];
    };

    # --- Standalone Home Manager ---
    homeConfigurations.blazzee =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
      };
  };
}

