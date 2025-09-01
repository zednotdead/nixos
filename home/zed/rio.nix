{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    rio
    aporetic
    iosevka
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
        family = "Iosevka";
        features = ["dlig"];
      };
      padding-x = 0;
      padding-y = [0 0];
      colors =
        (
          builtins.fromTOML (
            builtins.readFile "${inputs.tt-terminal}/themes-16/rio/base16-oxocarbon-dark.toml"
          )
        ).colors;
    };
  };
}
