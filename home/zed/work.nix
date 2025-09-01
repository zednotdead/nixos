{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.username = "zbigniew.zolnierowicz";
  home.homeDirectory = "/Users/zed";
  home.stateVersion = "25.05";

  imports = [
    ./wezterm.nix
    ./shell.nix
  ];
}
