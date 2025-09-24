{
  config,
  pkgs,
  inputs,
  perSystem,
  ...
}:
let
  quickshell = perSystem.quickshell.default;
  vicinae = perSystem.vicinae.default;
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  xdg.configFile."hypr/monitor.conf".source = ./monitors.conf;

  services = {
    vicinae = {
      enable = true;
      autoStart = true;
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    swaync = {
      enable = true;
    };
    
    udiskie = {
      enable = true;
      tray = "auto";
    };
  };

  gtk.enable = true;

  home.packages = with pkgs; [
    kitty
    nautilus
    swww
    networkmanagerapplet
    udiskie
    hyprlock
    grimblast
    wallust
    hyprsunset
    hyprpolkitagent
    hyprlock
    wl-clipboard
    grimblast
    hyprpicker
    hyprprop
    nautilus
    peazip
    discord
    gimp
    localsend
    keymapp
    tailscale-systray
    ungoogled-chromium
    realvnc-vnc-viewer
    (prismlauncher.override {
      additionalLibs = [ vlc ];
      additionalPrograms = [ vlc ];
    })
  ];

  programs = {
    zathura.enable = true;
    pqiv.enable = true;

    librewolf = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    settings = {
      source = [
        "monitor.conf"
        "colors.conf"
      ];
      exec-once = [
        "${pkgs.networkmanagerapplet}/bin/nm-applet &"
        "${pkgs.swww}/bin/swww-daemon"
        "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.discord}/bin/discord"
        "${quickshell}/bin/quickshell"
        "${pkgs.hyprsunset}/bin/hyprsunset"
        "${pkgs.tailscale-systray}/bin/tailscale-systray"
      ];
      "$terminal" = "${pkgs.ghostty}/bin/ghostty";
      "$fileManager" = "${pkgs.nautilus}/bin/nautilus";
      "$menu" = "${vicinae}/bin/vicinae";
      "$mainMod" = "SUPER";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };
      env = [
        "HYPRCURSOR_THEME,hyprTachy"
        "HYPRCURSOR_SIZE,32"
      ];
      decoration = {
        rounding = 0;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };
      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "pl";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod Shift, Q, killactive,"
        "$mainMod Shift, E, exec, uwsm stop"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, O, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod Shift, left, swapwindow, l"
        "$mainMod Shift, right, swapwindow, r"
        "$mainMod Shift, up, swapwindow, u"
        "$mainMod Shift, down, swapwindow, d"
        "$mainMod Shift, h, swapwindow, l"
        "$mainMod Shift, l, swapwindow, r"
        "$mainMod Shift, k, swapwindow, u"
        "$mainMod Shift, j, swapwindow, d"
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
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod Ctrl, Q, exec, ${pkgs.hyprlock}/bin/hyprlock"
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast --freeze copy area"
        "$mainMod, C, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
      ];
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "float, class:librewolf, title:^$"
        "float, class:librewolf, title:^Picture-in-Picture$"
        "move 100% 100%, class:librewolf, title:^$"
        "float, class:1Password"
        "focusonactivate, class:librewolf"
      ];
    };
    sourceFirst = true;
    extraConfig = ''
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

      bindl = , XF86AudioNext, exec, playerctl next
      bindl = , XF86AudioPause, exec, playerctl play-pause
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous

      workspace = 1, monitor:DP-1
      workspace = 2, monitor:DP-1
      workspace = 3, monitor:DP-1
      workspace = 4, monitor:DP-1
      workspace = 5, monitor:DP-1
      workspace = 6, monitor:HDMI-A-1
      workspace = 7, monitor:HDMI-A-1
      workspace = 8, monitor:HDMI-A-1
      workspace = 9, monitor:HDMI-A-1
      workspace = 10, monitor:HDMI-A-1
    '';
  };
}
