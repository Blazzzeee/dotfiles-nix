{ config , pkgs , ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    nerd-fonts.jetbrains-mono
    vimix-cursors
  ];
}
