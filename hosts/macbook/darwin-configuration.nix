{
  pkgs,
  flake,
  ...
}: let
  user = "zed";
  in
{
  imports = [
    flake.darwinModules.netbird
    flake.darwinModules.browser
    flake.darwinModules.onepassword
  ];

  system.primaryUser = user;

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    neovim
    rectangle
    ice-bar
    localsend
    rquickshare
    raycast
  ];

  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
    pkgs.fish
  ];

  users.users.${user} = {
    home = /Users/${user};
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
