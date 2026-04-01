{
  inputs,
  ...
}:
let
  pkgs = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
in
{
  home.packages = with pkgs; [ discord ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
