# treefmt.nix
{...}: {
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
  programs.taplo.enable = true;
  programs.statix = {
    enable = true;
    disabled-lints = [
      "empty_pattern"
    ];
  };
}
