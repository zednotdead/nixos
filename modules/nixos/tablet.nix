{ pkgs, perSystem, ... }:
{
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
