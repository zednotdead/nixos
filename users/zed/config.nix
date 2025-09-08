{
  config,
  inputs,
  pkgs,
  ...
}: {

  programs.fish.enable = true;
  programs.command-not-found.enable = true;
  environment.etc."programs.sqlite".source = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
  programs.command-not-found.dbPath = "/etc/programs.sqlite";

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
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

  programs._1password.enable = true;
  programs._1password-gui = with pkgs; {
    enable = true;
    package = _1password-gui-beta;
    polkitPolicyOwners = ["zed"];
  };

  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "$HOME/nixos"; # sets NH_OS_FLAKE variable for you
  };
  
  hardware.keyboard.zsa.enable = true;

  users.mutableUsers = false;

  users.users.zed = {
    isNormalUser = true;
    extraGroups = ["docker" "wheel"]; # Enable ‘sudo’ for the user.
    hashedPasswordFile = config.age.secrets.zed-password.path;
    packages = with pkgs; [
      tree
      file
      p7zip
      unzip
      brotli
      nil
      godot
      alejandra
      pika-backup
      ncpamixer
      (ffmpeg-full.override {
        withUnfree = true; # Allow unfree dependencies (for Nvidia features notably)
        withMetal = false; # Use Metal API on Mac. Unfree and requires manual downloading of files
        withMfx = false; # Hardware acceleration via the deprecated intel-media-sdk/libmfx. Use oneVPL instead (enabled by default) from Intel's oneAPI.
        withTensorflow = false; # Tensorflow dnn backend support (Increases closure size by ~390 MiB)
        withSmallBuild = false; # Prefer binary size to performance.
        withDebug = false; # Build using debug options
      })
      home-manager
    ];
    shell = pkgs.fish;
  };
}
