{ inputs, pkgs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [ pywalfox-native ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
  };
}
