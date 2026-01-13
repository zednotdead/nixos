{ pkgs, ... }:
{
  home.packages = with pkgs; [ discord-canary ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
