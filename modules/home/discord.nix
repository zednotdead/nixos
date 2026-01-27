{ pkgs, ... }:
{
  home.packages = with pkgs; [ vesktop ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
