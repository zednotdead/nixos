{ perSystem, ... }:
{
  programs.element-desktop = {
    enable = true;
    package = perSystem.nixpkgs-stable.element-desktop;
  };
}
