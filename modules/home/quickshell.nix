{
  config,
  pkgs,
  perSystem,
  ...
}: let
  quickshell = perSystem.quickshell.default;
in {
  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/quickshell";
    recursive = true;
  };

  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];
}
