# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      inherit
        (final.lixPackageSets.stable)
        nixpkgs-review
        nix-direnv
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  imports = [./hardware-configuration.nix];

  programs.nix-ld.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = ["pl_PL.UTF-8/UTF-8"];
  i18n.extraLocaleSettings = {
    # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
    LC_CTYPE = "en_US.UTF8";
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MESSAGES = "en_US.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
    LC_COLLATE = "pl_PL.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "pl";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.printing.enable = true;
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    stow
    greetd.tuigreet
    gnumake
    postgresql
    dig
    rustup
    gcc
    networkmanagerapplet
    docker-compose
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  powerManagement.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
