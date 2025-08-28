{
  inputs,
  pkgs,
  ...
}: {
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

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
    withUWSM = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal.extraPortals = [
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
  ];

  programs.steam = {
    enable = true;
  };

  services.gvfs = {
    enable = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  programs.gpu-screen-recorder.enable = true;

  users.users.zed = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
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
      hyprpicker
      gpu-screen-recorder-gtk
      alejandra
    ];
    shell = pkgs.fish;
  };
}
