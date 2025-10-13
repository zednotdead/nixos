{
  config,
  perSystem,
  lib,
  pkgs,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [
    ../programs.nix
    ./shell.nix
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome-themes-extra;
      name = "Adwaita-dark";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita-dark";
    };
  };

  home.packages = with pkgs; [ xwayland-satellite ];

  programs.niri.package = perSystem.niri.niri-unstable;

  programs.niri.settings =
    let
      mouse-cooldown = 150;
    in
    {
      prefer-no-csd = true;
      spawn-at-startup = [
        { argv = [ "swww-daemon" ]; }
        {
          argv = [
            "qs"
            "-d"
          ];
        }
        { argv = [ "steam" ]; }
        {
          argv = [
            "dms"
            "run"
            "-d"
          ];
        }
        { argv = [ "thunderbird" ]; }
      ];

      workspaces = {
        "01" = {
          open-on-output = "DP-1";
          name = "main";
        };
        "02" = {
          open-on-output = "DP-1";
          name = "games";
        };
        "03" = {
          open-on-output = "DP-1";
          name = "mail";
        };
        "04".open-on-output = "DP-1";
        "05".open-on-output = "DP-1";

        "06" = {
          open-on-output = "HDMI-A-1";
          name = "media";
        };
        "07".open-on-output = "HDMI-A-1";
        "08".open-on-output = "HDMI-A-1";
        "09".open-on-output = "HDMI-A-1";
        "10".open-on-output = "HDMI-A-1";
      };

      window-rules = [
        {
          matches = [
            { app-id = "thunderbird"; }
          ];
          open-on-workspace = "mail";
        }
        {
          matches = [
            { app-id = "steam"; }
          ];
          open-on-workspace = "games";
        }
      ];

      outputs = {
        "DP-1" = {
          mode.width = 2560;
          mode.height = 1440;
          focus-at-startup = true;
          position = {
            x = 0;
            y = 0;
          };
        };

        "HDMI-A-1" = {
          focus-at-startup = false;
          position = {
            x = 2560;
            y = 0;
          };
        };
      };
      cursor = {
        size = 24;
        theme = "Tachy";
      };

      input = {
        keyboard = {
          xkb.layout = "pl";
          numlock = true;
        };
      };

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+Return" = {
          action = spawn "ghostty";
          hotkey-overlay.title = "Spawn terminal (ghostty)";
        };
        "Mod+D" = {
          action = spawn [
            "vicinae"
            "toggle"
          ];
          hotkey-overlay.title = "Spawn application launcher (vicinae)";
        };
        XF86AudioRaiseVolume = {
          allow-when-locked = true;
          action.spawn = noctalia "volume increase";
        };
        XF86AudioLowerVolume = {
          allow-when-locked = true;
          action.spawn = noctalia "volume decrease";
        };
        XF86AudioMute = {
          allow-when-locked = true;
          action.spawn = noctalia "volume muteOutput";
        };
        XF86AudioMicMute = {
          allow-when-locked = true;
          action.spawn = noctalia "volume muteInput";
        };

        "Mod+Shift+Q" = {
          action = close-window;
          repeat = false;
        };

        "Mod+Left".action = focus-column-or-monitor-left;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Right".action = focus-column-or-monitor-right;
        "Mod+H".action = focus-column-or-monitor-left;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-or-monitor-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+Ctrl+Left".action = focus-monitor-left;
        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+H".action = focus-monitor-left;
        "Mod+Ctrl+L".action = focus-monitor-right;

        "Mod+Ctrl+Shift+Left".action = move-window-to-monitor-left;
        "Mod+Ctrl+Shift+Right".action = move-window-to-monitor-right;
        "Mod+Ctrl+Shift+H".action = move-window-to-monitor-left;
        "Mod+Ctrl+Shift+L".action = move-window-to-monitor-right;

        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;

        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+WheelScrollDown" = {
          cooldown-ms = mouse-cooldown;
          action = focus-column-right;
        };

        "Mod+WheelScrollUp" = {
          cooldown-ms = mouse-cooldown;
          action = focus-column-left;
        };

        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = mouse-cooldown;
          action = move-column-right;
        };

        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = mouse-cooldown;
          action = move-column-left;
        };

        "Mod+1".action = focus-workspace "main";
        "Mod+2".action = focus-workspace "games";
        "Mod+3".action = focus-workspace "mail";
        "Mod+4".action = focus-workspace "04";
        "Mod+5".action = focus-workspace "05";
        "Mod+6".action = focus-workspace "media";
        "Mod+7".action = focus-workspace "07";
        "Mod+8".action = focus-workspace "08";
        "Mod+9".action = focus-workspace "09";
        "Mod+0".action = focus-workspace "10";

        "Mod+Shift+1".action.move-column-to-workspace = "main";
        "Mod+Shift+2".action.move-column-to-workspace = "games";
        "Mod+Shift+3".action.move-column-to-workspace = "mail";
        "Mod+Shift+4".action.move-column-to-workspace = "04";
        "Mod+Shift+5".action.move-column-to-workspace = "05";
        "Mod+Shift+6".action.move-column-to-workspace = "media";
        "Mod+Shift+7".action.move-column-to-workspace = "07";
        "Mod+Shift+8".action.move-column-to-workspace = "08";
        "Mod+Shift+9".action.move-column-to-workspace = "09";
        "Mod+Shift+0".action.move-column-to-workspace = "10";

        "Mod+Comma".action = consume-or-expel-window-left;
        "Mod+Period".action = consume-or-expel-window-right;

        "Mod+O".action = toggle-overview;
        "Mod+T".action = toggle-column-tabbed-display;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Ctrl+R".action = switch-preset-window-height;
        "Mod+Shift+R".action = reset-window-height;

        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;

        "Mod+N".action = set-column-width "-10%";
        "Mod+M".action = set-column-width "+10%";

        "Mod+Shift+N".action = set-window-height "-10%";
        "Mod+Shift+M".action = set-window-height "+10%";

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Print".action = screenshot;
        "Shift+Print".action = screenshot-window;

        "Mod+Escape" = {
          allow-inhibiting = false;
          action = toggle-keyboard-shortcuts-inhibit;
        };

        "Mod+Ctrl+Q".action.spawn = noctalia "lockScreen toggle";
        "Mod+P".action.spawn = noctalia "controlCenter toggle";

        "Mod+Shift+E".action = quit;
      };

      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite;
      };
    };
}
