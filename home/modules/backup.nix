{config, ...}: let
  homeDir = config.home.homeDirectory;
  resticSecrets = config.age.secrets.restic.path;
  resticPassword = config.age.secrets.restic-password.path;
in {
  services.restic = {
    enable = true;
    backups = {
      remoteBackup = {
        paths = ["${homeDir}"];
        environmentFile = resticSecrets;
        passwordFile = resticPassword;
        repository = "s3:http://10.0.2.3:9000/home-restic";
        exclude = builtins.map (x: homeDir + "/" + x) [
	  ".bun"
	  ".cargo"
	  ".local/share/mise"
	  ".local/share/pnpm"
	  ".local/share/containers"
	  ".rustup"
          ".config/user-share"
          ".cache"
          ".local/share/Steam"
          "Downloads"
          "go"
          "Repositories"
          "dotfiles"
          "nixos"
          "Games"
          ".steam"
          ".local/share/Trash"
          ".var/app"
          "Projects/Programming/Rust/**/target"
        ];
      };
    };
  };
}
