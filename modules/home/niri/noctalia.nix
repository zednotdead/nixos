{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = with pkgs; [
    qt6Packages.qt6ct
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };
}
