{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services = {
    vicinae = {
      enable = true;
      autoStart = true;
    };

    kdeconnect = {
      enable = true;
      indicator = true;
    };

    udiskie = {
      enable = true;
      tray = "auto";
    };
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
    tailscale-systray
    ungoogled-chromium
    realvnc-vnc-viewer
    signal-desktop-bin
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
        pkgs._1password-gui
      ];
    };
  };
}
