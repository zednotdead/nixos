{ config, lib, pkgs, ... }:

{
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    services.udisks2.enable = true;

    programs.hyprland = {
        enable = true;
        withUWSM = true;
    };

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
        # hyprpm
        swaynotificationcenter
        udiskie
        waybar
        waypaper
        anyrun
        wl-clipboard
        discord
    ];
}
