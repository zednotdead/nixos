{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    agenix.url = "github:ryantm/agenix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    base16,
    tt-terminal,
    tt-schemes,
    agenix,
    nixvim,
    systems,
    treefmt-nix,
    nix-index-database,
    ...
  }: let
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    checks = eachSystem (pkgs: {
      formatting = treefmtEval.${pkgs.system}.config.build.check self;
    });
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        base16.nixosModule
        {scheme = "${inputs.tt-schemes}/base16/oxocarbon-dark.yaml";}
        agenix.nixosModules.default
        ./hosts/pc/config.nix
        ./users/zed/config.nix
      ];
    };
    homeConfigurations = {
      "zed" = let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            base16.homeManagerModule
            agenix.homeManagerModules.default
	    nix-index-database.homeModules.nix-index
            {scheme = "${inputs.tt-schemes}/base16/oxocarbon-dark.yaml";}
            ./home/zed.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      "zbigniew.zolnierowicz" = let
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages.${system};
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            base16.homeManagerModule
            agenix.homeManagerModules.default
	    nix-index-database.homeModules.nix-index
            {scheme = "${inputs.tt-schemes}/base16/oxocarbon-dark.yaml";}
            ./home/work.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
    };
  };
}
