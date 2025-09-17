# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        inherit
          (final.lixPackageSets.git)
          nixpkgs-review
          nix-direnv
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };

  nix = {
    package = pkgs.lixPackageSets.git.lix;

    settings = {
      builders-use-substitutes = true;
      substituters = [
        "https://vicinae.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
      trusted-substituters = ["https://hyprland.cachix.org"];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [./hardware-configuration.nix];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "pc";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = ["pl_PL.UTF-8/UTF-8"];
    extraLocaleSettings = {
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
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "pl";
    useXkbConfig = true; # use xkb.options in tty.
  };
  services = {
    printing.enable = true;
    flatpak.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet";
        };
      };
    };
    tailscale = {
      enable = true;
    };
  };

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    stow
    tuigreet
    gnumake
    postgresql
    dig
    rustup
    gcc
    networkmanagerapplet
    docker-compose
    inputs.agenix.packages.${pkgs.system}.default
  ];

  programs = {
    nix-ld.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  powerManagement.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  age.secrets.zed-password.file = ../../secrets/zed-password.age;

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
