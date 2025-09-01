{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.username = "zed";
  home.homeDirectory = "/home/zed";
  home.stateVersion = "25.05";

  imports = [
    ./calendar.nix
    ./contacts.nix
    ./email.nix
    ./hyprland.nix
    ./rio.nix
    ./kitty.nix
    ./wezterm.nix
    ./shell.nix
  ];
}
