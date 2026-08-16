{
  description = "hyprland-osd";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
    in {
      packages.default = pkgs.swayosd;
      apps.default = {
        type = "app";
        program = "${pkgs.swayosd}/bin/swayosd";
      };
    })
    // {
      overlays.default = final: prev: {
        swayosd = prev.rustPlatform.buildRustPackage {
          pname = "swayosd";
          version = "0.1.0";
          src = prev.lib.cleanSourceWith {
            src = self;
            filter = path: type:
              prev.lib.cleanSourceFilter path type
              && (builtins.baseNameOf path) != "result";
          };

          cargoLock = {
            lockFile = ./Cargo.lock;
          };

          nativeBuildInputs = [
            prev.pkg-config
            prev.wrapGAppsHook3
          ];

          buildInputs = [
            prev.gtk3
            prev.gtk-layer-shell
            prev.pulseaudio
          ];

          meta = with prev.lib; {
            description = "hyprland-osd";
            license = licenses.mit;
            platforms = platforms.linux;
            mainProgram = "swayosd";
          };
        };
      };

      nixosModules.default = {
        lib,
        config,
        pkgs,
        ...
      }: let
        cfg = config.programs.swayosd;
      in {
        options.programs.swayosd = {
          enable = lib.mkEnableOption "hyprland-osd";
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.swayosd;
            defaultText = "pkgs.swayosd";
            description = "The swayosd package to use.";
          };
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      };
    };
}
