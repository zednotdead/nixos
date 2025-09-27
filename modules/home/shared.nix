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
    { scheme = "${inputs.tt-schemes}/base16/rose-pine.yaml"; }
  ];

  home.shell.enableFishIntegration = true;
  home.stateVersion = "25.05"; # initial home-manager state
}
