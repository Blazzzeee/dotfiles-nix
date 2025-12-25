{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "blazzee";
  home.homeDirectory = "/home/blazzee";
  programs.waybar.enable = true;
  programs.helix.enable = true;
  programs.zoxide.enable = true;
  services.swww.enable = true;
  wayland.windowManager.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.starship.enable = true;


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
  tofi
  qutebrowser
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  home.file.".config/waybar" = {
    source = ./waybar;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.file.".config/tofi/config.toml" = { 
      source = pkgs.writeText "tofi-config" ''
      # Nordbones-inspired Tofi config (no red, no transparency)

      font = JetBrainsMono Nerd Font
      font-size = 14

      background-color = #111111
      text-color = #f9fbff
      selection-color = #5e81ac 

      outline-width = 0
      border-width = 0

      padding-left = 2%
      padding-top = 2%
      padding-right = 0
      padding-bottom = 0

      width = 20%
      height = 30%

      hide-cursor = true
      prompt-text = ""
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/blazzee/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
      EDITOR = "nvim";
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.kitty = {
   enable = true;
   theme = "Catppuccin-Mocha";
   font = {
	name = "JetBrainsMono Nerd Font";
	size = 14;
   };
   settings = {
      background_opacity = "0.90";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };
}
