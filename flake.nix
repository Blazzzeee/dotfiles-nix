{
  description = "NixOS + Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

    hyprland-osd = {
      url = "path:./hyprland-osd";
    };

    hellpaper = {
      url = "path:./hellpaper";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    antigravity-nix,
    network_manager_ui,
    hyprland-osd,
    hellpaper,
    zen-browser,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    pkgs-unstable = import nixpkgs-unstable {inherit system;};
    niriEnabled = false;
  in {
    # --- NixOS system ---
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit niriEnabled pkgs-unstable;
      };

      modules = [
        ./configuration.nix
        ./pkgs.nix
        {
          environment.systemPackages = [
            antigravity-nix.packages.${system}.google-antigravity-cli
            network_manager_ui.packages.${system}.network_manager_ui
            hellpaper.packages.${system}.default
            hyprland-osd.packages.${system}.default
            zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        }
      ];
    };

    # --- Standalone Home Manager ---
    homeConfigurations.blazzee = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
      ];

      extraSpecialArgs = {
        inherit niriEnabled pkgs-unstable;
      };
    };
  };
}
