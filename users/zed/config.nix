{ config, lib, pkgs, ... }:

{
  users.users.zed = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  home-manager.users.zed = ./home.nix;
  home-manager.backupFileExtension = "bak";
}
