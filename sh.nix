{ config , pkgs , ... }:

{
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    zsh
    starship
    kitty
    nerd-fonts.jetbrains-mono
  ];
}
