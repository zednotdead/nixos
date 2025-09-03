{
  config,
  pkgs,
  ...
}: let
  homeDir = "/home/zed";
  # FIXME: I gotta do this so that I can use agenix
  userId = "1000";
in {
  nixpkgs.config.allowUnfree = true;
  home.username = "zed";
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  age = {
    identityPaths = ["${homeDir}/.ssh/id_ed25519"];
    secretsDir = "/run/user/${userId}/agenix";
    secrets = {
      newsboat-password = {
        file = ../../secrets/newsboat.age;
      };
      restic = {
        file = ../../secrets/restic.age;
      };
      restic-password = {
        file = ../../secrets/restic-password.age;
      };
    };
  };

  imports = [
    ./calendar.nix
    ./contacts.nix
    ./email.nix
    ./hyprland.nix
    ./quickshell.nix
    ./rio.nix
    ./kitty.nix
    ./wezterm.nix
    ./shell.nix
    ./backup.nix
    ./minio.nix
  ];
}
