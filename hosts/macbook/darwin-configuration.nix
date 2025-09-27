{
  pkgs,
  flake,
  ...
}: {
  imports = [
    flake.darwinModules.netbird
    flake.darwinModules.browser
    flake.darwinModules.onepassword
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    rectangle
    ice-bar
    localsend
    rquickshare
    discord
  ];

  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
    pkgs.fish
  ];

  users.users.zed = {
    home = /Users/zed;
    shell = pkgs.fish;
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = flake.rev or flake.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
