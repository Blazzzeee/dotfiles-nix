{ config , pkgs , lib , ... }:

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
        dnsutils
        clang-tools
        lua-language-server
        pyright
        nodePackages.typescript-language-server
        nodePackages.eslint
        rubyPackages.ruby-lsp
        emmet-language-server
        uv
    ]
}
