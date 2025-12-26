{
  pkgs,
  inputs,
  flake,
  config,
  lib,
  perSystem,
  ...
}:
{
  imports = [
    inputs.base16.nixosModule
    { scheme = "${inputs.tt-schemes}/base16/rose-pine.yaml"; }
    inputs.agenix.nixosModules.default
    inputs.chaotic.nixosModules.default
    # flake.nixosModules.hyprland
    flake.nixosModules.niri
    flake.nixosModules.programs
    flake.nixosModules.lix
    flake.nixosModules.nh
    flake.nixosModules.tablet
    flake.nixosModules.wine
    flake.nixosModules.uutils
    flake.nixosModules.waydroid
    flake.nixosModules.bluetooth
    ./hardware-configuration.nix
  ];

  nix.settings.trusted-users = [
    "root"
    "zed"
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "pc";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  programs.fish.enable = true;

  age.secrets.zed-password.file = ../../secrets/zed-password.age;
  security.pam.services.greetd.enableGnomeKeyring = true;
  hardware.keyboard.zsa.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "pl_PL.UTF-8/UTF-8" ];
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
    scx.enable = true;
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
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
    perSystem.agenix.default
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

  users = {
    mutableUsers = false;
    users.zed = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "wheel"
        "kvm"
        "adbusers"
        "wireshark"
      ]; # Enable ‘sudo’ for the user.
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
        (
          (ffmpeg-full.override {
            withUnfree = true; # Allow unfree dependencies (for Nvidia features notably)
            withMetal = false; # Use Metal API on Mac. Unfree and requires manual downloading of files
            withMfx = false; # Hardware acceleration via the deprecated intel-media-sdk/libmfx. Use oneVPL instead (enabled by default) from Intel's oneAPI.
            withTensorflow = false; # Tensorflow dnn backend support (Increases closure size by ~390 MiB)
            withSmallBuild = false; # Prefer binary size to performance.
            withDebug = false; # Build using debug options
          }).overrideAttrs
          (_: {
            doCheck = false;
          })
        )
        home-manager
      ];
      shell = pkgs.fish;
    };
  };

  system.stateVersion = "25.11"; # initial nixos state
}
