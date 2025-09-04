{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "Iosevka";
      size = 14;
    };
    extraConfig = builtins.readFile "${inputs.tt-terminal}/themes/kitty/base16-oxocarbon-dark.conf";
  };
}
