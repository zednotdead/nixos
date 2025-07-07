# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./desktop.nix
      ../../users/zed/config.nix
    ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    style.wallpapers = with pkgs; [
      nixos-artwork.wallpapers.simple-dark-gray-bootloader.gnomeFilePath
    ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.hostName = "pc";
  programs.nix-ld.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  programs.firefox.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    curl
    wget
    kitty
    anyrun
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

