{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    maple-mono.NF
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
           return {
             font = wezterm.font_with_fallback({
        "Maple Mono NF",
      }),
             font_size = 14.0,
             hide_tab_bar_if_only_one_tab = true,
             color_scheme = "oxocarbon-dark"
           }
    '';
    colorSchemes = {
      "oxocarbon-dark" = builtins.fromTOML (
        builtins.readFile (config.scheme {
          template = ''
            background = "#{{base00-hex}}"
            foreground = "#{{base05-hex}}"

            cursor_bg = "#{{base05-hex}}"
            cursor_border = "#{{base05-hex}}"
            cursor_fg = "#{{base00-hex}}"

            selection_bg = "#{{base05-hex}}"
            selection_fg = "#{{base02-hex}}"

            ansi = [
              "#{{base00-hex}}",
              "#{{base08-hex}}",
              "#{{base0B-hex}}",
              "#{{base0A-hex}}",
              "#{{base0D-hex}}",
              "#{{base0E-hex}}",
              "#{{base0C-hex}}",
              "#{{base06-hex}}"
            ]
            brights = [
              "#{{base02-hex}}",
              "#{{base08-hex}}",
              "#{{base0B-hex}}",
              "#{{base0A-hex}}",
              "#{{base0D-hex}}",
              "#{{base0E-hex}}",
              "#{{base0C-hex}}",
              "#{{base07-hex}}"
            ]

            [indexed]
            16 = "#{{base09-hex}}"
            17 = "#{{base0F-hex}}"
            18 = "#{{base01-hex}}"
            19 = "#{{base02-hex}}"
            20 = "#{{base04-hex}}"
            21 = "#{{base05-hex}}"
          '';
        })
      );
    };
  };
}
