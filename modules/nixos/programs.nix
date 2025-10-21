{pkgs, ...}: {
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
    };

    _1password.enable = true;
    _1password-gui = with pkgs; {
      enable = true;
      package = _1password-gui-beta;
      polkitPolicyOwners = ["zed"];
    };
  };
}
