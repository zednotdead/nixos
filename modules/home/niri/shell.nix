{
  perSystem,
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];
  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableSpawn = true; # Auto-start DMS with niri
    };
  };
}
