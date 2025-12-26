{
  pkgs,
  inputs,
  perSystem,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services = {
    vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
        environment = {
          USE_LAYER_SHELL = 1;
        };
      };
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    udiskie = {
      enable = true;
      tray = "auto";
    };
    tailscale-systray.enable = true;
  };

  home.packages = with pkgs; [
    nautilus
    file-roller
    swww
    networkmanagerapplet
    udiskie
    wl-clipboard
    gimp
    localsend
    keymapp
    ungoogled-chromium
    realvnc-vnc-viewer
    signal-desktop-bin
    (prismlauncher.override {
      additionalLibs = [vlc];
      additionalPrograms = [vlc];
    })
    perSystem.self.glide-browser
    onlyoffice-desktopeditors
    picard
    nexusmods-app-unfree
  ];

  programs = {
    zathura.enable = true;
    pqiv = {
      enable = true;
      package = perSystem.nixpkgs-stable.pqiv;
    };

    librewolf = {
      enable = true;
      package = perSystem.nixpkgs-stable.librewolf;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
        pkgs._1password-gui-beta
      ];
    };
  };
}
