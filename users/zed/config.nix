{ inputs, pkgs, lib, ... }:

{
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
  };

  programs.uwsm.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };
  programs.steam = {
    enable = true;
  };

  services.gvfs = {
    enable = true;
  };

  xdg.portal.extraPortals = pkgs.lib.mkForce [
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
  ];

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
      wallust
      swww
      file
      p7zip
      grim
      slurp
      wayfreeze
      gimp
      dconf-editor
      hyprsunset
      hyprpolkitagent
      hyprlock
      wl-clipboard
      unzip
      kdePackages.qtdeclarative
      brotli
      peazip
      fastfetch
      nil
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      thunderbird
      grimblast
      godot
    ];
    shell = pkgs.fish;
  };
}
