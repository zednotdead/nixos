{
  perSystem,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = lib.mkAfter [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = lib.mkAfter [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-substituters = lib.mkAfter ["https://hyprland.cachix.org"];
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal.extraPortals = [
    perSystem.hyprland.xdg-desktop-portal-hyprland
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = perSystem.hyprland.hyprland;
    portalPackage = perSystem.hyprland.xdg-desktop-portal-hyprland;
  };

  programs.uwsm.enable = true;
}
