{ config, lib, pkgs, ... }:

{
  users.users.zed = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      kitty
      wofi
      librewolf-bin
      _1password-gui-beta
      _1password-cli
      discord
    ];
    shell = pkgs.fish;
  };
}
