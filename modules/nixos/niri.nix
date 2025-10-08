{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
  ];

  nix = {
    settings = {
      substituters = [
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
    };
  };

  programs.niri.enable = true;

  niri-flake.cache.enable = true;
}
