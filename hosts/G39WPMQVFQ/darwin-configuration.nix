{
  pkgs,
  flake,
  ...
}:
let
  user = "zbigniew.zolnierowicz";
in
{
  imports = [
    flake.darwinModules.browser
  ];

  system.primaryUser = user;

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
  nix.settings = {
    # Necessary for using flakes on this system.
    experimental-features = "nix-command flakes";

    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

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
