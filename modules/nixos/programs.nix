{pkgs, ...}: {
  fonts.packages = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  environment.systemPackages = with pkgs; [
    mangohud
    wineWowPackages.waylandFull
    vulkan-tools
  ];

  services = {
    gvfs = {
      enable = true;
    };

    gnome.gnome-keyring.enable = true;
  };

  programs = {
    localsend = {
      enable = true;
      openFirewall = true;
    };
    adb.enable = true;

    steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    _1password.enable = true;
    _1password-gui = with pkgs; {
      enable = true;
      package = _1password-gui-beta;
      polkitPolicyOwners = ["zed"];
    };
    gamemode.enable = true;
  };
}
