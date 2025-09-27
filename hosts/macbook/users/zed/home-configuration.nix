{
  flake,
  ...
}:
let
  username = "zed";
  homeDir = "/Users/${username}";
in
{
  imports = [
    flake.homeModules.shared
    # flake.homeModules.wezterm
    flake.homeModules.shell
    # flake.homeModules.hyprland
    # flake.homeModules.quickshell
    flake.homeModules.nvim
    flake.homeModules.minio
    flake.homeModules.calendar
    flake.homeModules.contacts
    flake.homeModules.email
    # flake.homeModules.media
    # flake.homeModules.backup
    flake.homeModules.obsidian
    flake.homeModules.ghostty
    flake.homeModules.matrix
    # flake.homeModules.niri
    flake.homeModules.discord
  ];

  home.username = username;

  age = {
    identityPaths = [ "${homeDir}/.ssh/id_ed25519" ];
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
