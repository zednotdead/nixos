{
  flake,
  inputs,
  ...
}:
let
  username = "zed";
  homeDir = "/home/${username}";
  userId = "1000";
in
{
  imports = [
    flake.homeModules.shared
    # flake.homeModules.wezterm
    flake.homeModules.shell
    # flake.homeModules.quickshell
    flake.homeModules.nvim
    flake.homeModules.minio
    flake.homeModules.calendar
    flake.homeModules.contacts
    flake.homeModules.email
    flake.homeModules.media
    flake.homeModules.backup
    flake.homeModules.obsidian
    flake.homeModules.ghostty
    flake.homeModules.matrix
    flake.homeModules.niri
    flake.homeModules.discord
    flake.homeModules.emacs
    flake.homeModules.android-sdk
  ];

  home.username = username;
  home.homeDirectory = homeDir;

  age = {
    identityPaths = [ "${homeDir}/.ssh/id_ed25519" ];
    secretsDir = "/run/user/${userId}/agenix";
    secrets = {
      newsboat-password = {
        file = ../../../../secrets/newsboat.age;
      };
      restic = {
        file = ../../../../secrets/restic.age;
      };
      restic-password = {
        file = ../../../../secrets/restic-password.age;
      };
    };
  };
}
