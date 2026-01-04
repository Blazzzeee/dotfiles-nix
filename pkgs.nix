{ config , pkgs , lib, ... }:

{
    environment.systemPackages = with pkgs; [
      kitty
      nerd-fonts.jetbrains-mono
      vimix-cursors
      wl-clipboard
      pavucontrol
      brightnessctl
      arp-scan
      tailscale
      libnotify
    ];
}
