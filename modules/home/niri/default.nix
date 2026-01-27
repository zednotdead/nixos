{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../programs.nix
    # ./dms.nix
    ./noctalia.nix
  ];

  home.packages = with pkgs; [ xwayland-satellite ];

  programs.niri.package = null;

  xdg.configFile."niri/base.kdl".source = ./base.kdl;
  xdg.configFile."niri/binds.kdl".source = ./binds.kdl;
  xdg.configFile."niri/workspaces.kdl".source = ./workspaces.kdl;
  xdg.configFile."niri/config.kdl".text = ''
    include "base.kdl"
    include "binds.kdl"
    include "workspaces.kdl"
    include "noctalia.kdl"

    xwayland-satellite {
      path "${lib.getExe pkgs.xwayland-satellite}";
    }
  '';
}
