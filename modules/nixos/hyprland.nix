{
  pkgs,
  perSystem,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = [
        "https://hyprland.cachix.org"
        "https://vicinae.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
      trusted-substituters = ["https://hyprland.cachix.org"];
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal.extraPortals = [
    perSystem.hyprland.xdg-desktop-portal-hyprland
  ];

  services = {
    gvfs = {
      enable = true;
    };

    gnome.gnome-keyring.enable = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = perSystem.hyprland.hyprland;
    portalPackage = perSystem.hyprland.xdg-desktop-portal-hyprland;
  };

  programs = {
    uwsm.enable = true;

    localsend = {
      enable = true;
      openFirewall = true;
    };

    steam = {
      enable = true;
    };

    _1password.enable = true;
    _1password-gui = with pkgs; {
      enable = true;
      package = _1password-gui-beta;
      polkitPolicyOwners = ["zed"];
    };
    adb.enable = true;
  };

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
}
