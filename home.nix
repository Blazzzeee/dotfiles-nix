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
  services.swaync.enable = true;
  wayland.windowManager.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.neovim.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.starship.enable = true;
  programs.rofi.enable = true;
  programs.zellij.enable = true;


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
  fd
  lazygit
  brave
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
    ".config/helix/config.toml" = {
      text = ''
          theme = "nyxvamp-veil"
          # theme = "rose_pine"

          [editor]
          line-number = "relative"
          end-of-line-diagnostics = "hint"
          [editor.inline-diagnostics]
          cursor-line = "warning" # show warnings and errors on the cursorline inline

          [keys.normal]
          esc = ["collapse_selection", "keep_primary_selection"]
          S-r = [":config-reload"] 
          - = [
            ':sh rm -f /tmp/unique-file',
            ':insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file',
            ':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty',
            ':open %sh{cat /tmp/unique-file}',
            ':redraw',
          ]
          # f t = ":sh alacritty"  

          [editor.file-picker]
          hidden = true
          git-ignore = true

          [editor.indent-guides]
          render = true
          character = "|"
          skip-levels = 1
          render-blank-lines = true
        '';
    };
    ".config/helix/languages.toml" = {
      text = ''
          [language-server.scls]
          command = "simple-completion-language-server"

          [language-server.scls.config]
          feature_words = true
          feature_snippets = true
          snippets_first = true
          snippets_inline_by_word_tail = false
          feature_unicode_input = false
          feature_paths = false
          feature_citations = false

          [language-server.scls.environment]
          RUST_LOG = "info,simple-completion-language-server=info"
          LOG_FILE = "/tmp/completion.log"

          [[language]]
          name = "c"
          auto-format = false
          language-id = "c"
          language-servers = ["clangd"]


          [[language]]
          name = "python"
          auto-format = false
          language-id = "python"
          language-servers = ["ruff-lsp", "pyright", "scls"]
          file-types = ["py", "pyi", "pyx"]

          # TypeScript
          [[language]]
          name = "typescript"
          file-types = ["ts"]
          roots = ["package.json", "tsconfig.json", "jsconfig.json"]
          language-servers = ["ts_ls"]

          # TypeScript React
          [[language]]
          name = "tsx"
          file-types = ["tsx"]
          roots = ["package.json", "tsconfig.json", "jsconfig.json"]
          language-servers = ["ts_ls", "emmet_ls"]

          # JavaScript
          [[language]]
          name = "javascript"
          file-types = ["js"]
          roots = ["package.json", "tsconfig.json", "jsconfig.json"]
          language-servers = ["ts_ls"]

          # JavaScript React
          [[language]]
          name = "jsx"
          file-types = ["jsx"]
          roots = ["package.json", "tsconfig.json", "jsconfig.json"]
          language-servers = ["ts_ls", "emmet_ls"]

          # Emmet LSP
          [language-server.emmet_ls]
          command = "emmet-language-server"
          args = ["--stdio"]

          # TypeScript LSP
          [language-server.ts_ls]
          command = "typescript-language-server"
          args = ["--stdio"]


          [language-server.ruff-lsp]
          command = "ruff server"


          # Ruby
          [[language]]
          name = "ruby"
          file-types = ["rb", "rake", "gemspec", "ru", "thor", "erb"]
          roots = ["Gemfile"]
          language-servers = ["ruby-lsp"]
          auto-format = false

          # Ruby LSP (uses global binary; bundler fallback handled via Gemfile inclusion)
          [language-server.ruby-lsp]
          command = "ruby-lsp"
          required-root-patterns = ["Gemfile"]
          config = { formatter = "standard" }
        '';
    };
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

  home.file.".config/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  home.file.".config/swaync" = {
    source = ./swaync;
    recursive = true;
  };

  home.file.".config/rofi" = {
    source = ./rofi;
    recursive = true;
  };

  home.file.".config/zellij" = {
    source = ./zellij;
    recursive = true;
  };

programs.sherlock = {
  enable = true;

  # to run sherlock as a daemon
  systemd.enable = true;

  # If wanted, you can use this line for the _latest_ package. / Otherwise, you're relying on nixpkgs to update it frequently enough.
  # For this to work, make sure to add sherlock as a flake input!
  # package = inputs.sherlock.packages.${pkgs.system}.default;

  # config.toml
  settings = {};

  # sherlock_alias.json
  aliases = {
    vesktop = { name = "Discord"; };
  };

  # sherlockignore
  ignore = ''
    Avahi*
  '';

  # fallback.json
  launchers = [
    {
      name = "Calculator";
      type = "calculation";
      args = {
        capabilities = [
          "calc.math"
          "calc.units"
        ];
      };
      priority = 1;
    }
    {
      name = "App Launcher";
      type = "app_launcher";
      args = {};
      priority = 2;
      home = "Home";
    }
  ];

  # main.css
  style = /* css */ ''
    * {
      font-family: sans-serif;
    }
  '';
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
