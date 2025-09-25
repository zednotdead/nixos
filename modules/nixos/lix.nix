{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lixPackageSets.git.lix;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
