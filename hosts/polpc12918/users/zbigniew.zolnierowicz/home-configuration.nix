{
  inputs,
  flake,
  ...
}: let
  username = "zbigniew.zolnierowicz";
  homeDir = "/Users/${username}";
in {
  imports = [
    flake.homeModules.shared
    flake.homeModules.wezterm
    flake.homeModules.nvim
    flake.homeModules.shell
  ];

  home.username = username;
  home.homeDirectory = homeDir;

  age = {
    identityPaths = ["${homeDir}/.ssh/id_ed25519"];
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
