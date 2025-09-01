{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.username = "zed";
  home.homeDirectory = "/home/zed";
  home.stateVersion = "25.05";

  programs.alacritty.enable = true;
  programs.alacritty.settings.colors =
    with config.scheme.withHashtag; let default = {
        black = base00; white = base07;
        inherit red green yellow blue cyan magenta;
      };
    in {
      primary = { background = base00; foreground = base07; };
      cursor = { text = base02; cursor = base07; };
      normal = default; bright = default; dim = default;
    };

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
