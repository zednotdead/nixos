{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    tt-terminal = {
      url = "github:tinted-theming/tinted-terminal";
      flake = false;
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    base16,
    ...
  }: {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        home-manager.nixosModules.home-manager
        base16.nixosModule
        {scheme = "${inputs.tt-schemes}/base16/oxocarbon-dark.yaml";}
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zed = ./home/zed/home.nix;
        }
        ./hosts/pc/config.nix
        ./users/zed/config.nix
      ];
    };
  };
}
