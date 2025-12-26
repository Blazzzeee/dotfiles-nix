{ config , pkgs , ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    nerd-fonts.jetbrains-mono
    vimix-cursors
    wl-clipboard
    pavucontrol
    brightnessctl
    libnotify
  ];
}
