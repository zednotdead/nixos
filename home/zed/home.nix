{
  lib,
  config,
  pkgs,
  ...
}: {
  home.username = "zed";
  home.homeDirectory = "/home/zed";
  home.stateVersion = "25.05";
  imports = [
    ./calendar.nix
    ./contacts.nix
    ./email.nix
    ./hyprland.nix
    ./rio.nix
  ];
}
