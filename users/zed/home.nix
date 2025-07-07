{ config, pkgs, ... }:

{
  home.username = "zed";
  home.homeDirectory = "/home/zed";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    htop
    fortune
    wayfreeze
    slurp
    grim
    hyprpaper
    prismlauncher
  ];
  services.hyprpaper.enable = true;

  programs.kitty.enable = true;
  programs.kitty.font.name = "PragmataPro Mono Liga";
  programs.kitty.font.size = 15;
  programs.kitty.themeFile = "gruvbox-dark-hard";

  programs.home-manager.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  xdg.configFile."hypr/autostart.conf".source = ./hyprland/autostart.conf;
  xdg.configFile."hypr/rules/1password.conf".source = ./hyprland/rules/1password.conf;
  xdg.configFile."hypr/rules/firefox.conf".source = ./hyprland/rules/firefox.conf;
  xdg.configFile."hypr/rules/pcmanfm.conf".source = ./hyprland/rules/pcmanfm.conf;

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 48;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
                name = name;
                extension = "zip";
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://drive.usercontent.google.com/download?id=1U8SdXgFTem9KuigARRTVcp-MD3LlAWuo&confirm=t"
        "sha256-u6nOtDagGd5q1be3UC2gxreMwViEUkr9QgSJHgrIX4c="
        "Patchouli";

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    plugins = [
      (pkgs.callPackage ./hyprland/plugins/hyprNStack.nix {})
    ];
    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
      };
      misc = {
        vrr = 1;
        vfr = true;
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 3, myBezier"
          "windowsOut, 1, 3, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
          "specialWorkspace, 1, 3, myBezier, slidevert"
        ];
      };
      plugin = {
        nstack = {
          layout = {
            orientation = "orientationhcenter";
            new_on_top = 0;
            new_is_master = 0;
            no_gaps_when_only = 0;
            special_scale_factor = 0.9;
            inherit_fullscreen = 1;
            stacks = 3;
            center_single_master = 1;
            mfact = 0.5;
          };
        };
      };
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, E, exec, nautilus"
        "$mod, F, exec, firefox"
        "$mod, V, togglefloating"
        "$mod, D, exec, anyrun"
        "$mod, P, pseudo"
        "$mod, S, togglesplit"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod SHIFT, h, swapwindow, l"
        "$mod SHIFT, l, swapwindow, r"
        "$mod SHIFT, k, swapwindow, u"
        "$mod SHIFT, j, swapwindow, d"
        "$mod, m, layoutmsg, swapwithmaster"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        ", Print, exec, wayfreeze & PID=$!; sleep .1; grim -g \"$(slurp)\" - | wl-copy; kill $PID"
        "$mod SHIFT, C, movetoworkspace, special"
        "$mod, C, togglespecialworkspace"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
        9)
      );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
    extraConfig = ''
      source = ./autostart.conf
      source = ./rules/1password.conf
      source = ./rules/firefox.conf
      source = ./rules/pcmanfm.conf
    '';
  };

  home.stateVersion = "25.05";
}

