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
  home = {
    username = "zed";
    homeDirectory = homeDir;
    stateVersion = "25.05";
    shell.enableFishIntegration = true;
  };

  age = {
    identityPaths = ["${homeDir}/.ssh/id_ed25519"];
    secretsDir = "/run/user/${userId}/agenix";
    secrets = {
      newsboat-password = {
        file = ../secrets/newsboat.age;
      };
      restic = {
        file = ../secrets/restic.age;
      };
      restic-password = {
        file = ../secrets/restic-password.age;
      };
    };
  };

  imports = [
    ./modules/calendar.nix
    ./modules/contacts.nix
    ./modules/email.nix
    ./modules/hyprland
    ./modules/quickshell.nix
    ./modules/rio.nix
    ./modules/kitty.nix
    ./modules/wezterm.nix
    ./modules/shell.nix
    ./modules/backup.nix
    ./modules/minio.nix
    ./modules/nvim
    ./modules/matrix.nix
    ./modules/media.nix
  ];
}
