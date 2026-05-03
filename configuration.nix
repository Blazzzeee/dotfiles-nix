# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  hyprlandHmSession = pkgs.stdenv.mkDerivation {
    pname = "hyprland-hm-session";
    version = "1.0";
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cat > $out/share/wayland-sessions/hyprland.desktop <<EOF
      [Desktop Entry]
      Name=Hyprland (HM)
      Comment=Hyprland via Home Manager
      Exec=${config.users.users.blazzee.home}/.nix-profile/bin/Hyprland
      TryExec=${config.users.users.blazzee.home}/.nix-profile/bin/Hyprland
      Type=Application
      DesktopNames=Hyprland
      EOF
    '';
    passthru.providedSessions = ["hyprland"];
  };
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;

  # boot.loader.efi.canTouchEfiVariables = false;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.common.default = "*";
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  services.displayManager.ly.enable = true;
  services.displayManager.sessionPackages = [hyprlandHmSession];

  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.sddm.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.groups.blazzee = {};
  users.users.blazzee = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "blazzee";
    extraGroups = ["networkmanager" "wheel" "video" "bluetooth"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    openssh
    ripgrep
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.openssh.enable = true;
  programs.zsh.enable = true;
  services.tailscale.enable = true;
  programs.nix-ld.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # services.power-profiles-daemon.enable = true;

  networking.networkmanager.wifi.powersave = true;
  services.tlp = {
    enable = true;

    settings = {
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      # Enable radio device wizard behavior
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";

      # Auto-toggle radios based on network
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_CONNECT = "";

      DEVICES_TO_DISABLE_ON_WIFI_CONNECT = "";
      DEVICES_TO_ENABLE_ON_WIFI_CONNECT = "wifi";
    };
  };

  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    xorg.libxcb
    xorg.libX11
    xorg.libXext
    xorg.libXrandr
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXfixes
    xorg.libXi
    xorg.libXrender
    gtk3
    glib
    pango
    cairo
    gdk-pixbuf
    dbus
    alsa-lib
    freetype
    fontconfig
  ];

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      font-awesome
    ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      mesa
      libva
      libva-utils
    ];
  };

  services.dbus.enable = true;
  programs.dconf.enable = true;
}
