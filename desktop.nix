{ config, lib, pkgs, ... }:

{
    services.displayManager.ly.enable = true;
    programs.uwsm.enable = true;
    programs.hyprland = {
        enable = true;
        withUWSM = true;
    };
}
