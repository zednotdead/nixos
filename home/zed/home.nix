{
  config,
  pkgs,
  ...
}: let
  homeDir = "/home/zed";
in {
  nixpkgs.config.allowUnfree = true;
  home.username = "zed";
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  age = {
    identityPaths = ["${homeDir}/.ssh/id_ed25519"];
    secrets = {
      newsboat-password = {
        file = ../../secrets/newsboat.age;
      };
    };
  };

  imports = [
    ./calendar.nix
    ./contacts.nix
    ./email.nix
    ./hyprland.nix
    ./rio.nix
    ./kitty.nix
    ./wezterm.nix
    ./shell.nix
  ];
}
