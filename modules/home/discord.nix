{ pkgs, ... }:
{
  home.packages =
    if pkgs.stdenv.isLinux then
      with pkgs;
      [
        (discord-canary.override {
          withOpenASAR = true;
        })
      ]
    else
      with pkgs; [ discord-canary ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
