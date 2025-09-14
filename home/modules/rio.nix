{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    rio
    aporetic
    imgcat
    timg
  ];

  programs.rio = {
    enable = true;
    settings = {
      renderer = {
        level = 1;
      };
      fonts = {
        size = 18;
        family = "Maple Mono NF";
        features = ["calt"];
      };
      padding-x = 0;
      padding-y = [0 0];
      inherit
        ((
          builtins.fromTOML (
            builtins.readFile "${inputs.tt-terminal}/themes-16/rio/base16-oxocarbon-dark.toml"
          )
        ))
        colors
        ;
    };
  };
}
