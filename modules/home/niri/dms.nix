{ inputs, ... }:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.niri
  ];
  programs.dank-material-shell = {
    enable = true;
    niri = {
      enableSpawn = true; # Auto-start DMS with niri
    };
  };
}
