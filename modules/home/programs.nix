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
    (prismlauncher.override {
      additionalLibs = [ vlc ];
      additionalPrograms = [ vlc ];
    })
  ];

  programs = {
    zathura.enable = true;
    pqiv.enable = true;

    librewolf = {
      enable = pkgs.stdenv.isLinux;
      nativeMessagingHosts = [
        pkgs.tridactyl-native
      ];
    };
  };
}
