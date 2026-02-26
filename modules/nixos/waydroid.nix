{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  networking.nftables.enable = true;
  services.geoclue2.enable = true;
}
