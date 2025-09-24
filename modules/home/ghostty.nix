{
  pkgs,
  config,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = config.scheme.slug;
      font-family = "Maple Mono NF";
      font-size = 14;
      window-padding-x = 10;
      window-padding-y = 10;
    };
    themes = {
      "${config.scheme.slug}" = with config.scheme.withHashtag; {
        palette = [
          "0=${base00}"
          "1=${base08}"
          "2=${base0B}"
          "3=${base0A}"
          "4=${base0D}"
          "5=${base0E}"
          "6=${base0C}"
          "7=${base05}"
          "8=${base02}"
          "9=${base08}"
          "10=${base0B}"
          "11=${base0A}"
          "12=${base0D}"
          "13=${base0E}"
          "14=${base0C}"
          "15=${base07}"
          "16=${base09}"
          "17=${base0F}"
          "18=${base01}"
          "19=${base02}"
          "20=${base04}"
          "21=${base06}"
        ];

        background = base00;
        foreground = base05;
        cursor-color = base05;
        selection-background = base02-hex;
        selection-foreground = base05-hex;
        macos-icon-ghost-color = base07;
        macos-icon-screen-color = base0D;
      };
    };
  };
}
