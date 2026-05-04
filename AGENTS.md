# Repository Guidelines

This repository contains a NixOS + Home Manager flake and related dotfiles (Hyprland/Niri, Waybar, Rofi, Neovim, scripts).

## Project Structure & Module Organization

- `flake.nix`: flake inputs/outputs (`nixosConfigurations.*`, `homeConfigurations.*`).
- `configuration.nix`, `hardware-configuration.nix`: NixOS system configuration.
- `home.nix`: Home Manager configuration and dotfile wiring (e.g. `home.file.".config/..."`).
- App config directories:
  - `hypr/`, `niri/`: compositor configs.
  - `waybar/`, `waybar-niri/`, `waybar-vertical/`: Waybar configs/styles.
  - `rofi/`, `swaync/`, `zellij/`, `nvim/`: app configs.
  - `scripts/`: executable helper scripts.
  - `hellpaper/`, `hyprland-osd/`: local flake inputs (packaged in `flake.nix`).

## Build, Test, and Development Commands

- `sudo nix --extra-experimental-features 'flakes nix-command' run .#nixosConfigurations.<host>.switch`: apply the NixOS config (see `README.md`).
- `home-manager switch --flake .#blazzee`: apply the Home Manager config (requires Home Manager installed).
- `nix flake check`: evaluate the flake and catch basic errors.
- `alejandra -q <file.nix>`: format Nix files (used in this repo).

## Coding Style & Naming Conventions

- Nix: 2-space indentation; format with `alejandra`.
- JSONC/CSS: keep existing formatting; prefer small, focused diffs.
- Prefer descriptive names for new config folders (e.g. `waybar-vertical/`).

## Testing Guidelines

No dedicated test suite. Validate changes by:
- running `nix flake check` and rebuilding/switching the relevant configuration.
- launching affected apps (e.g. `waybar -c ~/.config/waybar-vertical/config.jsonc -s ~/.config/waybar-vertical/style.css`).

## Commit & Pull Request Guidelines

Commit messages in history are short and pragmatic (often lowercase, e.g. `add …`, `fix …`, `chore …`). Follow that convention and group related changes.
For PRs, include:
- a brief summary of behavior changes,
- any commands used to validate (`nix flake check`, switch commands),
- screenshots for UI tweaks (Waybar/Rofi/SwayNC) when relevant.

## Security & Configuration Tips

- Avoid committing secrets (tokens/keys). Prefer NixOS/Home Manager options or external secret managers.
- Keep host-specific values isolated (use flake outputs and `specialArgs`/`extraSpecialArgs` patterns already present).
