{
  config,
  pkgs,
  pkgs-unstable,
  niriEnabled,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./niri.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "blazzee";
  home.homeDirectory = "/home/blazzee";
  programs.waybar.enable = true;
  programs.helix.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.eza.icons = "always";
  services.swww.enable = true;
  services.dunst.enable = false;
  programs.zsh = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      y = "yazi";
      nih = "home-manager switch --flake .";
      nir = "sudo nixos-rebuild switch --flake .";
    };
    initContent = ''
      # Make Alt+Backspace delete backward word
      bindkey '^[^?' backward-kill-word
      bindkey '^[\b' backward-kill-word
      if [ -f ~/.config/secrets/env ]; then
        source ~/.config/secrets/env
      fi
      export LANG=en_US.UTF-8
    '';
  };

  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.starship.enable = false;
  nixpkgs.config.allowUnfree = true;

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = pkgs.writeText "omp-config.toml" ''
      version = 4
      final_space = true

      [palette]
        blue = '#8CAAEE'
        lavender = '#BABBF1'
        os = '#ACB0BE'
        pink = '#F4B8E4'

      [transient_prompt]
        template = " $ "
        foreground = "#ffffff"
        background = "transparent"

      [[blocks]]
        type = "prompt"
        alignment = "left"

        [[blocks.segments]]
          type = "os"
          style = "plain"
          template = "┌ 󰣇 "
          foreground = "p:os"

        [[blocks.segments]]
          type = "path"
          style = "plain"
          template = "{{ .Path }} "
          foreground = "p:pink"

          [blocks.segments.properties]
            style = "full"
            folder_icon = ""
            home_icon = "~"
            compact = false

        [[blocks.segments]]
          type = "git"
          style = "plain"
          template = "{{ .HEAD }} "
          foreground = "p:lavender"

          [blocks.segments.properties]
            branch_icon = " "
            commit_icon = " "
            merge_icon = " "
            rebase_icon = " "
            revert_icon = " "
            tag_icon = " "
            cherry_pick_icon = " "
            no_commits_icon = " "
            fetch_status = false
            fetch_upstream_icon = false

      [[blocks]]
        type = "prompt"
        alignment = "left"
        newline = true

        [[blocks.segments]]
          type = "text"
          style = "plain"
          template = "└ "
          foreground = "p:os"

        [[blocks.segments]]
          type = "text"
          style = "plain"
          template = "$"
          foreground = "#ffffff"
    '';
  };
  programs.rofi.enable = true;
  programs.zellij.enable = true;
  programs.yazi.enable = true;
  programs.eza.enableZshIntegration = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

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
    fd
    lazygit
    brave
    catppuccin-gtk
    nwg-look
    btop
    dunst
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Macchiato-Compact-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "macchiato";
        accents = ["lavender"];
        size = "compact";
        tweaks = ["rimless" "black"];
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Proper GTK4 theming on Wayland (required!)
  xdg.configFile = {
    "dunst/dunstrc".source = ./dunst/dunstrc;
    "gtk-4.0/assets" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      force = true;
    };

    "gtk-4.0/gtk.css" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      force = true;
    };

    "gtk-4.0/settings.ini" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/settings.ini";
      force = true;
    };

    "gtk-4.0/gtk-dark.css" = {
      source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      force = true;
    };
  };

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

  home.file.".config/helix" = {
    source = ./helix;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.file.".config/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  # swaync kept in repo but not enabled (using dunst instead)

  home.file.".config/rofi" = {
    source = ./rofi;
    recursive = true;
  };

  home.file.".config/zellij" = {
    source = ./zellij;
    recursive = true;
  };

  home.file.".config/niri" = lib.mkIf niriEnabled {
    source = ./niri;
    recursive = true;
    force = true;
  };

  home.file.".config/waybar-niri" = lib.mkIf niriEnabled {
    source = ./waybar-niri;
    recursive = true;
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
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    settings = {
      background = "#000000";
      background_opacity = "0.65";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      hide_window_decorations = "yes";
    };
    keybindings = {
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+t" = "new_tab_with_cwd";
    };
  };
}
