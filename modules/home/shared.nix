{
  pkgs,
  flake,
  inputs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.base16.homeManagerModule
    { scheme = "${inputs.tt-schemes}/base16/oxocarbon-dark.yaml"; }
  ];

  fonts.fontconfig.enable = true;

  home.shell.enableFishIntegration = true;
  home.stateVersion = "25.05"; # initial home-manager state
}
