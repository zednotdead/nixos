{
  flake,
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
    flake.homeModules.wezterm
    flake.homeModules.shell
    flake.homeModules.hyprland
    flake.homeModules.quickshell
    flake.homeModules.nvim
    flake.homeModules.minio
    flake.homeModules.calendar
    flake.homeModules.contacts
    flake.homeModules.email
    flake.homeModules.media
    flake.homeModules.backup
    flake.homeModules.obsidian
    flake.homeModules.ghostty
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
