{
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.lixPackageSets.git.lix;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
