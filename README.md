# Installation Instructions for NixOS Configuration
sudo nix --extra-experimental-features 'flakes nix-command' \
  run github:Blazzzeee/dotfiles-nix#nixosConfigurations.<host>.switch
