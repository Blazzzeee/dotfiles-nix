{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    network_manager_ui = {
      url = "github:Blazzzeee/network_manager_ui?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, antigravity-nix, network_manager_ui, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    niriEnabled = true;

  in {
    # --- NixOS system ---
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit niriEnabled;
      };

      modules = [
        ./configuration.nix
        ./pkgs.nix
          {
          environment.systemPackages = [
            antigravity-nix.packages.x86_64-linux.default
            network_manager_ui.packages.x86_64-linux.network_manager_ui
          ];
        }
      ];
    };

    # --- Standalone Home Manager ---
    homeConfigurations.blazzee =
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
       
        modules = [
          ./home.nix
      ];

      extraSpecialArgs = {
        inherit niriEnabled;
          };

      };
  };
}

