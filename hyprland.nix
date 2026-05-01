{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,1920x1200,0x0,1"
        "HDMI-A-1,1920x1080,auto-right,1.25,"
      ];

      exec-once = [
        "/usr/lib/xdg-desktop-portal-hyprland"
        "waybar &"
        "swww-daemon --format xrgb"
        "swaync &"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      env = [
        "XCURSOR_THEME,Vimix-cursors"
        "XCURSOR_SIZE,32"
        "XDG_SESSION_TYPE,wayland"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 4;
        border_size = 2;
        "col.active_border" = "rgb(b4befe) rgb(f5c2e7) 45deg";
        "col.inactive_border" = "rgb(585b70)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "scrolling";
      };

      plugin = {
        hyprscrolling = {
          fullscreen_on_one_column = true;
          column_width = 0.5;
          focus_fit_method = 1;
          wrap_focus = true;
          wrap_swapcol = true;
          explicit_column_widths = "0.33, 0.5, 0.66, 1.0";
        };
      };

      misc = {
        focus_on_activate = false;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "0xee1a1a1a";
        };
        blur = {
          enabled = true;
          size = 1;
          passes = 3;
          popups = false;
          vibrancy = 0.85;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
        mfact = 0.60;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      "$mainMod" = "SUPER";
      "$brightness" = "~/.config/scripts/brightness.sh";
      "$volume" = "~/.config/scripts/volume.sh";
      "$browser" = "brave";
      "$terminal" = "kitty";
      "$fileManager" = "$terminal yazi";
      "$menu" = "rofi -show drun";

      bind = [
        "$mainMod,return,exec,$terminal"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, R , exec , ~/.config/scripts/zellij.sh"
        "$mainMod, T , exec , pkill waybar ; waybar &"
        "$mainMod, B, exec, $browser"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT , Q , exit,"
        "$mainMod, Y, togglefloating,"
        "$mainMod, X, exec , ~/.config/rofi/powermenu/powermenu.sh"
        "$mainMod, P, pseudo,"
        "$mainMod, SPACE, togglesplit,"
        "$mainMod, Z , fullscreen"
        "$mainMod , O , exec, $menu"

        # Focus and Movement
        "$mainMod, h, layoutmsg, focus l"
        "$mainMod, l, layoutmsg, focus r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"
        "$mainMod SHIFT, S, movetoworkspacesilent, special"
        "$mainMod , w , togglespecialworkspace, 10"

        # Swapping and Organising
        "SUPER SHIFT, h, layoutmsg, swapcol l"
        "SUPER SHIFT, l, layoutmsg, swapcol r"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, j, movewindow, d"

        # Resizing
        "SUPER CTRL, h, layoutmsg, colresize -conf"
        "SUPER CTRL, l, layoutmsg, colresize +conf"
        "SUPER CTRL, j, resizeactive, 0 -20"
        "SUPER CTRL, k, resizeactive, 0 20"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        "$mainMod, Q , workspace, e+1"
        "$mainMod, E, workspace, e-1"

        "$mainMod, M, layoutmsg, promote"
        "$mainMod, A, layoutmsg, fit active"
        "$mainMod, comma, layoutmsg, move -col"
        "$mainMod, period, layoutmsg, move +col"

        ",Print, exec, grim ~/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send 'Screenshot Captured' 'Saved to ~/Pictures'"
        "Shift,Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot_area_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send 'Screenshot Captured' 'Area screenshot saved to ~/Pictures'"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, $volume inc"
        ",XF86AudioLowerVolume, exec, $volume dec"
        ",XF86AudioMute, exec, $volume toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, $brightness inc"
        ",XF86MonBrightnessDown, exec,$brightness dec"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrulev2 = [
        "workspace 1, class:^(kitty)$"
        "float, class:^(org\\.stronnag\\.wayfarer)$"
        "size 533 215, class:^(org\\.stronnag\\.wayfarer)$"
        "workspace 2, class:^(Brave-browser)$"
        "workspace 5, class:^(Spotify)$"
      ];

      layerrule = [
        "blur, waybar"
        "ignorealpha 0.5, waybar"
        "blur, swaync-control-center"
        "ignorealpha 0.5, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorealpha 0.5, swaync-notification-window"
      ];

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
          "mac_ease, 0.25, 0.1, 0.25, 1"
        ];
        animation = [
          "windows, 1, 1.5, md3_decel, popin 60%"
          "windowsIn, 1, 1.5, md3_decel, popin 60%"
          "windowsOut, 1, 1.5, md3_accel, popin 60%"
          "border, 1, 5, default"
          "fade, 1, 1.5, md3_decel"
          "layersIn, 1, 1.5, menu_decel, slide"
          "layersOut, 1, 1.5, menu_accel"
          "fadeLayersIn, 1, 1.5, menu_decel"
          "fadeLayersOut, 1, 2.0, menu_accel"
          "workspaces, 1, 5.5, mac_ease, slide"
          "specialWorkspace, 1, 2, md3_decel, slidevert"
        ];
      };
    };
  };
}
