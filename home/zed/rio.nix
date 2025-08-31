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
      colors = {
        background = "#161616";
        foreground = "#ffffff";
        black = "#262626";
        magenta = "#ff7eb6";
        green = "#42be65";
        yellow = "#ffe97b";
        blue = "#33b1ff";
        red = "#ee5396";
        cyan = "#3ddbd9";
        white = "#dde1e6";
        light-black = "#393939";
        light-magenta = "#ff7eb6";
        light-green = "#42be65";
        light-yellow = "#ffe97b";
        light-blue = "#33b1ff";
        light-red = "#ee5396";
        light-cyan = "#3ddbd9";
        light-white = "#ffffff";
      };
    };
  };
}
