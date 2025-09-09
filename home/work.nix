{...}: let
  homeDir = "/Users/zbigniew.zolnierowicz";
in {
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "zbigniew.zolnierowicz";
    homeDirectory = homeDir;
    stateVersion = "25.05";
    shell.enableFishIntegration = true;
  };

  age = {
    identityPaths = ["${homeDir}/.ssh/id_ed25519"];
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
    ./modules/wezterm.nix
    ./modules/shell.nix
    ./modules/nvim
  ];
}
