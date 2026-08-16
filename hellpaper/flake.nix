{
  description = "Hellpaper (raylib wallpaper app)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "hellpaper";
      version = "1.0";
      src = ./.;

      nativeBuildInputs = [
        pkgs.pkg-config
      ];

      buildInputs = [
        pkgs.raylib
        pkgs.swww
      ];

      buildPhase = ''
        make
      '';

installPhase = ''
  mkdir -p $out/bin
  mkdir -p $out/share/applications
  mkdir -p $out/share/hellpaper

  # Install compiled binary
  install -m755 hellpaper $out/bin/hellpaper

  # ---- Default config stored inside package ----
  cat > $out/share/hellpaper/hellpaper.conf <<EOF
# Hellpaper Configuration File
# Lines starting with # or ; are comments.

[Theme]
bg = 10, 10, 15, 255
idle = 30, 30, 46, 255
hover = 49, 50, 68, 255
border = 203, 166, 247, 255
ripple = 245, 194, 231, 255
overlay = 10, 10, 15, 200
text = 202, 212, 241, 255

[Settings]
width = 1280
height = 720
max_wallpapers = 512
base_thumb_size = 150
base_padding = 15
border_thickness_bloom = 3.0
max_threads = 8
anim_speed = 20.0
particle_count = 50
ken_burns_duration = 15.0
max_fps = 200

[Effects]
startup_effect = blur
keypress_effect = none
exit_effect = glitch
EOF

  # ---- Wrapper ----
  cat > $out/bin/wall <<EOF
#!/usr/bin/env bash

CONFIG_DIR="\$HOME/.config/hellpaper"
CONFIG_FILE="\$CONFIG_DIR/hellpaper.conf"
DEFAULT_WALL_DIR="\$HOME/dotfiles-nix/wallpapers"

# Create config if missing
if [ ! -f "\$CONFIG_FILE" ]; then
  mkdir -p "\$CONFIG_DIR"
  cp "$out/share/hellpaper/hellpaper.conf" "\$CONFIG_FILE"
fi

WALL=\$($out/bin/hellpaper "\$DEFAULT_WALL_DIR" "\$@")

if [ -n "\$WALL" ]; then
  ${pkgs.swww}/bin/swww img "\$WALL" -t grow
fi
EOF

  chmod +x $out/bin/wall

  # Desktop entry
  cat > $out/share/applications/hellpaper.desktop <<EOF
[Desktop Entry]
Name=Hellpaper
Comment=Wallpaper selector
Exec=wall
Icon=hellpaper
Terminal=false
Type=Application
Categories=Utility;
EOF
'';
  };
  };
}
